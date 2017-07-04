module CBR
  class Similarity
    class BooleanSimilarity < Similarity

      def compare(a, b)
        a == b ? BigDecimal.new('1.0') : BigDecimal.new('0.0')
      end
    end
  end
end
