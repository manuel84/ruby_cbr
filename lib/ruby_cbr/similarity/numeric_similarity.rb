module CBR
  class Similarity
    class NumericSimilarity < Similarity

      def initialize(opts={})
        opts[:max_distance] ||= 1000
        super(opts)
      end

      def compare(a, b)
        real_distance = (BigDecimal.new(a) - BigDecimal.new(b)).abs
        transform(normalize(real_distance))
      end
    end
  end
end
