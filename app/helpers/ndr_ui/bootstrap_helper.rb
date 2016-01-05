module NdrUi
  module BootstrapHelper
    PANEL_SUBCLASSES = %w(
      panel-default
      panel-primary
      panel-success
      panel-info
      panel-warning
      panel-danger
    ) unless defined?(PANEL_SUBCLASSES)

    # Creates an alert box of the given +type+. It supports the following alert box types
    # <tt>:alert</tt>, <tt>:danger</tt>, <tt>:info</tt> and <tt>:success</tt>.
    #
    # ==== Signatures
    #
    #   bootstrap_alert_tag(type, message, options = {})
    #   bootstrap_alert_tag(type, options = {}) do
    #     # message
    #   end
    #
    # ==== Options
    # * <tt>dismissible: true</tt> - This will set whether or not a close X button
    #   will appear, allowing the alert box to be dismissed by the user. This is only
    #   supported with the Bootstrap layout and defaults to true.
    #   link to open in a popup window. By passing true, a default browser window
    #   will be opened with the URL. You can also specify an array of options
    #   that are passed-thru to JavaScripts window.open method.
    # * All remaining options are treated as html attributes for the containing div tag.
    #   The class attribute is overwritten by the helper and so will be ignored if specified.
    #
    # ==== Examples
    #
    #   <%= bootstrap_alert_tag(:info, 'Check it out!!') %>
    #   # => <div class="alert alert-info"><a href="#" class="close"
    #   data-dismiss="alert">&times;</a>Check it out!!</div>
    #
    # You can use a block as well if your alert message is hard to fit into the message parameter.
    # ERb example:
    #
    #   <%= bootstrap_alert_tag(:info) do %>
    #     Check it out!!
    #   <% end %>
    #   # => <div class="alert alert-info"><button type="button" class="close"
    #   data-dismiss="alert">&times;</button>Check it out!!</div>
    #
    # Ids for css and/or javascript are easy to produce:
    #
    #   <%= bootstrap_alert_tag(:info, 'Check it out!!', dismissible: false, id: "news") %>
    #   # => <div class="alert alert-info" id="news">Check it out!!</div>
    #
    def bootstrap_alert_tag(*args, &block)
      type = args[0]
      if block_given?
        message = capture(&block)
        options = args[1] || {}
        return bootstrap_alert_tag(type, message, options)
      else
        message = args[1] || ''
        options = args[2] || {}
        options.stringify_keys!

        classes = ['alert']
        classes << "alert-#{type}" if type && type != :alert
        unless options.include?('dismissible') && !options['dismissible']
          classes << 'alert-dismissible'
          options['dismissible'] = true
        end
        options['class'] = classes.join(' ')

        message = button_tag('&times;'.html_safe,
                             type: 'button',
                             class: 'close',
                             "data-dismiss": 'alert') + message if options.delete('dismissible')
        content_tag(:div, message, options)
      end
    end

    # Creates an bootstrap label of the given +type+. It supports the following types
    # <tt>:default</tt>, <tt>:success</tt>, <tt>:warning</tt>, <tt>:danger</tt>,
    # <tt>:info</tt> and <tt>:primary</tt>.
    #
    # ==== Signatures
    #
    #   bootstrap_label_tag(type, message)
    #
    # ==== Examples
    #
    #   <%= bootstrap_label_tag(:info, 'Check it out!!') %>
    #   # => <span class="label label-info">Check it out!!</span>
    #
    def bootstrap_label_tag(type, message)
      classes = ['label', "label-#{type}"]
      content_tag(:span, message, class: classes.join(' '))
    end

    # Creates an bootstrap badge of the given +type+. Bootstrap 3 does not support any types.
    #
    # ==== Signatures
    #
    #   bootstrap_badge_tag(type, count)
    #
    # ==== Examples
    #
    #   <%= bootstrap_badge_tag(:success, 'Check it out!!') %>
    #   # => <span class="badge">Check it out!!</span> <%# Bootstrap 3 %>
    #
    # TODO: In bootstrap 4, these will likely need to be implemented using "pill labels",
    #       which will once again allow the `type` argument to colour them.
    #
    def bootstrap_badge_tag(_type, count)
      content_tag(:span, count, class: 'badge')
    end

    # Creates a simple bootstrap navigation caret.
    #
    # ==== Signatures
    #
    #   bootstrap_caret_tag
    #
    # ==== Examples
    #
    #   <%= bootstrap_caret_tag %>
    #   # => <b class="caret"></b>
    def bootstrap_caret_tag
      content_tag(:b, '', class: 'caret')
    end

    # Creates a simple bootstrap navigation dropdown.
    #
    # ==== Signatures
    #
    #   bootstrap_dropdown_toggle_tag(body)
    #
    # ==== Examples
    #
    #   <%= bootstrap_dropdown_toggle_tag('Check it out!!') %>
    #   # => <a href="#" class="dropdown-toggle" data-toggle="dropdown">Check it
    #   out!! <b class="caret"></b></a>
    def bootstrap_dropdown_toggle_tag(body)
      link_to(ERB::Util.html_escape(body) + ' '.html_safe + bootstrap_caret_tag,
              '#',
              class: 'dropdown-toggle',
              'data-toggle': 'dropdown')
    end

    # TODO: bootstrap_icon_tag(type, force_bootstrap = false)
    # TODO: bootstrap_icon_spinner(type = :default)

    # Creates an accordion wrapper and creates a new BootstrapAccordion instance
    # Creates an plain or nested bootstrap accordion along with bootstrap_accordion_group
    # method at BootstrapAccordion class.
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
      accordion = ::NdrUi::BootstrapAccordion.new(dom_id, self)
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

    # Creates a simple bootstrap tab navigation.
    #
    # ==== Signatures
    #
    #   bootstrap_tab_nav_tag(title, linkto, active = false)
    #
    # ==== Examples
    #
    #   <%= bootstrap_tab_nav_tag("Fruits", "#fruits", true) %>
    #   # => <li class="active"><a href="#fruits" data-toggle="tab">Fruits</a></li>
    def bootstrap_tab_nav_tag(title, linkto, active = false)
      content_tag('li',
                  link_to(title, linkto, "data-toggle": 'tab'),
                  active ? { class: 'active' } : {})
    end

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
        options      = args.first || {}
        html_options = args.second
        return bootstrap_list_link_to(capture(&block), options, html_options)
      else
        name         = args.first
        options      = args.second || {}
        html_options = args.third

        li_options = {}
        li_options[:class] = 'active' if current_page?(options)

        content_tag(:li, link_to(name, options, html_options), li_options)
      end
    end

    # TODO: bootstrap_list_badge_and_link_to(type, count, name, path)
    # TODO: list_group_link_to(*args, &block)

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

    # Creates a Boostrap abbreviation tag (note: the acronym tag is not valid HTML5).
    # Also adds the "initialism" class if the abbreviation is all upper case.
    #
    # ==== Signatures
    #
    #   bootstrap_abbreviation_tag(name, abbreviation)
    #
    # ==== Examples
    #
    #   <%= bootstrap_abbreviation_tag('NPI', 'Nottingham Prognostic Index') %>
    #   # => <abbr class="initialism" title="Nottingham Prognostic Index">NPI</abbr>
    def bootstrap_abbreviation_tag(name, abbreviation)
      content_tag(:abbr,
                  name,
                  title: abbreviation,
                  class: (name == name.upcase ? 'initialism' : nil))
    end

    # TODO: bootstrap_form_for(record_or_name_or_array, *args, &proc)
    # TODO: bootstrap_pagination_tag(*args, &block)

    # Creates a Boostrap control group for button.
    #
    # ==== Signatures
    #
    #   button_control_group(controls, options = {})
    #   button_control_group(options = {}) do
    #     # controls
    #   end
    #
    # ==== Examples
    #
    #   <%= button_control_group("Apples", class: "some_class") %>
    #   # =>
    #   <div class="form-group">
    #     <div class="col-sm-9 col-sm-offset-3">
    #       <div class="some_class">Apples</div>
    #     </div>
    #   </div>
    def button_control_group(*args, &block)
      return button_control_group(capture(&block), *args) if block_given?
      options = args.extract_options!
      options.stringify_keys!

      if options.delete('horizontal') == false
        options['class'] = ('form-group' + ' ' + options['class'].to_s).strip
        content_tag(:div, args.first, options)
      else
        bootstrap_horizontal_form_group nil, [3, 9] do
          options.blank? ? args.first : content_tag(:div, args.first, options)
        end
      end
    end

    # Creates a Boostrap Modal box.
    #
    # ==== Signatures
    #
    #   bootstrap_modal_box(title, controls, options = {})
    #   bootstrap_modal_box(title, options = {}) do
    #     # controls
    #   end
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
      # options = args.extract_options!
      # options = options.stringify_keys
      # classes = %w()
      # classes << options['class'].split(' ') if options.include?('class')
      # options['class'] = classes.join(' ')

      content_tag(:div, class: 'modal-dialog') do
        content_tag(:div, class: 'modal-content') do
          content_tag(:div, content_tag(:h4, title, class: 'modal-title'),
                      class: 'modal-header') +
            content_tag(:div, args.first, class: 'modal-body') +
            content_tag(:div, class: 'modal-footer') do
              button_tag("Don't save", class: 'btn btn-default', "data-dismiss": 'modal') +
                submit_tag('Save',
                           class: 'btn-primary',
                           disable_with: 'Saving&hellip;'.html_safe)
            end
        end
      end
    end

    # Creates a Boostrap progress bar.
    #
    # ==== Signatures
    #
    #   bootstrap_progressbar_tag(options)
    #
    # ==== Examples
    #
    #   <%= bootstrap_progressbar_tag(40) %>
    #   # => <div class="progress progress-striped active" title="40%"><div class="progress-bar"
    #   style="width:40%"></div></div>
    #
    #   <%= bootstrap_progressbar_tag(40), type: :danger %>
    #   # => <div class="progress progress-striped active" title="40%"><div
    #   class="progress-bar progress-bar-danger" style="width:40%"></div></div>
    #
    # ==== Browser compatibility
    #
    # Bootstrap Progress bars use CSS3 gradients, transitions, and animations to achieve all their
    # effects. These features are not supported in IE7-9 or older versions of Firefox.
    # Versions earlier than Internet Explorer 10 and Opera 12 do not support animations.
    def bootstrap_progressbar_tag(*args)
      percentage = args[0].to_i
      options = args[1] || {}
      options.stringify_keys!
      options['title'] ||= "#{percentage}%"

      classes = ['progress']
      classes << options.delete('class')
      classes << 'progress-striped'

      type = options.delete('type').to_s
      type = " progress-bar-#{type}" unless type.blank?

      # Animate the progress bar unless something has broken:
      classes << 'active' unless type == 'danger'

      inner = content_tag(:div, '', class: "progress-bar#{type}", style: "width:#{percentage}%")

      options.merge!('class' => classes.compact.join(' '))
      content_tag(:div, inner, options)
    end

    # TODO: bootstrap_form_div_start_tag
    # TODO: bootstrap_form_div_end_tag
    # TODO: horizonal_form_container_start_tag(editing = true)
    # TODO: horizonal_form_container_end_tag

    # Supply optional label. Use options[:ratio] for grid split/offset.
    # The default is [2, 10], where 2 is label columns / offset, and
    # 10 is content width. If the label is omitted, the content is
    # offset by the same number of columns instead.
    #
    # ==== Examples
    #   bootstrap_horizontal_form_group("The Label", [3, 9]) { 'This is the content' }
    #   # =>
    #     <div class="form-group">
    #       <label class="col-sm-3 control-label">The Label</label>
    #       <div class="col-sm-9">This is the content</div>
    #     </div>
    #
    def bootstrap_horizontal_form_group(label = nil, ratio = [2, 10], &block)
      label, ratio = nil, label if label.is_a?(Array)

      l, r   = ratio[0..1].map(&:to_i)
      offset = label.nil? ? " col-sm-offset-#{l}" : ''

      # Main content:
      content = content_tag(:div, class: "col-sm-#{r}" + offset, &block)
      # Prepend optional label:
      unless label.nil?
        content = content_tag(:label, label, class: "col-sm-#{l} control-label") + content
      end

      content_tag(:div, content, class: 'form-group')
    end

    # This helper produces a pair of HTML dt, dd tags to display name and value pairs.
    # If a blank_value_placeholder is not defined then the pair are not shown if the
    # value is blank. Otherwise the placeholder is shown in the text-muted style.
    #
    # ==== Signature
    #
    #   description_list_name_value_pair(name, value, blank_value_placeholder = nil)
    #
    # ==== Examples
    #
    #   <%= description_list_name_value_pair("Pear", "Value") %>
    #   # => <dt>Pear</dt><dd>Value</dd>
    #
    #   <%= description_list_name_value_pair("Pear", nil, "[none]") %>
    #   # => <dt>Pear</dt><dd><span class="text-muted">[none]</span></dd>
    #
    def description_list_name_value_pair(name, value, blank_value_placeholder = nil)
      # SECURE: TPG 2013-08-07: The output is sanitised by content_tag
      return unless value.present? || blank_value_placeholder.present?
      content_tag(:dt, name) +
        content_tag(:dd, value || content_tag(:span, blank_value_placeholder, class: 'text-muted'))
    end

    # TODO: button_toolbar(&block)
    # TODO: button_group(&block)
    # TODO: details_link(path, options = {})
    # TODO: edit_link(path, options = {})
    # TODO: delete_link(path, options = {})
    # TODO: link_to_with_icon(options = {})
    # TODO: bootstrap_will_paginate(collection = nil, options = {})
  end
end
