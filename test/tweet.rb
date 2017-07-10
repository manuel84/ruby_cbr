class Tweet
  include CBR::Case

  attr_accessor :value, :published_at

  def cbr_attributes
    {"published_at"=>nil, "favorite_count"=>0, "retweet_count"=>0, "user_statuses_count"=>0, "user_followers_count"=>0, "user_friends_count"=>0, "user_listed_count"=>0, "user_favourites_count"=>0, "user_created_at"=>Time.now, "user_verified"=>true, "user_geo_enabled"=>true}
  end

  def cbr_config
    {'published_at' => {'value' => '{{now}}', 'similarity' => 'DateSimilarity', 'max_distance' => '10', 'weight' => '25'}, 'favorite_count' => {'value' => '100', 'similarity' => 'NumericSimilarity', 'max_distance' => '0', 'weight' => '27'}, 'retweet_count' => {'value' => '20', 'similarity' => 'NumericSimilarity', 'max_distance' => '0', 'weight' => '25'}, 'user_statuses_count' => {'value' => '0', 'similarity' => 'NumericSimilarity', 'max_distance' => '0', 'weight' => '23'}, 'user_followers_count' => {'value' => '0', 'similarity' => 'NumericSimilarity', 'max_distance' => '0', 'weight' => '26'}, 'user_friends_count' => {'value' => '0', 'similarity' => 'NumericSimilarity', 'max_distance' => '0', 'weight' => '26'}, 'user_listed_count' => {'value' => '0', 'similarity' => 'NumericSimilarity', 'max_distance' => '0', 'weight' => '15'}, 'user_favourites_count' => {'value' => '0', 'similarity' => 'NumericSimilarity', 'max_distance' => '0', 'weight' => '19'}, 'user_created_at' => {'value' => '2010-01-01 00:00:00 +0100', 'similarity' => 'DateSimilarity', 'max_distance' => '0', 'weight' => '24'}, 'user_verified' => {'value' => 'true', 'similarity' => 'StringSimilarity', 'max_distance' => '0', 'weight' => '78'}, 'user_geo_enabled' => {'value' => 'true', 'similarity' => 'StringSimilarity', 'max_distance' => '0', 'weight' => '8'}}
  end

  def favorite_count
    0
  end

  def retweet_count
    1
  end

  def user_statuses_count
    2
  end

  def user_followers_count
    3
  end

  def user_friends_count
    4
  end

  def user_listed_count
    5
  end

  def user_favourites_count
    6
  end

  def user_created_at
    Time.now - 4.days
  end

  def user_verified
    true
  end

  def user_geo_enabled
    true
  end
end
