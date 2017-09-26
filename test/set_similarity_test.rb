require 'test_helper'
require 'pp'

class SetSimilarityTest < Minitest::Test

  def setup
    @c1 = Tweet.new

    def @c1.target_tags
      {
          'SGE' => 1,
          'Sport' => 1,
          'Bundesliga' => 10,
          'Fußball' => 5,
          'Eintracht' => 3,
          'Schalke' => -3
      }
    end

    @c1.cbr_config = {
        'tag_names' =>
            {'borderpoints' => ',0.1
{{target_tags}},1',
             'similarity' => 'SetSimilarity',
             'weight' => '25'}
    }
    CBR::Engine.instance.dedicated_cases = [@c1]
  end

  def test_set_before_first
    @c1.cbr_attributes['tag_names'] = %w(Schalke) # = -3
    scored_case = @c1.cbr_query
    assert_equal 0.0, scored_case.score_details['tag_names'][:local_similarity].to_f
  end

  def test_set_on_first
    @c1.cbr_attributes['tag_names'] = %w() # = 0
    scored_case = @c1.cbr_query
    assert_equal 0.1, scored_case.score_details['tag_names'][:local_similarity].to_f
  end

  def test_set_between_first_and_last
    @c1.cbr_attributes['tag_names'] = %w(SGE) # = 1
    scored_case = @c1.cbr_query
    assert_in_delta 0.1, scored_case.score_details['tag_names'][:local_similarity].to_f, 0.1
  end

  def test_set_on_last
    @c1.cbr_attributes['tag_names'] = %w(SGE Sport Eintracht) # = 5
    scored_case = @c1.cbr_query
    assert_equal 1.0, scored_case.score_details['tag_names'][:local_similarity].to_f
  end

  def test_set_on_last
    @c1.cbr_attributes['tag_names'] = %w(Bundesliga) # = 10 (max value is target value)
    scored_case = @c1.cbr_query
    assert_equal 1.0, scored_case.score_details['tag_names'][:local_similarity].to_f
  end

  def test_set_after_last
    @c1.cbr_attributes['tag_names'] = %w(Bundesliga Eintracht) # = 13
    scored_case = @c1.cbr_query
    assert_equal 1.0, scored_case.score_details['tag_names'][:local_similarity].to_f
  end
end
