module NdrUi
  module Bootstrap
    # The CSS class form-control needs to be added to the following form elements:
    #
    # > select
    # > textarea
    # > input[type="text"]
    # > input[type="password"]
    #   input[type="datetime"]
    #   input[type="datetime-local"]
    #   input[type="date"]
    #   input[type="month"]
    #   input[type="time"]
    #   input[type="week"]
    #   input[type="number"]
    #   input[type="email"]
    #   input[type="url"]
    #   input[type="search"]
    #   input[type="tel"]
    #   input[type="color"]
    #
    # and this mixin does it for the elements marked ">"
    module FormControlClass
      def self.add_form_control_class(method_name)
        define_method(method_name) do |label, *args, &proc|
          options = css_class_options_merge(args.extract_options!, %w(form-control))
          super(label, *(args << options), &proc)
        end
      end

      def self.add_select_control_class
        define_method('select') do |label, choices, *args, &proc|
          # TODO: Ruby 1.8 doesn't support optional arguments with `define_method`:
          options, html_options = *args
          options      ||= {}
          html_options ||= {}

          html_options = css_class_options_merge(html_options, %w(form-control))
          super(label, choices, options, html_options, &proc)
        end
      end

      %w(password_field text_area text_field).each do |name|
        add_form_control_class(name)
      end

      add_select_control_class
    end
  end
end
