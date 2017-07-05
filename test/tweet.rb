class Tweet
  include CBR::Case

  attr_accessor :value, :published_at

  def cbr_attributes
    {value: self.value, published_at: self.published_at}
  end

  def cbr_config
    {
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
  end
end
