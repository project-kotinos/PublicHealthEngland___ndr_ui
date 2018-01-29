require 'test_helper'

# Test bootstrap form builder error_and_warning_alert_boxes
class ErrorAndWarningAlertBoxesTest < ActionView::TestCase
  tests ActionView::Helpers::FormHelper
  include NdrUi::BootstrapHelper

  test 'error_and_warning_alert_boxes display nothing' do
    post = Post.new
    bootstrap_form_for post do |form|
      html = form.error_and_warning_alert_boxes
      assert_equal '', html
    end
  end

  test 'error_and_warning_alert_boxes display only warnings' do
    post = Post.new
    post.warnings.add(:base, 'Warning')

    @output_buffer = bootstrap_form_for(post, &:error_and_warning_alert_boxes)

    assert_select 'div.alert', 1
    assert_select 'div.alert.alert-warning' do
      assert_select 'li', text: 'Warning'
    end
  end

  test 'error_and_warning_alert_boxes display only errors' do
    post = Post.new
    post.errors.add(:base, 'Error')

    @output_buffer = bootstrap_form_for(post, &:error_and_warning_alert_boxes)

    assert_select 'div.alert', 1
    assert_select 'div.alert.alert-danger' do
      assert_select 'li', text: 'Error'
    end
  end

  test 'error_and_warning_alert_boxes display both errors and warnings' do
    post = Post.new
    post.errors.add(:base, 'Error')
    post.warnings.add(:base, 'Warning')

    @output_buffer = bootstrap_form_for(post, &:error_and_warning_alert_boxes)

    assert_select 'div.alert', 2
    assert_select 'div.alert.alert-danger', text: I18n.t('errors.alertbox.base.editing') do
      assert_select 'li', text: 'Error'
    end
    assert_select 'div.alert.alert-warning', text: I18n.t('errors.alertbox.base.editing') do
      assert_select 'li', text: 'Warning'
    end
  end

  test 'error_and_warning_alert_boxes display multiple warnings' do
    post = Post.new
    post.warnings.add(:base, 'Warning 1')
    post.warnings.add(:base, 'Warning 2')
    post.warnings.add(:base, 'Warning 3')

    @output_buffer = bootstrap_form_for(post, &:error_and_warning_alert_boxes)

    assert_select 'div.alert', 1
    assert_select 'div.alert.alert-warning' do
      assert_select 'li', 3
    end
  end

  test 'error_and_warning_alert_boxes display base and target warnings' do
    post = Post.new
    post.warnings.add(:base, 'Base Warning 1')
    post.warnings.add(:somewhere1, 'Warning 1')
    post.warnings.add(:somewhere2, 'Warning 2')

    bootstrap_form_for post do |form|
      @output_buffer = form.error_and_warning_alert_boxes

      assert_select 'div.alert', 1
      assert_select 'div.alert.alert-warning' do
        assert_select 'p', text: I18n.t('warnings.alertbox.base')
        assert_select 'p', text: I18n.t('warnings.alertbox.other.editing')
        assert_select 'li', 3
        assert_select 'li', html: post.warnings[:base].to_sentence
        assert_select 'li', html: form.label(:somewhere1) + ' ' + post.warnings[:somewhere1].to_sentence
        assert_select 'li', html: form.label(:somewhere2) + ' ' + post.warnings[:somewhere2].to_sentence
      end
    end
  end

  test 'error_and_warning_alert_boxes display readonly base and target warnings' do
    post = Post.new
    post.warnings.add(:base, 'Base Warning 1')
    post.warnings.add(:somewhere1, 'Warning 1')
    post.warnings.add(:somewhere2, 'Warning 2')

    bootstrap_form_for post do |form|
      form.readonly = true
      @output_buffer = form.error_and_warning_alert_boxes

      assert_select 'div.alert', 1
      assert_select 'div.alert.alert-warning' do
        assert_select 'p', text: I18n.t('warnings.alertbox.base')
        assert_select 'p', text: I18n.t('warnings.alertbox.other.readonly')
        assert_select 'li', 3
        assert_select 'li', html: post.warnings[:base].to_sentence
        assert_select 'li', html: Post.human_attribute_name(:somewhere1) + ' ' + post.warnings[:somewhere1].to_sentence
        assert_select 'li', html: Post.human_attribute_name(:somewhere2) + ' ' + post.warnings[:somewhere2].to_sentence
      end
    end
  end

  test 'error_and_warning_alert_boxes should not raise in the absence of base errors/warnings' do
    post = Post.new
    post.errors.add(:somewhere1, 'Error 1')
    post.warnings.add(:somewhere1, 'Warning 1')

    assert_nothing_raised do
      bootstrap_form_for post do |form|
        form.error_and_warning_alert_boxes
      end
    end
  end
end
