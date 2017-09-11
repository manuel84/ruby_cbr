module CBR
  class Similarity
    class BooleanSimilarity < Similarity

      def compare(real_value)
        one = BigDecimal.new('1.0', 4)
        zero = BigDecimal.new('0.0', 4)
        result = BigDecimal.new((real_value && 1 || 0))
        result = [result, one].min # max 1
        result = [result, zero].max # min 0
        result
      end
    end
  end
end
