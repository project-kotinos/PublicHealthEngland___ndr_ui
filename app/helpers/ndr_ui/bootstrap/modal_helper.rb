module NdrUi
  module Bootstrap
    # This provides bootstrap modal box helper methods
    module ModalHelper
      MODAL_SIZES = %w(sm lg).freeze

      # Creates a Boostrap Modal box.
      #
      # ==== Signatures
      #
      #   bootstrap_modal_box(title, controls, options = {})
      #   bootstrap_modal_box(title, options = {}) do
      #     # controls
      #   end
      #
      # ==== Options
      #
      # * <tt>:size</tt> - Symbol of modal box size. Supported sizes are <tt>:sm</tt>,
      #   <tt>:lg</tt>. By default it will be unset (medium width).
      #
      # ==== Examples
      #
      #   <%= bootstrap_modal_box("New Pear", "Pear form") %>
      #   # =>
      #   <div class="modal-dialog">
      #     <div class="modal-content">
      #       <div class="modal-header">
      #         <h4 class="modal-title">New Pear</h4>
      #       </div>
      #       <div class="modal-body">
      #         Pear form
      #       </div>
      #       <div class="modal-footer">
      #         <button type="button" class="btn btn-default" data-dismiss="modal">
      #           Don't save
      #         </button>
      #         <input name="commit" class="btn-primary btn" data-disable-with="Saving&hellip;"
      #   value="Save" type="submit" />
      #       </div>
      #     </div>
      #   </div>
      def bootstrap_modal_box(title, *args, &block)
        return bootstrap_modal_box(title, capture(&block), *args) if block_given?
        options = args.extract_options!

        content_tag(:div, class: bootstrap_modal_classes(options)) do
          content_tag(:div, class: 'modal-content') do
            content_tag(:div, content_tag(:h4, title, class: 'modal-title'),
                        class: 'modal-header') +
              content_tag(:div, args.first, class: 'modal-body') +
              bootstrap_modal_default_footer
          end
        end
      end

      private

      # Returns the css classes for a bootstrap modal dialog
      def bootstrap_modal_classes(options)
        options = options.stringify_keys

        classes = %w(modal-dialog)
        classes << "modal-#{options['size']}" if MODAL_SIZES.include?(options['size'])
        classes.join(' ')
      end

      def bootstrap_modal_default_footer
        content_tag(:div, class: 'modal-footer') do
          button_tag("Don't save", class: 'btn btn-default', "data-dismiss": 'modal') +
            submit_tag('Save',
                       class: 'btn-primary',
                       disable_with: 'Saving&hellip;'.html_safe)
        end
      end
    end
  end
end
