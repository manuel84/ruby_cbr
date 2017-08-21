module CBR
  class Similarity
    class NumericSimilarity < Similarity

      def initialize(opts={})
        opts[:tolerance_distance] ||= 0.0
        opts[:max_distance] ||= 10.0
        super(opts)
      end

      def compare(target_value, real_value)
        real_value = BigDecimal.new(real_value, 4)
        target_value = BigDecimal.new(target_value, 4)
        return BigDecimal('1.0') if @options[:outreach] and real_value >= target_value
        real_distance = (real_value - target_value)
        score(real_distance)
      end
    end
  end
end
