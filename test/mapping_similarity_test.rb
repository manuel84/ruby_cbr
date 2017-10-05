require 'test_helper'
require 'pp'

class MappingSimilarityTest < Minitest::Test

  def setup
    @c1 = Tweet.new
    @c1.cbr_config = {
        'type' =>
            {'borderpoints' => 'tweet,0.3
reply,0.01
quote,0.01
retweet,0.01
Hallo Welt,20
{{default}},0.04',
             'similarity' => 'MappingSimilarity',
             'weight' => '47'}
    }
    CBR::Engine.instance.dedicated_cases = [@c1]
  end

  def test_mapping
    @c1.cbr_attributes['type'] = 'tweet'
    scored_case = @c1.cbr_query
    assert_equal 0.3, scored_case.score_details['type'][:local_similarity].to_f
  end

  def test_default
    @c1.cbr_attributes['type'] = 'xyz'
    scored_case = @c1.cbr_query
    assert_equal 0.04, scored_case.score_details['type'][:local_similarity].to_f
  end

end
