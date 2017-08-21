require 'test_helper'
require 'pp'

class NumericSimilarityTest < Minitest::Test

  def setup
    @c1 = Tweet.new
    @c1.cbr_config = {
        'favourite_count' =>
            {'value' => '10',
             'similarity' => 'NumericSimilarity',
             'tolerance_distance' => '2', # {{1.hours}}
             'tolerance_distance_value' => '95',
             'max_distance' => '8', # {{10.days}}
             'max_distance_value' => '7',
             'regression' => 'linear',
             'weight' => '25'}
    }
    CBR::Engine.instance.dedicated_cases = [@c1]
  end

  def test_numeric_under_max_under_target # 1
    @c1.cbr_attributes['favourite_count'] = 0
    scored_case = @c1.cbr_query
    assert_equal 0.0, scored_case.score_details['favourite_count'][:local_similarity].to_f
  end

  def test_numeric_max_under_target # 2
    @c1.cbr_attributes['favourite_count'] = 2
    scored_case = @c1.cbr_query
    assert_equal 0.07, scored_case.score_details['favourite_count'][:local_similarity].to_f
  end

  def test_numeric_in_range_under_target # 3
    @c1.cbr_attributes['favourite_count'] = 5
    scored_case = @c1.cbr_query
    assert_in_delta 0.5, scored_case.score_details['favourite_count'][:local_similarity].to_f, 0.1
  end

  def test_numeric_tolerance_under_target # 4
    @c1.cbr_attributes['favourite_count'] = 8
    scored_case = @c1.cbr_query
    assert_equal 0.95, scored_case.score_details['favourite_count'][:local_similarity].to_f
  end

  def test_numeric_over_tolerance_under_target # 5
    @c1.cbr_attributes['favourite_count'] = 9
    scored_case = @c1.cbr_query
    assert_equal 0.95, scored_case.score_details['favourite_count'][:local_similarity].to_f
  end

  def test_numeric_target # 6
    @c1.cbr_attributes['favourite_count'] = 10
    scored_case = @c1.cbr_query
    assert_equal 1.0, scored_case.score_details['favourite_count'][:local_similarity].to_f
  end

  # outreach

  def test_numeric_under_tolerance_over_target # 7
    @c1.cbr_attributes['favourite_count'] = 11
    scored_case = @c1.cbr_query
    assert_equal 1.0, scored_case.score_details['favourite_count'][:local_similarity].to_f
  end

  def test_numeric_tolerance_over_target # 8
    @c1.cbr_attributes['favourite_count'] = 12
    scored_case = @c1.cbr_query
    assert_equal 1.0, scored_case.score_details['favourite_count'][:local_similarity].to_f
  end

  def test_numeric_in_range_over_target # 9
    @c1.cbr_attributes['favourite_count'] = 14
    scored_case = @c1.cbr_query
    assert_equal 1.0, scored_case.score_details['favourite_count'][:local_similarity].to_f
  end

  def test_numeric_max_over_target # 10
    @c1.cbr_attributes['favourite_count'] = 18
    scored_case = @c1.cbr_query
    assert_equal 1.0, scored_case.score_details['favourite_count'][:local_similarity].to_f
  end

  def test_numeric_over_max_over_target # 11
    @c1.cbr_attributes['favourite_count'] = 50
    scored_case = @c1.cbr_query
    assert_equal 1.0, scored_case.score_details['favourite_count'][:local_similarity].to_f
  end


  # no outreach

  def test_numeric_under_tolerance_over_target_nooutreached # 7
    @c1.cbr_config['favourite_count']['outreach'] = false
    @c1.cbr_attributes['favourite_count'] = 11
    scored_case = @c1.cbr_query
    assert_equal 0.95, scored_case.score_details['favourite_count'][:local_similarity].to_f
  end

  def test_numeric_tolerance_over_target_nooutreached # 8
    @c1.cbr_config['favourite_count']['outreach'] = false
    @c1.cbr_attributes['favourite_count'] = 12
    scored_case = @c1.cbr_query
    assert_equal 0.95, scored_case.score_details['favourite_count'][:local_similarity].to_f
  end

  def test_numeric_in_range_over_target_nooutreached # 9
    @c1.cbr_config['favourite_count']['outreach'] = false
    @c1.cbr_attributes['favourite_count'] = 16
    scored_case = @c1.cbr_query
    assert_in_delta 0.3, scored_case.score_details['favourite_count'][:local_similarity].to_f, 0.1
  end

  def test_numeric_max_over_target_nooutreached # 10
    @c1.cbr_config['favourite_count']['outreach'] = false
    @c1.cbr_attributes['favourite_count'] = 18
    scored_case = @c1.cbr_query
    assert_in_delta 0.07, scored_case.score_details['favourite_count'][:local_similarity].to_f, 0.01
  end

  def test_numeric_over_max_over_target_nooutreached # 11
    @c1.cbr_config['favourite_count']['outreach'] = false
    @c1.cbr_attributes['favourite_count'] = 50
    scored_case = @c1.cbr_query
    assert_equal 0.0, scored_case.score_details['favourite_count'][:local_similarity].to_f
  end
end
