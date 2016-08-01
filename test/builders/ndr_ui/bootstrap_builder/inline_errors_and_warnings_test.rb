require 'test_helper'

# Test bootstrap form builder inline errors
class InlineErrorsAndWarningsTest < ActionView::TestCase
  tests ActionView::Helpers::FormHelper
  include NdrUi::BootstrapHelper

  test 'each field should have a single help-block' do
    post = Post.new

    bootstrap_form_for post do |form|
      assert_dom_equal(
        '<input class="form-control" type="text" name="post[created_at]" id="post_created_at" />' \
        '<span class="help-block" data-feedback-for="post_created_at">' \
        '<span class="text-danger"></span><span class="text-warning"></span>' \
        '</span>',
        form.text_field(:created_at)
      )
    end
  end

  test 'should display warnings' do
    post = Post.new
    post.warnings[:created_at] << 'some' << 'message'

    bootstrap_form_for post do |form|
      assert_dom_equal(
        '<input class="form-control" type="text" name="post[created_at]" id="post_created_at" />' \
        '<span class="help-block" data-feedback-for="post_created_at">' \
        '<span class="text-danger"></span><span class="text-warning">some<br>message</span>' \
        '</span>',
        form.text_field(:created_at)
      )
    end
  end

  test 'should display errors' do
    post = Post.new
    post.errors.add(:created_at, 'not')
    post.errors.add(:created_at, 'great')

    bootstrap_form_for post do |form|
      assert_dom_equal(
        '<input class="form-control" type="text" name="post[created_at]" id="post_created_at" />' \
        '<span class="help-block" data-feedback-for="post_created_at">' \
        '<span class="text-danger">not<br>great</span><span class="text-warning"></span>' \
        '</span>',
        form.text_field(:created_at)
      )
    end
  end
end
