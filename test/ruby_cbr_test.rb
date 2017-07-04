require 'test_helper'

class RubyCbrTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RubyCbr::VERSION
  end

  def test_tweet_extending_case
    t1 = Tweet.new
    t1.value = 'Hallo Welt'
    t1.published_at = Time.now
    t = Tweet.new
    t.value = 'Hallolo Welt'
    t.published_at = Time.now - 50*24*60*60
    CBR::Config.instance.similarities['Tweet'] = {
        value: {
            similarity: 'StringSimilarity',
            weight: 1,
            values: nil,
            #max_distance: 30,
            default: '',
            display_name: '(not set)',
            display_type: 'text'
        },
        published_at: {
            similarity: 'DateSimilarity',
            weight: 20,
            values: nil,
            max_distance: 30,
            default: '',
            display_name: '(not set)',
            display_type: 'text'
        }
    }
    CBR::Engine.instance.cases = [t1, t]
    cases = t.query
    puts cases.map {|x| x.score.to_f}
    puts cases.map(&:compared_case)
  end
end
