module NdrUi
  module Bootstrap
    # Allows a form to be marked as read-only. Supported field helpers
    # render as a non-editable display instead, allowing a form to be
    # reused as a "show" template.
    module Readonly
      def self.included(base)
        # These have different signatures, or aren't affected by `readonly`:
        needs_custom = [:radio_button, :file_field]
        not_affected = [:label, :fields_for]

        (base.field_helpers - needs_custom - not_affected).each do |selector|
          class_eval <<-END, __FILE__, __LINE__ + 1
            def #{selector}(method, options = {}, *rest)
              return super unless readonly?
              readonly_value = options.fetch(:readonly_value, object.send(method))
              @template.content_tag(:p, readonly_value, class: 'form-control-static')
            end
          END
        end

        class_eval <<-END, __FILE__, __LINE__ + 1
          # radio_button takes another intermediate argument:
          def radio_button(method, tag_value, options = {})
            return super unless readonly?
            readonly_value = options.fetch(:readonly_value, object.send(method))
            @template.content_tag(:p, readonly_value, class: 'form-control-static')
          end

          # For file_field, the readonly value defaults to nil:
          def file_field(method, options = {})
            return super unless readonly?
            readonly_value = options[:readonly_value]
            @template.content_tag(:p, readonly_value, class: 'form-control-static')
          end
        END

        class_eval <<-END, __FILE__, __LINE__ + 1
          # Allow fields_for to inherit `readonly`:
          def fields_for(record_name, record_object = nil, fields_options = {}, &block)
            fields_options[:readonly] ||= readonly
            super
          end
        END
      end

      attr_accessor :readonly
      alias readonly? readonly

      def initialize(*)
        super

        self.readonly = options[:readonly]
      end
    end
  end
end
