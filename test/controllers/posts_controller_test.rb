require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test 'index' do
    get :index
    assert :success
  end
end
