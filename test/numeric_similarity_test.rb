require 'test_helper'
require 'pp'

class NumericSimilarityTest < Minitest::Test

  def setup
    @c1 = Tweet.new
    @c1.cbr_config = {
        'favourite_count' =>
            {'borderpoints' => '1,0
6,0.4
20,0.9
100,1',
             'similarity' => 'NumericSimilarity',
             'weight' => '25'}
    }
    CBR::Engine.instance.dedicated_cases = [@c1]
  end

  def test_date_before_first
    @c1.cbr_attributes['favourite_count'] = 0
    scored_case = @c1.cbr_query
    assert_equal 0.0, scored_case.score_details['favourite_count'][:local_similarity].to_f
  end

  def test_date_on_first
    @c1.cbr_attributes['favourite_count'] = 1
    scored_case = @c1.cbr_query
    assert_equal 0.0, scored_case.score_details['favourite_count'][:local_similarity].to_f
  end

  def test_date_between_first_and_r1
    @c1.cbr_attributes['favourite_count'] = 2
    scored_case = @c1.cbr_query
    assert_in_delta 0.1, scored_case.score_details['favourite_count'][:local_similarity].to_f, 0.1
  end

  def test_date_on_r1
    @c1.cbr_attributes['favourite_count'] = 6
    scored_case = @c1.cbr_query
    assert_equal 0.4, scored_case.score_details['favourite_count'][:local_similarity].to_f
  end

  def test_date_between_r1_and_r2
    @c1.cbr_attributes['favourite_count'] = 13
    scored_case = @c1.cbr_query
    assert_in_delta 0.7, scored_case.score_details['favourite_count'][:local_similarity].to_f, 0.05
  end

  def test_date_on_r2
    @c1.cbr_attributes['favourite_count'] = 20
    scored_case = @c1.cbr_query
    assert_equal 0.9, scored_case.score_details['favourite_count'][:local_similarity].to_f
  end

  def test_date_between_r2_and_last
    @c1.cbr_attributes['favourite_count'] = 60
    scored_case = @c1.cbr_query
    assert_in_delta 0.95, scored_case.score_details['favourite_count'][:local_similarity].to_f, 0.05
  end

  def test_date_between_r2_and_last2
    @c1.cbr_attributes['favourite_count'] = 80
    scored_case = @c1.cbr_query
    assert_in_delta 0.99, scored_case.score_details['favourite_count'][:local_similarity].to_f, 0.05
  end

  def test_date_on_last
    @c1.cbr_attributes['favourite_count'] = 100
    scored_case = @c1.cbr_query
    assert_equal 1.0, scored_case.score_details['favourite_count'][:local_similarity].to_f
  end

  def test_date_after_last
    @c1.cbr_attributes['favourite_count'] = 2000
    scored_case = @c1.cbr_query
    assert_equal 1.0, scored_case.score_details['favourite_count'][:local_similarity].to_f
  end
end
