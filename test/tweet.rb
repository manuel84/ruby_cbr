class Tweet
  include CBR::Case

  attr_accessor :value, :published_at

  def cbr_attributes
    {"published_at" => Time.parse("Wed, 01 Feb 2017 11:47:12 +0100"), "favorite_count" => 1, "retweet_count" => 1, "user_statuses_count" => 1, "user_followers_count" => 1, "user_friends_count" => 1, "user_listed_count" => 1, "user_favourites_count" => 1, "user_created_at" => Time.parse("2017-07-13 07:56:35 UTC"), "user_verified" => true, "user_geo_enabled" => true}
  end

  def cbr_config
    {"published_at" => {"value" => "{{now}}", "similarity" => "DateSimilarity", "max_distance" => "10", "weight" => "25"}, "favorite_count" => {"value" => "100", "similarity" => "NumericSimilarity", "max_distance" => "", "weight" => "27"}, "retweet_count" => {"value" => "20", "similarity" => "NumericSimilarity", "max_distance" => "", "weight" => "25"}, "user_statuses_count" => {"value" => "0", "similarity" => "NumericSimilarity", "max_distance" => "", "weight" => "23"}, "user_followers_count" => {"value" => "0", "similarity" => "NumericSimilarity", "max_distance" => "", "weight" => "26"}, "user_friends_count" => {"value" => "0", "similarity" => "NumericSimilarity", "max_distance" => "", "weight" => "26"}, "user_listed_count" => {"value" => "0", "similarity" => "NumericSimilarity", "max_distance" => "", "weight" => "15"}, "user_favourites_count" => {"value" => "0", "similarity" => "NumericSimilarity", "max_distance" => "", "weight" => "19"}, "user_created_at" => {"value" => "2010-01-01 00:00:00 +0100", "similarity" => "DateSimilarity", "max_distance" => "", "weight" => "24"}, "user_verified" => {"value" => "true", "similarity" => "StringSimilarity", "max_distance" => "", "weight" => "78"}, "user_geo_enabled" => {"value" => "true", "similarity" => "StringSimilarity", "max_distance" => "", "weight" => "8"}}
  end

  def cbr_target_case
    Tweet.new
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
