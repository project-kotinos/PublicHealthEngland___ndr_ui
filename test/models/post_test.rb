require 'test_helper'

# Test dummy app Post model
class PostTest < ActiveSupport::TestCase
  test 'should create post' do
    post = Post.create
    assert post.persisted?
  end
end
