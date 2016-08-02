module NdrUi
  module Bootstrap
    # Allows us to display errors and warnings in a bootstrap-friendly way
    module InlineErrorsAndWarnings
      # Tag::Base subclass for generating bootstrap span.help-block.
      # Allows us to use generate the tag_id properly.
      class HelpBlock < ActionView::Helpers::Tags::Base
        def render(&block)
          feedback_for =
            if respond_to?(:name_and_id_index, true)
              tag_id(name_and_id_index(@options))
            else
              add_default_name_and_id(@options.fetch('html', {}))
            end

          options = { class: 'help-block', data:  { feedback_for: feedback_for } }
          content_tag(:span, @template_object.capture(&block), options)
        end
      end

      def self.included(base)
        excluded = [:label, :fields_for, :hidden_field]

        (base.all_known_field_helpers - excluded).each do |selector|
          class_eval <<-END, __FILE__, __LINE__ + 1
            def #{selector}(method, *)
              super + inline_errors_and_warnings(method)
            end
          END
        end
      end

      private

      def inline_errors_and_warnings(method)
        HelpBlock.new(object_name, method, @template, options).render do
          ''.html_safe.tap do |buffer|
            errors = @template.safe_join(object.errors[method], @template.tag(:br))
            buffer << @template.content_tag(:span, errors, class: 'text-danger')

            if object_supports_warnings?
              warnings = @template.safe_join(object.warnings[method], @template.tag(:br))
              buffer << @template.content_tag(:span, warnings, class: 'text-warning')
            end
          end
        end
      end

      def object_supports_warnings?
        object.respond_to?(:warnings) && object.warnings.respond_to?(:[])
      end
    end
  end
end
