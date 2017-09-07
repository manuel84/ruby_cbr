require 'test_helper'
require 'pp'

class DateSimilarityTest < Minitest::Test

  def setup
    @c1 = Tweet.new
    @c1.cbr_config = {
        'published_at' =>
            {'borderpoints' => '6.days.ago,0.07
4.days.ago,0.2
2.days.ago,0.4
{{now}},1',
             'similarity' => 'DateSimilarity',
             'weight' => '25'}
    }
    CBR::Engine.instance.dedicated_cases = [@c1]
  end

  def test_date_before_first
    @c1.cbr_attributes['published_at'] = Time.now - 1.year
    scored_case = @c1.cbr_query
    assert_equal 0.0, scored_case.score_details['published_at'][:local_similarity].to_f
  end

  def test_date_on_first
    @c1.cbr_attributes['published_at'] = 6.days.ago
    scored_case = @c1.cbr_query
    assert_equal 0.07, scored_case.score_details['published_at'][:local_similarity].to_f
  end

  def test_date_between_first_and_r1
    @c1.cbr_attributes['published_at'] = 5.days.ago
    scored_case = @c1.cbr_query
    assert_in_delta 0.1, scored_case.score_details['published_at'][:local_similarity].to_f, 0.1
  end

  def test_date_on_r1
    @c1.cbr_attributes['published_at'] = 4.days.ago
    scored_case = @c1.cbr_query
    assert_equal 0.2, scored_case.score_details['published_at'][:local_similarity].to_f
  end

  def test_date_between_r1_and_r2
    @c1.cbr_attributes['published_at'] = 3.days.ago
    scored_case = @c1.cbr_query
    assert_in_delta 0.3, scored_case.score_details['published_at'][:local_similarity].to_f, 0.05
  end

  def test_date_on_r2
    @c1.cbr_attributes['published_at'] = 2.days.ago
    scored_case = @c1.cbr_query
    assert_equal 0.4, scored_case.score_details['published_at'][:local_similarity].to_f
  end

  def test_date_between_r2_and_last
    @c1.cbr_attributes['published_at'] = 1.days.ago
    scored_case = @c1.cbr_query
    assert_in_delta 0.7, scored_case.score_details['published_at'][:local_similarity].to_f, 0.05
  end

  def test_date_between_r2_and_last2
    @c1.cbr_attributes['published_at'] = 10.minutes.ago
    scored_case = @c1.cbr_query
    assert_in_delta 0.99, scored_case.score_details['published_at'][:local_similarity].to_f, 0.05
  end

  def test_date_on_last
    @c1.cbr_attributes['published_at'] = Time.now
    scored_case = @c1.cbr_query
    assert_equal 1.0, scored_case.score_details['published_at'][:local_similarity].to_f
  end

  def test_date_after_last
    @c1.cbr_attributes['published_at'] = Time.now + 5.hours
    scored_case = @c1.cbr_query
    assert_equal 1.0, scored_case.score_details['published_at'][:local_similarity].to_f
  end

end
