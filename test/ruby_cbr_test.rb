require 'test_helper'
require 'pp'

class RubyCbrTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RubyCbr::VERSION
  end

  def test_tweet_extending_case
    t1 = Tweet.new
    t1.value = 'Hallo Welt'
    t1.published_at = Time.now
    t = Tweet.new
    t.value = 'Hallolo Welt'
    t.published_at = Time.now - 50*24*60*60

    CBR::Engine.instance.dedicated_cases = [t1, t]
    scored_cases = t.cbr_query
    pp scored_cases.map {|x| x.score.to_f}
    pp scored_cases.map(&:compared_case)
  end
end
