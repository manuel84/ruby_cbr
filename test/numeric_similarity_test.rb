require 'test_helper'
require 'pp'

class NumericSimilarityTest < Minitest::Test

  def test_numeric_interval_under_min
    c1 = Tweet.new
    #c1.cbr_attributes['favorite_count'] = 0
    c1.cbr_attributes = {'favorite_count' => 95 }
    CBR::Engine.instance.dedicated_cases = [c1]
    scored_case = c1.cbr_query
    assert_equal 1.0, scored_case.score_details['favorite_count'][:local_similarity].to_f
  end

  def test_numeric_interval_min
    c1 = Tweet.new
    c1.cbr_attributes['favorite_count'] = 95
    CBR::Engine.instance.dedicated_cases = [c1]
    scored_case = c1.cbr_query
    assert_equal 1.0, scored_case.score_details['favorite_count'][:local_similarity].to_f
  end

  def test_numeric_interval_in_range
    c1 = Tweet.new
    c1.cbr_attributes['favorite_count'] = 80
    CBR::Engine.instance.dedicated_cases = [c1]
    scored_case = c1.cbr_query
    assert_equal 0.5, scored_case.score_details['favorite_count'][:local_similarity].to_f
    #assert_in_delta 0.5, scored_case.score_details['favorite_count'][:local_similarity].to_f, 0.1
  end

  def test_numeric_interval_max
    c1 = Tweet.new
    c1.cbr_attributes['favorite_count'] = 70
    CBR::Engine.instance.dedicated_cases = [c1]
    scored_case = c1.cbr_query
    assert_equal 0.0, scored_case.score_details['favorite_count'][:local_similarity].to_f
  end

  def test_numeric_interval_over_max
    c1 = Tweet.new
    c1.cbr_attributes['favorite_count'] = 50
    CBR::Engine.instance.dedicated_cases = [c1]
    scored_case = c1.cbr_query
    assert_equal 0.0, scored_case.score_details['favorite_count'][:local_similarity].to_f
  end

  def test_numeric_interval_outreach
    c1 = Tweet.new
    c1.cbr_attributes['favorite_count'] = 150
    CBR::Engine.instance.dedicated_cases = [c1]
    scored_case = c1.cbr_query
    assert_equal 1.0, scored_case.score_details['favorite_count'][:local_similarity].to_f
  end
end
