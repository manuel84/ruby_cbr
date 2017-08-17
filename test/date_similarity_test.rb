require 'test_helper'
require 'pp'

class DateSimilarityTest < Minitest::Test

  def setup
    @c1 = Tweet.new
    @c1.cbr_config = {
        'published_at' =>
            {'value' => '{{now}}',
             'similarity' => 'DateSimilarity',
             'tolerance_distance' => '3600', # {{1.hours}}
             'tolerance_distance_value' => '95',
             'max_distance' => '864000', # {{10.days}}
             'max_distance_value' => '7',
             'regression' => 'linear',
             'weight' => '25'}
    }
    CBR::Engine.instance.dedicated_cases = [@c1]
  end

  def test_date_under_max_under_target # 1
    @c1.cbr_attributes['published_at'] = Time.now - 1.year
    scored_case = @c1.cbr_query
    assert_equal 0.0, scored_case.score_details['published_at'][:local_similarity].to_f
  end

  def test_date_max_under_target # 2
    @c1.cbr_attributes['published_at'] = Time.now - 10.days
    scored_case = @c1.cbr_query
    assert_equal 0.07, scored_case.score_details['published_at'][:local_similarity].to_f
  end

  def test_date_in_range_under_target # 3
    @c1.cbr_attributes['published_at'] = Time.now - 6.days
    scored_case = @c1.cbr_query
    assert_in_delta 0.4, scored_case.score_details['published_at'][:local_similarity].to_f, 0.1
  end

  def test_date_tolerance_under_target # 4
    @c1.cbr_attributes['published_at'] = Time.now - 1.hour
    scored_case = @c1.cbr_query
    assert_equal 0.95, scored_case.score_details['published_at'][:local_similarity].to_f
  end

  def test_date_over_tolerance_under_target # 5
    @c1.cbr_attributes['published_at'] = Time.now - 30.minutes
    scored_case = @c1.cbr_query
    assert_equal 0.95, scored_case.score_details['published_at'][:local_similarity].to_f
  end

  def test_date_target # 6
    @c1.cbr_attributes['published_at'] = Time.now
    scored_case = @c1.cbr_query
    assert_equal 1.0, scored_case.score_details['published_at'][:local_similarity].to_f
  end

  # outreach

  def test_date_under_tolerance_over_target # 7
    @c1.cbr_attributes['published_at'] = Time.now + 40.minutes
    scored_case = @c1.cbr_query
    assert_equal 1.0, scored_case.score_details['published_at'][:local_similarity].to_f
  end

  def test_date_tolerance_over_target # 8
    @c1.cbr_attributes['published_at'] = Time.now + 1.hour
    scored_case = @c1.cbr_query
    assert_equal 1.0, scored_case.score_details['published_at'][:local_similarity].to_f
  end

  def test_date_in_range_over_target # 9
    @c1.cbr_attributes['published_at'] = Time.now + 5.hours
    scored_case = @c1.cbr_query
    assert_equal 1.0, scored_case.score_details['published_at'][:local_similarity].to_f
  end

  def test_date_max_over_target # 10
    @c1.cbr_attributes['published_at'] = Time.now + 10.days
    scored_case = @c1.cbr_query
    assert_equal 1.0, scored_case.score_details['published_at'][:local_similarity].to_f
  end

  def test_date_over_max_over_target # 11
    @c1.cbr_attributes['published_at'] = Time.now + 11.days
    scored_case = @c1.cbr_query
    assert_equal 1.0, scored_case.score_details['published_at'][:local_similarity].to_f
  end


  # no outreach

  def test_date_under_tolerance_over_target_nooutreached # 7
    @c1.cbr_config['published_at']['outreach'] = false
    @c1.cbr_attributes['published_at'] = Time.now + 40.minutes
    scored_case = @c1.cbr_query
    assert_equal 0.95, scored_case.score_details['published_at'][:local_similarity].to_f
  end

  def test_date_tolerance_over_target_nooutreached # 8
    @c1.cbr_config['published_at']['outreach'] = false
    @c1.cbr_attributes['published_at'] = Time.now + 1.hour
    scored_case = @c1.cbr_query
    assert_equal 0.95, scored_case.score_details['published_at'][:local_similarity].to_f
  end

  def test_date_in_range_over_target_nooutreached # 9
    @c1.cbr_config['published_at']['outreach'] = false
    @c1.cbr_attributes['published_at'] = Time.now + 7.days
    scored_case = @c1.cbr_query
    assert_in_delta 0.3, scored_case.score_details['published_at'][:local_similarity].to_f, 0.1
  end

  def test_date_max_over_target_nooutreached # 10
    @c1.cbr_config['published_at']['outreach'] = false
    @c1.cbr_attributes['published_at'] = Time.now + 10.days
    scored_case = @c1.cbr_query
    assert_in_delta 0.07, scored_case.score_details['published_at'][:local_similarity].to_f, 0.01
  end

  def test_date_over_max_over_target_nooutreached # 11
    @c1.cbr_config['published_at']['outreach'] = false
    @c1.cbr_attributes['published_at'] = Time.now + 11.days
    scored_case = @c1.cbr_query
    assert_equal 0.0, scored_case.score_details['published_at'][:local_similarity].to_f
  end
end
