require 'test_helper'
require 'pp'

class StringSimilarityTest < Minitest::Test

  def test_same_string
    c1 = Tweet.new
    #c1.cbr_attributes['favorite_count'] = 0
    c1.cbr_attributes = {'title' => 'Hello World'}
    CBR::Engine.instance.dedicated_cases = [c1]
    scored_case = c1.cbr_query
    assert_equal 1.0, scored_case.score_details['title'][:local_similarity].to_f
  end

  def test_similar_string
    c1 = Tweet.new
    #c1.cbr_attributes['favorite_count'] = 0
    c1.cbr_attributes = {'title' => 'Hallo Werlt'}
    CBR::Engine.instance.dedicated_cases = [c1]
    scored_case = c1.cbr_query
    assert_equal 0.875, scored_case.score_details['title'][:local_similarity].to_f
  end

  def test_different_string
    c1 = Tweet.new
    #c1.cbr_attributes['favorite_count'] = 0
    c1.cbr_attributes = {'title' => 'Etwas ganz anderes'}
    CBR::Engine.instance.dedicated_cases = [c1]
    scored_case = c1.cbr_query
    assert_equal 0.0, scored_case.score_details['title'][:local_similarity].to_f
  end

end
