require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test 'page loads' do
    assert_nothing_raised do
      visit '/posts'
      page.raise_server_error!
    end
  end
end
