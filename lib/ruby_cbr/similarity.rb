module CBR
  class Similarity
    attr_accessor :options

    def initialize(opts={})
      @options = opts
      @options[:max_distance] ||= 0
    end

    def normalize(real_distance)
      max_distance = BigDecimal.new(@options[:max_distance])
      [max_distance, real_distance].min
    end

    def transform(normalized_distance)
      max_distance = BigDecimal.new(@options[:max_distance])
      (max_distance - normalized_distance) / max_distance
    end

    def compare(a, b)
      BigDecimal.new('0.0')
    end
  end
end
