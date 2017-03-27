require 'test_helper'

# Test bootstrap form builder form labels with translation based tooltips.
class LabelTooltipsTest < ActionView::TestCase
  tests ActionView::Helpers::FormHelper
  include NdrUi::BootstrapHelper

  test 'should include tooltips when translations exist' do
    post = Post.new
    NdrUi::BootstrapBuilder.any_instance.stubs(:display?).returns(true)

    I18n.expects(:translate).
      with(:'tooltips.post.created_at', raise: true).
      returns('Tooltip')

    @output_buffer =
      bootstrap_form_for post do |form|
        form.label :created_at, 'Test'
      end

    assert_select 'span', attributes: { class: '.question-tooltip', text: 'Tooltip' }
  end

  test 'should not include tooltips when there is no translation' do
    post = Post.new
    NdrUi::BootstrapBuilder.any_instance.stubs(:display?).returns(true)

    @output_buffer =
      bootstrap_form_for post do |form|
        form.stubs(:translate_tooltip).returns('translation missing')
        form.label :created_at
      end

    assert_select '.question-tooltip', 0
  end

  test 'should not include tooltips when translations is a hash' do
    post = Post.new
    NdrUi::BootstrapBuilder.any_instance.stubs(:display?).returns(true)

    I18n.expects(:translate).
      with(:'tooltips.post.created_at', raise: true).
      returns(one: 'One', other: 'Other')

    @output_buffer =
      bootstrap_form_for post do |form|
        form.label :created_at, 'Test'
      end

    assert_select '.question-tooltip', 0
  end

  test 'should allow tooltip text to be set explicitly' do
    post = Post.new
    NdrUi::BootstrapBuilder.any_instance.stubs(:display?).returns(true)

    @output_buffer =
      bootstrap_form_for post do |form|
        form.stubs(:translate_tooltip).returns('Tooltip')
        form.label :created_at, tooltip: 'Not the translated value'
      end

    assert_select '.question-tooltip', attributes: { text: 'Not the translated value' }
  end

  test 'should allow tooltips to be suppressed' do
    post = Post.new
    NdrUi::BootstrapBuilder.any_instance.stubs(:display?).returns(true)

    @output_buffer =
      bootstrap_form_for post do |form|
        form.label :created_at, tooltip: false
      end

    assert_select '.question-tooltip', 0
  end
end
