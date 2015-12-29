require 'test_helper'

class NdrUiTest < ActiveSupport::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::NdrUi::VERSION
  end

  test 'truth' do
    assert_kind_of Module, NdrUi
  end
end
