module CBR
  class Similarity
    class NumericSimilarity < Similarity

      def initialize(opts={})
        super(opts)
      end

      def compare(real_value, target_value)
        real_distance = (BigDecimal.new(real_value) - BigDecimal.new(target_value)).abs
        super(real_distance, target_value)
      end
    end
  end
end
