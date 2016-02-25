require 'test_helper'
# require_relative '../../app/helpers/ndr_ui/bootstrap_helper'
# require 'active_support/all'
# require 'action_view'
# require 'rails-dom-testing'

module NdrUi
  # Test bootstrap helpers
  class BootstrapHelperTest < ActionView::TestCase
    test 'bootstrap_alert_tag with message parameter' do
      assert_dom_equal '<div class="alert alert-danger alert-dismissible">' \
                       '<button class="close" data-dismiss="alert" name="button" type="button">' \
                       '&times;</button>Apples</div>',
                       bootstrap_alert_tag(:danger, 'Apples')
      assert_dom_equal '<div class="alert alert-warning alert-dismissible">' \
                       '<button class="close" data-dismiss="alert" name="button" type="button">' \
                       '&times;</button>Apples</div>',
                       bootstrap_alert_tag(:warning, 'Apples')
      assert_dom_equal '<div class="alert alert-info alert-dismissible">' \
                       '<button class="close" data-dismiss="alert" name="button" type="button">' \
                       '&times;</button>Apples</div>',
                       bootstrap_alert_tag(:info, 'Apples')
      assert_dom_equal '<div class="alert alert-success alert-dismissible">' \
                       '<button class="close" data-dismiss="alert" name="button" type="button">' \
                       '&times;</button></div>',
                       bootstrap_alert_tag(:success, nil)
      assert_dom_equal '<div class="alert alert-success alert-dismissible">' \
                       '<button class="close" data-dismiss="alert" name="button" type="button">' \
                       '&times;</button></div>',
                       bootstrap_alert_tag(:success, '')
      assert_dom_equal '<div class="alert alert-warning alert-dismissible">' \
                       '<button class="close" data-dismiss="alert" name="button" type="button">' \
                       '&times;</button>Apples</div>',
                       bootstrap_alert_tag(:warning, 'Apples', dismissible: true)
      assert_dom_equal '<div class="alert alert-warning">Apples</div>',
                       bootstrap_alert_tag(:warning, 'Apples', dismissible: false)
      assert_dom_equal '<div id="apple_123" class="alert alert-warning alert-dismissible">' \
                       '<button class="close" data-dismiss="alert" name="button" type="button">' \
                       '&times;</button>Apples</div>',
                       bootstrap_alert_tag(:warning, 'Apples', dismissible: true, id: 'apple_123')
      assert_dom_equal '<div id="apple_123" class="alert alert-warning">Apples</div>',
                       bootstrap_alert_tag(:warning, 'Apples', dismissible: false, id: 'apple_123')
      assert bootstrap_alert_tag(:warning, unsafe_string).html_safe?,
             'bootstrap_alert_tag is not html_safe'
    end

    test 'bootstrap_alert_tag with message block' do
      assert_dom_equal '<div class="alert alert-info alert-dismissible">' \
                       '<button class="close" data-dismiss="alert" name="button" type="button">' \
                       '&times;</button>Pears</div>',
                       bootstrap_alert_tag(:info) { 'Pears' }

      assert_dom_equal '<div class="alert alert-danger alert-dismissible">' \
                       '<button class="close" data-dismiss="alert" name="button" type="button">' \
                       '&times;</button></div>',
                       bootstrap_alert_tag(:danger) {}

      assert_dom_equal '<div id="pear_123" class="alert alert-warning">Pears</div>',
                       bootstrap_alert_tag(:warning, dismissible: false, id: 'pear_123') {
                         'Pears'
                       }

      html = bootstrap_alert_tag(:info, id: 'pear_123') { unsafe_string }
      assert html.html_safe?, 'bootstrap_alert_tag is not html_safe'
    end

    test 'bootstrap_label_tag with message parameter' do
      assert_dom_equal '<span class="label label-default">Pears</span>',
                       bootstrap_label_tag(:default, 'Pears')
      assert_dom_equal '<span class="label label-success">Pears</span>',
                       bootstrap_label_tag(:success, 'Pears')
      assert_dom_equal '<span class="label label-warning">Pears</span>',
                       bootstrap_label_tag(:warning, 'Pears')
      assert_dom_equal '<span class="label label-danger">Pears</span>',
                       bootstrap_label_tag(:danger, 'Pears')
      assert_dom_equal '<span class="label label-info">Pears</span>',
                       bootstrap_label_tag(:info, 'Pears')
      assert_dom_equal '<span class="label label-primary">Pears</span>',
                       bootstrap_label_tag(:primary, 'Pears')
      assert bootstrap_label_tag(:warning, unsafe_string).html_safe?,
             'bootstrap_label_tag is not html_safe'
    end

    test 'bootstrap_badge_tag with message parameter' do
      assert_dom_equal '<span class="badge">Pears</span>', bootstrap_badge_tag(:default, 'Pears')
      assert_dom_equal '<span class="badge">Pears</span>', bootstrap_badge_tag(:success, 'Pears')
      assert_dom_equal '<span class="badge">Pears</span>', bootstrap_badge_tag(:warning, 'Pears')
      assert_dom_equal '<span class="badge">Pears</span>', bootstrap_badge_tag(:important, 'Pears')
      assert_dom_equal '<span class="badge">Pears</span>', bootstrap_badge_tag(:info, 'Pears')
      assert_dom_equal '<span class="badge">Pears</span>', bootstrap_badge_tag(:inverse, 'Pears')
      assert bootstrap_badge_tag(:warning, unsafe_string).html_safe?,
             'bootstrap_badge_tag is not html_safe'
    end

    test 'bootstrap_caret_tag' do
      assert_dom_equal '<b class="caret"></b>', bootstrap_caret_tag
      assert bootstrap_caret_tag.html_safe?, 'bootstrap_caret_tag is not html_safe'
    end

    test 'bootstrap_dropdown_toggle_tag' do
      assert_dom_equal '<a href="#" class="dropdown-toggle" data-toggle="dropdown">Apples ' \
                       "#{bootstrap_caret_tag}</a>",
                       bootstrap_dropdown_toggle_tag('Apples')
      assert bootstrap_dropdown_toggle_tag(unsafe_string).html_safe?,
             'bootstrap_dropdown_toggle_tag is not html_safe'
    end

    test 'bootstrap_icon_tag' do
      assert_dom_equal '<span class="glyphicon glyphicon-search"></span>',
                       bootstrap_icon_tag(:search)
      assert bootstrap_icon_tag(:search).html_safe?, 'bootstrap_caret_tag is not html_safe'
    end

    # TODO: bootstrap_icon_spinner(type = :default)

    test 'bootstrap_accordion_tag' do
      html = bootstrap_accordion_tag :fruit do |fruit_accordion|
        inner_html = fruit_accordion.bootstrap_accordion_group 'Apple' do
          'This is an apple.'
        end
        inner_html += fruit_accordion.bootstrap_accordion_group 'Orange', open: true do
          'This is an orange.'
        end
        inner_html
      end
      assert_dom_equal '<div id="fruit" class="panel-group"><div class="panel panel-default">' \
                       '<div class="panel-heading"><h4 class="panel-title">' \
                       '<a href="#fruit_1" data-parent="#fruit" data-toggle="collapse">Apple</a>' \
                       '</h4></div><div class="panel-collapse collapse" id="fruit_1">' \
                       '<div class="panel-body">This is an apple.</div></div></div>' \
                       '<div class="panel panel-default"><div class="panel-heading">' \
                       '<h4 class="panel-title">' \
                       '<a href="#fruit_2" data-parent="#fruit" data-toggle="collapse">Orange' \
                       '</a></h4></div><div class="panel-collapse collapse in" id="fruit_2">' \
                       '<div class="panel-body">This is an orange.</div></div></div></div>',
                       html
    end

    test 'bootstrap_accordion_group_with_seamless_option' do
      html = bootstrap_accordion_tag :fruit do |fruit_accordion|
        fruit_accordion.bootstrap_accordion_group 'Apple', seamless: true do
          'This is an apple.'
        end
      end
      assert_dom_equal '<div id="fruit" class="panel-group"><div class="panel panel-default">' \
                       '<div class="panel-heading"><h4 class="panel-title">' \
                       '<a href="#fruit_1" data-parent="#fruit" data-toggle="collapse">Apple' \
                       '</a></h4></div><div class="panel-collapse collapse" id="fruit_1">' \
                       'This is an apple.</div></div></div>',
                       html
    end

    test 'bootstrap_panel_tag' do
      html = bootstrap_panel_tag 'Apples', class: 'panel-warning', id: 'fruit' do
        'Check it out!!'
      end
      assert_dom_equal '<div id="fruit" class="panel panel-warning"><div class="panel-heading">' \
                       'Apples</div>Check it out!!</div>',
                       html
    end

    test 'bootstrap_panel_body_tag' do
      html = bootstrap_panel_body_tag do
        'Check it out!!'
      end
      assert_dom_equal '<div class="panel-body">Check it out!!</div>', html
    end

    test 'bootstrap_tab_nav_tag' do
      assert_dom_equal '<li><a href="#fruits" data-toggle="tab">Fruits</a></li>',
                       bootstrap_tab_nav_tag('Fruits', '#fruits')
      assert_dom_equal '<li><a href="#fruits" data-toggle="tab">Fruits</a></li>',
                       bootstrap_tab_nav_tag('Fruits', '#fruits', false)
      assert_dom_equal '<li class="active"><a href="#fruits" data-toggle="tab">Fruits</a></li>',
                       bootstrap_tab_nav_tag('Fruits', '#fruits', true)
    end

    test 'bootstrap_list_link_to' do
      stubs(:inbox_path).returns('/inbox')
      stubs(:current_page?).returns(false)
      refute current_page?(inbox_path)
      assert_dom_equal "<li>#{link_to('test', inbox_path)}</li>",
                       bootstrap_list_link_to('test', inbox_path)
      stubs(:current_page?).returns(true)
      assert current_page?(inbox_path)
      assert_dom_equal "<li class=\"active\">#{link_to('test', inbox_path)}</li>",
                       bootstrap_list_link_to('test', inbox_path)
    end

    test 'bootstrap_list_badge_and_link_to' do
      stubs(:inbox_path).returns('/inbox')
      stubs(:current_page?).returns(false)
      refute current_page?(inbox_path)

      html = content_tag(:div, bootstrap_badge_tag(:important, 99), class: 'pull-right') + 'Inbox'
      assert_dom_equal "<li>#{link_to(html, inbox_path)}</li>",
                       bootstrap_list_badge_and_link_to(:important, 99, 'Inbox', inbox_path)
    end

    # TODO: list_group_link_to(*args, &block)

    test 'bootstrap_list_divider_tag' do
      assert_dom_equal '<li class="divider" role="presentation"></li>', bootstrap_list_divider_tag
      assert bootstrap_list_divider_tag.html_safe?, 'bootstrap_list_divider_tag is not html_safe'
    end

    test 'bootstrap_list_header_tag' do
      assert_dom_equal '<li class="dropdown-header" role="presentation">Apples</li>',
                       bootstrap_list_header_tag('Apples')
      assert bootstrap_list_header_tag(unsafe_string).html_safe?,
             'bootstrap_list_header_tag is not html_safe'
    end

    test 'bootstrap_abbreviation_tag' do
      assert_dom_equal '<abbr title="Nottingham Prognostic Index" class="initialism">NPI</abbr>',
                       bootstrap_abbreviation_tag('NPI', 'Nottingham Prognostic Index')
      assert_dom_equal '<abbr title="Abbreviation">abbr</abbr>',
                       bootstrap_abbreviation_tag('abbr', 'Abbreviation')
    end

    # TODO: bootstrap_form_for(record_or_name_or_array, *args, &proc)
    # TODO: bootstrap_pagination_tag(*args, &block)

    test 'button_control_group' do
      assert_dom_equal '<div class="form-group"><div class="col-sm-9 col-sm-offset-3">' \
                       'Apples</div></div>',
                       button_control_group('Apples')

      html = button_control_group(class: 'some_class') do
        'Pears'
      end
      assert_dom_equal '<div class="form-group"><div class="col-sm-9 col-sm-offset-3">' \
                       '<div class="some_class">Pears</div></div></div>',
                       html

      html = button_control_group(horizontal: false, class: 'some_class') do
        'Pears'
      end
      assert_dom_equal '<div class="form-group some_class">Pears</div>', html
    end

    test 'bootstrap_modal_box' do
      @output_buffer = bootstrap_modal_box('New Pear', 'Pear form')
      assert_select 'div.modal-dialog' do
        assert_select 'div.modal-content' do
          assert_select 'div.modal-header h4', 'New Pear'
          assert_select 'div.modal-body', 'Pear form'
          assert_select 'div.modal-footer' do
            assert_select 'button',
                          attributes: { class: 'btn btn-default', "data-dismiss": 'modal' },
                          html: /Don(.*?)t save/ # assert_select behaviour changes
            assert_select 'input', attributes: { type: 'submit', class: 'btn-primary btn' }
          end
        end
      end

      @output_buffer = bootstrap_modal_box('New Pear') { 'Pear form' }
      assert_select 'div.modal-dialog' do
        assert_select 'div.modal-content' do
          assert_select 'div.modal-header h4', 'New Pear'
          assert_select 'div.modal-body', 'Pear form'
          assert_select 'div.modal-footer' do
            assert_select 'button',
                          attributes: { class: 'btn btn-default', "data-dismiss": 'modal' },
                          html: /Don(.*?)t save/ # assert_select behaviour changes
            assert_select 'input', attributes: { type: 'submit', class: 'btn-primary btn' }
          end
        end
      end
    end

    test 'bootstrap_modal_box with size' do
      @output_buffer = bootstrap_modal_box('New Pear', 'Pear form', size: 'lg')
      assert_select 'div.modal-dialog.modal-lg'

      @output_buffer = bootstrap_modal_box('New Pear', size: 'lg') { 'Pear form' }
      assert_select 'div.modal-dialog.modal-lg'

      @output_buffer = bootstrap_modal_box('New Pear', 'Pear form', size: 'enormous')
      assert_select 'div.modal-dialog.modal-enormous', 0
    end

    test 'bootstrap_progressbar_tag' do
      assert_dom_equal '<div class="progress progress-striped active" title="40%">' \
                       '<div class="progress-bar" style="width:40%"></div></div>',
                       bootstrap_progressbar_tag(40)
      assert_dom_equal '<div class="progress progress-striped active" title="Dummy tooltip">' \
                       '<div class="progress-bar" style="width:40%"></div></div>',
                       bootstrap_progressbar_tag(40, title: 'Dummy tooltip')
      assert_dom_equal '<div class="progress progress-striped active" title="40%">' \
                       '<div class="progress-bar progress-bar-success" style="width:40%">' \
                       '</div></div>',
                       bootstrap_progressbar_tag(40, type: :success)
    end

    # TODO: bootstrap_form_div_start_tag
    # TODO: bootstrap_form_div_end_tag
    # TODO: horizonal_form_container_start_tag(editing = true)
    # TODO: horizonal_form_container_end_tag

    test 'bootstrap_horizontal_form_group' do
      # Test with standard columns:
      actual   = bootstrap_horizontal_form_group('The Label') { 'This is the content' }
      expected = '<div class="form-group"><label class="col-sm-2 control-label">' \
                 'The Label</label><div class="col-sm-10">This is the content</div></div>'
      assert_dom_equal expected, actual

      # Test with different columns:
      actual   = bootstrap_horizontal_form_group('The Label', [3, 9]) { 'This is the content' }
      expected = '<div class="form-group"><label class="col-sm-3 control-label">' \
                 'The Label</label><div class="col-sm-9">This is the content</div></div>'
      assert_dom_equal expected, actual

      # Test with no label:
      actual   = bootstrap_horizontal_form_group { 'This is the content' }
      expected = '<div class="form-group"><div class="col-sm-10 col-sm-offset-2">' \
                 'This is the content</div></div>'
      assert_dom_equal expected, actual

      # Test with no label and different columns:
      actual   = bootstrap_horizontal_form_group([1, 11]) { 'This is the content' }
      expected = '<div class="form-group"><div class="col-sm-11 col-sm-offset-1">' \
                 'This is the content</div></div>'
      assert_dom_equal expected, actual
    end

    test 'description_list_name_value_pair' do
      assert_dom_equal '<dt>Pear</dt><dd>Value</dd>',
                       description_list_name_value_pair('Pear', 'Value')
      assert_dom_equal '<dt>Pear</dt><dd><span class="text-muted">[none]</span></dd>',
                       description_list_name_value_pair('Pear', nil, '[none]')
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
