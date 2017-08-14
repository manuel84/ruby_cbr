module CBR
  class Similarity
    attr_accessor :options

    def initialize(opts={})
      @options = opts
      @options[:outreach] = true
      @options[:tolerance_distance] ||= 0.0
      @options[:max_distance] ||= 10.0
      @options[:tolerance_distance] = BigDecimal.new(@options[:tolerance_distance], 4)
      @options[:max_distance] = BigDecimal.new(@options[:max_distance], 4)
    end

    def score(real_distance)
      range = BigDecimal.new(@options[:max_distance] - @options[:tolerance_distance], 4)
      return BigDecimal.new('0.0') if range.zero? # avoid divison by zero
      return BigDecimal.new('1.0') if real_distance <= @options[:tolerance_distance]
      return BigDecimal.new('0.0') if real_distance >= @options[:max_distance]
      BigDecimal.new('1.0', 4) - BigDecimal.new(((real_distance-@options[:tolerance_distance]) / range), 4)
    end
  end
end
