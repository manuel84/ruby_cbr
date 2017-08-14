require 'test_helper'
require 'pp'

class DateSimilarityTest < Minitest::Test

  def test_date_interval_under_min
    c1 = Tweet.new
    c1.cbr_attributes['published_at'] = Time.now - 1.hours
    CBR::Engine.instance.dedicated_cases = [c1]
    scored_case = c1.cbr_query
    assert_equal 1.0, scored_case.score_details['published_at'][:local_similarity].to_f
  end

  def test_date_interval_min
    c1 = Tweet.new
    c1.cbr_attributes['published_at'] = Time.now - 2.hours
    CBR::Engine.instance.dedicated_cases = [c1]
    scored_case = c1.cbr_query
    assert_equal 1.0, scored_case.score_details['published_at'][:local_similarity].to_f
  end

  def test_date_interval_in_range
    c1 = Tweet.new
    c1.cbr_attributes['published_at'] = Time.now - 2.days
    CBR::Engine.instance.dedicated_cases = [c1]
    scored_case = c1.cbr_query
    assert_in_delta 0.8, scored_case.score_details['published_at'][:local_similarity].to_f, 0.1
  end

  def test_date_interval_max
    c1 = Tweet.new
    c1.cbr_attributes['published_at'] = Time.now - 10.days
    CBR::Engine.instance.dedicated_cases = [c1]
    scored_case = c1.cbr_query
    assert_equal 0.0, scored_case.score_details['published_at'][:local_similarity].to_f
  end

  def test_date_interval_over_max
    c1 = Tweet.new
    c1.cbr_attributes['published_at'] = Time.now - 2.years
    CBR::Engine.instance.dedicated_cases = [c1]
    scored_case = c1.cbr_query
    assert_equal 0.0, scored_case.score_details['published_at'][:local_similarity].to_f
  end
end
