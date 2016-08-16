require 'test_helper'

module NdrUi
  # Test CSS helpers
  class CssHelperTest < ActionView::TestCase
    test 'css_class_options_merge' do
      assert_equal({}, css_class_options_merge({}))

      original_options = {}
      assert_equal(
        { class: 'form-control' },
        css_class_options_merge(original_options, ['form-control'])
      )

      original_options = { 'data-url' => '/vim/...', 'class' => 'col-md-6', 'value' => nil }
      assert_equal(
        {
          "data-url": '/vim/...',
          class: 'form-control col-md-6',
          value: nil
        },
        css_class_options_merge(original_options, ['form-control'])
      )

      original_options = { 'data-url' => '/vim/...', 'class' => '', 'value' => nil }
      assert_equal(
        {
          "data-url": '/vim/...',
          class: 'form-control',
          value: nil
        },
        css_class_options_merge(original_options, ['form-control']) do |css_classes|
          css_classes << 'col-md-6' if false
        end
      )

      original_options = { 'data-url' => '/vim/...', 'class' => '', 'value' => nil }
      assert_equal(
        {
          "data-url": '/vim/...',
          class: 'form-control col-md-6',
          value: nil
        },
        css_class_options_merge(original_options, ['form-control']) do |css_classes|
          css_classes << 'col-md-6' if true
        end
      )
    end
  end
end
