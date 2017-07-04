class Tweet
  include CBR::Case

  attr_accessor :value

  def cbr_attributes
    {value: self.value}
  end
end
