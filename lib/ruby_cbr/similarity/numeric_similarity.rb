module CBR
  class Similarity
    class NumericSimilarity < Similarity

      def initialize(opts={})
        super(opts)
      end

      def compare(target_value, real_value)
        real_distance = (BigDecimal.new(real_value) - BigDecimal.new(target_value)).abs
        super(BigDecimal.new(target_value), real_distance)
      end
    end
  end
end
