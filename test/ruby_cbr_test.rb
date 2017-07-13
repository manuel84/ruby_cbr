require 'test_helper'
require 'pp'

class RubyCbrTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RubyCbr::VERSION
  end

  def test_tweet_extending_case
    t1 = Tweet.new
    t2 = Tweet.new

    CBR::Engine.instance.dedicated_cases = [t1, t2]
    scored_case = t1.cbr_query
    pp scored_case.score.to_f
    pp scored_case.compared_case
  end
end
