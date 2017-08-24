module NdrUi
  module Bootstrap
    # This mixin provides standard error and warning boxes. A translated heading is needed
    # for base and other error and warning messages.
    #
    # The overall error alertbox heading uses:
    #
    # en:
    #   errors:
    #     alertbox:
    #       heading: "%{reason} prevented this record from being saved."
    #
    # Where reason is the number of errors e.g. "1 error" or "3 errors"
    #
    # For :base errors use the following heading translations:
    #
    # en:
    #   errors:
    #     alertbox:
    #       base:
    #         readonly: "Overall errors:"
    #         editing: "Overall errors:"
    #
    # If there is no difference in the readonly/editing messages then you can use
    #
    # en:
    #   errors:
    #     alertbox:
    #       base: "Overall errors:"
    #
    # For all other non-base errors use the following heading translations:
    #
    # en:
    #   errors:
    #     alertbox:
    #       other:
    #         readonly: "Specific errors:"
    #         editing: "Specific errors (click on labels!):"
    #
    # The pattern is exactly the same for warnings:
    #
    # The overall warning alertbox heading uses:
    #
    # en:
    #   warnings:
    #     alertbox:
    #       heading: "%{reason} prevented this record from being saved."
    #
    # Where reason is the number of warnings e.g. "1 warning" or "3 warnings"
    #
    # For :base warnings use the following heading translations:
    #
    # en:
    #   warnings:
    #     alertbox:
    #       base:
    #         readonly: "Overall warnings:"
    #         editing: "Overall warnings:"
    #
    # If there is no difference in the readonly/editing messages then you can use
    #
    # en:
    #   warnings:
    #     alertbox:
    #       base: "Overall errors:"
    #
    # For all other non-base errors use the following heading translations:
    #
    # en:
    #   warnings:
    #     alertbox:
    #       other:
    #         readonly: "Specific warnings:"
    #         editing: "Specific warnings (click on labels!):"
    #
    module ErrorAndWarningAlertBoxes
      SAFE_BLANK_STRING = ERB::Util.html_escape('').freeze

      # Map issue types to Boostrap alert styles
      ALERT_BOX_TYPE = { errors: :danger, warnings: :warning }.freeze

      def error_and_warning_alert_boxes
        error_alert_box + warning_alert_box
      end

      def error_alert_box
        issue_alert_box(:errors)
      end

      def warning_alert_box
        issue_alert_box(:warnings)
      end

      def issue_alert_box(type)
        raise ArgumentError unless [:errors, :warnings].include?(type)
        return SAFE_BLANK_STRING unless object && object.respond_to?(type) && object.send(type).any?

        issues = object.send(type).to_hash
        @template.bootstrap_alert_tag(ALERT_BOX_TYPE[type]) do
          alertbox_heading(type, issues) +
            base_issues(type, issues[:base]) +
            non_base_issues(type, issues.except(:base))
        end
      end

      def base_issues(type, messages)
        issue_wrapper(type, :base, messages) do |message|
          message
        end
      end

      def non_base_issues(type, messages)
        issue_wrapper(type, :other, messages) do |attribute, errors|
          readonly_friendly_label(attribute) + ' ' + errors.to_sentence
        end
      end

      # This wraps the issues in a paragraph and puts them into an unordered list
      def issue_wrapper(type, name, messages, &block)
        return SAFE_BLANK_STRING if messages.blank?

        @template.content_tag(:p) do
          wrapper_heading(type, name) +
            @template.content_tag(:ul) do
              list_items = messages.map(&block).map { |item| @template.content_tag(:li, item) }
              @template.safe_join(list_items)
            end
        end
      end

      private

      # This returns the attribute human name in plain text if the form is readonly
      def readonly_friendly_label(attribute)
        return object.class.human_attribute_name(attribute) if readonly?
        label(attribute)
      end

      # This looks up the overall alertbox heading
      def alertbox_heading(type, issues)
        reason = @template.pluralize(issues.count, type.to_s.singularize)
        ERB::Util.html_escape(
          I18n.t("#{type}.alertbox.heading", reason: reason)
        )
      end

      # This method lookups up the translation falling back to the default one where necessary
      def wrapper_heading(type, name)
        ERB::Util.html_escape(
          I18n.t(readonly? ? 'readonly' : 'editing',
                 default: :'.',
                 scope: "#{type}.alertbox.#{name}")
        )
      end
    end
  end
end
