require 'test_helper'

module NdrUi
  module Bootstrap
    # Test bootstrap modal helpers
    class ModalHelperTest < ActionView::TestCase
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

      test 'bootstrap_modal_box with readonly option' do
        @output_buffer = bootstrap_modal_box('New Pear', 'Pear form', readonly: true)
        assert_select 'div.modal-dialog' do
          assert_select 'div.modal-content' do
            assert_select 'div.modal-header h4', 'New Pear'
            assert_select 'div.modal-body', 'Pear form'
            assert_select 'div.modal-footer' do
              assert_select 'button',
                            attributes: { class: 'btn btn-default', "data-dismiss": 'modal' },
                            html: 'Close'
            end
          end
        end

        @output_buffer = bootstrap_modal_box('New Pear', 'Pear form', readonly: false)
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
    end
  end
end
