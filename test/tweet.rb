class Tweet
  include CBR::Case

  attr_accessor :value, :published_at

  def cbr_attributes
    {value: self.value, published_at: self.published_at}
  end
end
