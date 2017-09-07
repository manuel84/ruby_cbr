module CBR
  class Similarity
    attr_accessor :options

    def initialize(opts={})
      @options = opts
      @borderpoints = @options[:borderpoints].keys.sort
      @options[:borderpoints].each {|k, v| @options[:borderpoints][k] = BigDecimal.new(v)}
      @ranges = @borderpoints.map.with_index {|p, i| (p...(@borderpoints[i+1])) if i+1 < @borderpoints.size}.compact
    end

    def score(real_value)
      zero = BigDecimal.new('0.0')
      result = BigDecimal.new('1.0')
      comparable_borderpoints = @borderpoints.map(&:to_s)
      if comparable_borderpoints.include?(real_value.to_s)
        i = comparable_borderpoints.index(real_value.to_s)
        result = @options[:borderpoints][@options[:borderpoints].keys[i]]
      elsif real_value < @borderpoints.first
        result = zero
      elsif real_value > @borderpoints.last
        result = @options[:borderpoints][@borderpoints.last]
      else
        @ranges.each do |range|
          result = score_in_range(real_value, range) if range.cover?(real_value)
        end
      end
      result
    end

    def score_in_range(real_value, range)
      m = (@options[:borderpoints][range.end] - @options[:borderpoints][range.begin]) / (range.end-range.begin)
      x = (real_value - range.begin)
      n = @options[:borderpoints][range.begin]
      m * x + n
    end
  end
end
