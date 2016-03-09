require_relative 'accordion'

module NdrUi
  module Bootstrap
    # This provides accordion
    module PanelHelper
      PANEL_SUBCLASSES = %w(
        panel-default
        panel-primary
        panel-success
        panel-info
        panel-warning
        panel-danger
      ).freeze

      # Creates an accordion wrapper and creates a new NdrUi::Bootstrap::Accordion instance
      # Creates an plain or nested bootstrap accordion along with bootstrap_accordion_group
      # method at NdrUi::Bootstrap::Accordion class.
      #
      # ==== Signatures
      #
      #   bootstrap_accordion_tag(dom_id) do |accordion|
      #     #content for accordion items
      #   end
      #
      # ==== Examples
      #
      #   <%= bootstrap_accordion_group :fruit do |fruit_accordion| %>
      #   <% end %>
      #   # => <div id="fruit" class="accordion"></div>
      def bootstrap_accordion_tag(dom_id, &block)
        return unless block_given?
        accordion = ::NdrUi::Bootstrap::Accordion.new(dom_id, self)
        '<div id="'.html_safe + accordion.dom_id.to_s + '" class="panel-group">'.html_safe +
          capture { yield(accordion) } +
          '</div>'.html_safe
      end

      # Creates a bootstrap panel wrapper. the heading is wrapped in a panel-heading.
      # The content is not wrapped in a panel-body to enable seamless tables and lists.
      #
      # ==== Signatures
      #
      #   bootstrap_panel_tag(heading, options = {}) do
      #     #content for panel
      #   end
      #
      # ==== Examples
      #
      #   <%= bootstrap_panel_tag 'Apples', class: 'panel-warning', id: 'fruit' do %>
      #     Check it out!!
      #   <% end %>
      #   # => <div id="fruit" class="panel panel-warning"><div class="panel-heading">Apples</div>
      #   Check it out!!</div>
      def bootstrap_panel_tag(heading, options = {}, &block)
        return unless block_given?
        options.stringify_keys!
        classes = %w(panel)
        classes += options['class'].to_s.split(' ') if options.include?('class')
        classes << 'panel-default' if (classes & PANEL_SUBCLASSES).empty?
        options['class'] = classes.uniq.join(' ')

        content_tag(:div,
                    content_tag(:div, heading, class: 'panel-heading') +
                    capture(&block),
                    options)
      end

      # Creates a simple bootstrap panel body.
      #
      # ==== Signatures
      #
      #   bootstrap_panel_body_tag do
      #     #content for panel body
      #   end
      #
      # ==== Examples
      #
      #   <%= bootstrap_panel_body_tag do %>
      #     Check it out!!
      #   <% end %>
      #   # => <div class="panel-body">Check it out!!</div>
      def bootstrap_panel_body_tag(&block)
        return unless block_given?
        content_tag(:div, capture(&block), class: 'panel-body')
      end
    end
  end
end
