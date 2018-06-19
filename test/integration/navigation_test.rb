require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test 'something' do
    visit '/posts'
    assert page.has_content?('Posts#index')
    require 'pry'; binding.pry
  end
end
