module NdrUi
  # Creates a plain or nested bootstrap accordion along with bootstrap_accordion_tag helper method.
  # Produce the inner html code of an accordion item.
  # Legacy styling recognised by jQuery UI and only fully supports one level accordion.
  #
  # ==== Signatures
  #
  #   bootstrap_accordion_tag(dom_id) do |accordion|
  #     accordion.bootstrap_accordion_group(heading, options) do
  #       #content or nested accordion
  #     end
  #   end
  #
  # ==== Options
  # * <tt>open: true</tt> - This will allow accordion item open by default
  # * <tt>seamless: true</tt> - This omits the panel-body container so that tables and lists
  #   can be seamless
  # * Accordion are using pre-defined html format, and options and html attributes
  #   are not accepted.
  #
  # ==== Examples
  #
  #   <%= bootstrap_accordion_tag :fruit do |fruit_accordion| %>
  #     <%= fruit_accordion.bootstrap_accordion_group "Apple" do %>
  #       This is an apple.
  #     <% end %>
  #     <%= fruit_accordion.bootstrap_accordion_group "Orange", open: true do %>
  #       This is an orange.
  #     <% end %>
  #   <% end %>
  #
  #   # =>
  #   <div id="fruit" class="accordion">
  #     <div class="panel panel-default">
  #       <div class="panel-heading">
  #         <a href="#fruit_1" data-parent="#fruit" data-toggle="collapse">Apple</a>
  #       </div>
  #       <div class="panel-collapse collapse" id="fruit_1">
  #         <div class="panel-body">
  #           This is an apple.
  #         </div>
  #       </div>
  #     </div>
  #     <div class="panel panel-default">
  #       <div class="panel-heading">
  #         <a href="#fruit_2" data-parent="#fruit" data-toggle="collapse">Orange</a>
  #       </div>
  #       <div class="panel-collapse collapse in" id="fruit_2">
  #         <div class="panel-body">
  #           This is an orange.
  #         </div>
  #       </div>
  #     </div>
  #   </div>
  #
  class BootstrapAccordion
    attr_accessor :dom_id, :index

    def initialize(accordion_id, template)
      @dom_id = accordion_id
      @template = template
      @index = 0
    end

    def bootstrap_accordion_group(heading, options = {}, &block)
      return unless block_given?
      options.stringify_keys!
      open     = !!options['open']
      seamless = !!options['seamless']
      @index += 1
      content = @template.capture(&block)
      group_id = "#{@dom_id}_#{@index}"
      content = @template.content_tag('div', content, class: 'panel-body') unless seamless
      @template.content_tag('div', class: 'panel panel-default') do
        inner_html = @template.content_tag('div', class: 'panel-heading') do
          @template.content_tag('h4', class: 'panel-title') do
            @template.link_to(heading,
                              "##{group_id}",
                              'data-toggle': 'collapse', 'data-parent': "##{@dom_id}")
          end
        end
        inner_html += @template.content_tag('div', content,
                                            id: group_id,
                                            class: "panel-collapse collapse#{' in' if open}")
        inner_html
      end
    end
  end
end
