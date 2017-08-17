class Tweet
  include CBR::Case

  attr_accessor :cbr_attributes, :cbr_config

  def initialize
    @cbr_attributes = {
        'published_at' => Time.now, #Time.parse('Thu, 06 Jul 2017 16:01:53 +0200'),
        'title' => 'Hallo Welt',
        'favorite_count' => 1,
        'retweet_count' => 10,
        'user_statuses_count' => 10,
        'user_followers_count' => 1,
        'user_friends_count' => 1,
        'user_listed_count' => 1,
        'user_favourites_count' => 1,
        #'user_created_at' => Time.parse('2017-07-06 14:24:11 UTC'),
        'user_verified' => true,
        'user_geo_enabled' => true
    }
    @cbr_config = {
        'published_at' =>
            {'value' => '{{now}}',
             'similarity' => 'DateSimilarity',
             'tolerance_distance' => '7200', # {{2.hours}}
             'max_distance' => '864000', # {{10.days}}
             'weight' => '25'}
    }
  end

  def cbr_target_case
    t = Tweet.new
    t.cbr_config = @cbr_config
    t
  end

  def favorite_count
    cbr_attributes['favorite_count']
  end

  def retweet_count
    cbr_attributes['retweet_count']
  end

  def user_statuses_count
    cbr_attributes['user_statuses_count']
  end

  def user_followers_count
    cbr_attributes['user_followers_count']
  end

  def user_friends_count
    cbr_attributes['user_friends_count']
  end

  def user_listed_count
    cbr_attributes['user_listed_count']
  end

  def user_favourites_count
    cbr_attributes['user_favourites_count']
  end

  def user_created_at
    cbr_attributes['user_created_at']
  end

  def user_verified
    cbr_attributes['user_verified']
  end

  def user_geo_enabled
    cbr_attributes['user_geo_enabled']
  end
end
