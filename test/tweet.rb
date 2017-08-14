class Tweet
  include CBR::Case

  attr_accessor :cbr_attributes

  def initialize
    @cbr_attributes = {'published_at' => Time.now, #Time.parse('Thu, 06 Jul 2017 16:01:53 +0200'),
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
                       'user_geo_enabled' => true}
  end

  def cbr_config
    {'published_at' =>
         {'value' => '{{now}}',
          'similarity' => 'DateSimilarity',
          'tolerance_distance' => '7200', # {{2.hours}}
          'max_distance' => '864000', # {{10.days}}
          'weight' => '25'},
     'title' =>
         {'value' => 'Hello World',
          'similarity' => 'StringSimilarity',
          'weight' => '25'},
     'favorite_count' =>
         {'value' => '100',
          'similarity' => 'NumericSimilarity',
          'tolerance_distance' => '10',
          'max_distance' => '30',
          'weight' => '400'},
     'retweet_count' =>
         {'value' => '20',
          'similarity' => 'NumericSimilarity',
          'max_distance' => '0',
          'weight' => '25'},
     'user_statuses_count' =>
         {'value' => '10',
          'similarity' => 'NumericSimilarity',
          'max_distance' => '0',
          'weight' => '23'},
     'user_followers_count' =>
         {'value' => '0',
          'similarity' => 'NumericSimilarity',
          'max_distance' => '0',
          'weight' => '26'},
     'user_friends_count' =>
         {'value' => '0',
          'similarity' => 'NumericSimilarity',
          'max_distance' => '0',
          'weight' => '26'},
     'user_listed_count' =>
         {'value' => '0',
          'similarity' => 'NumericSimilarity',
          'max_distance' => '0',
          'weight' => '15'},
     'user_favourites_count' =>
         {'value' => '0',
          'similarity' => 'NumericSimilarity',
          'max_distance' => '0',
          'weight' => '19'},
     'user_created_at' =>
         {'value' => '2010-01-01 00:00:00 +0100',
          'similarity' => 'DateSimilarity',
          'max_distance' => '9000000',
          'weight' => '24'},
     'user_verified' =>
         {'value' => 'true',
          'similarity' => 'StringSimilarity',
          'max_distance' => '0',
          'weight' => '78'},
     'user_geo_enabled' =>
         {'value' => 'true',
          'similarity' => 'StringSimilarity',
          'max_distance' => '0',
          'weight' => '8'}}
  end

  def cbr_target_case
    Tweet.new
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
