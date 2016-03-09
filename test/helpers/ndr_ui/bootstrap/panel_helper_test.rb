require 'test_helper'

module NdrUi
  module Bootstrap
    # Test bootstrap panel helpers
    class PanelHelperTest < ActionView::TestCase
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
                         '<a href="#fruit_1" data-parent="#fruit" data-toggle="collapse">Apple' \
                         '</a></h4></div><div class="panel-collapse collapse" id="fruit_1">' \
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
        assert_dom_equal '<div id="fruit" class="panel panel-warning">' \
                         '<div class="panel-heading">Apples</div>Check it out!!</div>',
                         html
      end

      test 'bootstrap_panel_body_tag' do
        html = bootstrap_panel_body_tag do
          'Check it out!!'
        end
        assert_dom_equal '<div class="panel-body">Check it out!!</div>', html
      end
    end
  end
end
