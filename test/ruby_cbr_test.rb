require 'test_helper'
require 'pp'

class RubyCbrTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RubyCbr::VERSION
  end
end
