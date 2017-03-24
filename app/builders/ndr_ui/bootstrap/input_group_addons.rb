module NdrUi
  module Bootstrap
    # Provides form builder method for Bootstrap input-group-addon
    module InputGroupAddons
      # Identical signature to ActionView::Helpers::FormBuilder#text_field, but adds
      # <tt>:prepend</tt> and <tt>:append</tt> options to prepend and append text to
      # the text_field. Would typically be used for units (centigrays, mm, etc).
      # This implementation adds the associated bootstrap styling to the add-ons.
      def text_field(method, options = {})
        options = options.stringify_keys
        prepend = options.delete('prepend')
        append = options.delete('append')

        return super if prepend.blank? && append.blank?
        div_content = []

        unless prepend.blank?
          div_content << @template.content_tag(:span, prepend, class: 'input-group-addon')
        end

        div_content << text_field_without_inline_errors(method, options)

        unless append.blank?
          div_content << @template.content_tag(:span, append, class: 'input-group-addon')
        end

        @template.content_tag(:div, @template.safe_join(div_content), class: 'input-group')
      end
    end
  end
end
