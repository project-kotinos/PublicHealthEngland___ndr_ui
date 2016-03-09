module NdrUi
  module Bootstrap
    # This provides bootstrap dropdown helper methods
    module DropdownHelper
      # Creates an html list item containing a link. It takes the standard link_to arguments
      # passing them through to a standard link_to call. For bootstrap styling, it simply adds the
      # class "active", if the link points to the current page that is being viewed.
      # Predominantly used by nav bars and lists.
      #
      # ==== Signatures
      #
      #   bootstrap_list_link_to(name, options = {}, html_options = nil)
      #   bootstrap_list_link_to(options = {}, html_options = nil) do
      #     # name
      #   end
      #
      # See the Rails documentation for details of the options and examples
      #
      def bootstrap_list_link_to(*args, &block)
        if block_given?
          return bootstrap_list_link_to(capture(&block), (args.first || {}), args.second)
        end

        name         = args.first
        options      = args.second || {}
        html_options = args.third
        li_options   = {}

        li_options[:class] = 'active' if current_page?(options)

        content_tag(:li, link_to(name, options, html_options), li_options)
      end

      # Creates a Boostrap list header.
      #
      # ==== Signatures
      #
      #   bootstrap_list_header_tag(name)
      #
      # ==== Examples
      #
      #   <%= bootstrap_list_header_tag("Apples") %>
      #   # => <li class="dropdown-header">Apples</li>
      def bootstrap_list_header_tag(name, options = {})
        options[:class] = (options[:class].to_s.split(' ') + ['dropdown-header']).join(' ')
        content_tag(:li, name, { role: 'presentation' }.merge(options))
      end

      # Creates a Boostrap list divider.
      #
      # ==== Signatures
      #
      #   bootstrap_list_divider_tag
      #
      # ==== Examples
      #
      #   <%= bootstrap_list_divider_tag %>
      #   # => <li class="divider"></li>
      def bootstrap_list_divider_tag(options = {})
        options[:class] = (options[:class].to_s.split(' ') + ['divider']).join(' ')
        content_tag(:li, '', { role: 'presentation' }.merge(options))
      end
    end
  end
end
