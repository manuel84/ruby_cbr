require 'test_helper'
require 'pp'

class StringSimilarityTest < Minitest::Test

  def setup
    @c1 = Tweet.new
    @c1.cbr_config = {
        'title' =>
            {'borderpoints' => ',6
Hallo Welt,20',
             'similarity' => 'StringSimilarity',
             'weight' => '47'}
    }
    CBR::Engine.instance.dedicated_cases = [@c1]
  end

  def test_same_string
    @c1.cbr_attributes['title'] = 'Hallo Welt'
    scored_case = @c1.cbr_query
    assert_equal 1.0, scored_case.score_details['title'][:local_similarity].to_f
  end

  def test_similar_string
    @c1.cbr_attributes['title'] = 'Hallo Werlt'
    scored_case = @c1.cbr_query
    assert_in_delta 0.95, scored_case.score_details['title'][:local_similarity].to_f, 0.1
  end

  def test_different_string
    @c1.cbr_attributes['title'] = 'Etwas ganz anderes'
    scored_case = @c1.cbr_query
    assert_equal 0.0, scored_case.score_details['title'][:local_similarity].to_f
  end

end
