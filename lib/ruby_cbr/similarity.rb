module CBR
  class Similarity
    attr_accessor :options

    def initialize(opts={})
      @options = opts
      @options[:outreach] = true if @options[:outreach].nil?
      @options[:tolerance_distance] ||= 0.0
      @options[:max_distance] ||= 10.0
      @options[:tolerance_distance] = BigDecimal.new(@options[:tolerance_distance], 4)
      @options[:max_distance] = BigDecimal.new(@options[:max_distance], 4)
      if @options[:tolerance_distance_value]
        @options[:tolerance_distance_value] = BigDecimal.new(@options[:tolerance_distance_value])/100.0
      end
      @options[:tolerance_distance_value] ||= BigDecimal.new('1.0')
      if @options[:max_distance_value]
        @options[:max_distance_value] = BigDecimal.new(@options[:max_distance_value])/100.0
      end
      @options[:max_distance_value] ||= BigDecimal.new('0.0')
    end

    def score(real_distance)
      zero = BigDecimal.new('0.0')
      one = BigDecimal.new('1.0')

      return one if real_distance.zero?
      return zero if real_distance < zero and real_distance.abs > @options[:max_distance]
      return @options[:max_distance_value] if real_distance < zero and real_distance.abs == @options[:max_distance]
      if @options[:outreach] # non symmetric evaluation, 1.0 if real_distance > tolerance
        return one if real_distance > zero
        return @options[:tolerance_distance_value] if real_distance.abs <= @options[:tolerance_distance]
      else # symmetric evaluation
        return @options[:tolerance_distance_value] if real_distance.abs <= @options[:tolerance_distance]
        return zero if real_distance.abs > @options[:max_distance]
      end
      range = BigDecimal.new(@options[:max_distance] - @options[:tolerance_distance], 4)
      return zero if range.zero? # avoid divison by zero
      result = one - BigDecimal.new(((real_distance.abs-@options[:tolerance_distance]) / range), 4)
      result *= (@options[:tolerance_distance_value] - @options[:max_distance_value])
      result += @options[:max_distance_value]
      [result, [result, @options[:tolerance_distance_value]].max].min
    end
  end
end
