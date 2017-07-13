module CBR
  class Similarity
    class StringSimilarity < Similarity

      def initialize(opts={})
        opts[:max_distance] ||= 20
        super(opts)
      end

      def compare(target_value, real_value)
        real_distance = BigDecimal.new(Levenshtein.distance(real_value.to_s, target_value.to_s))
        super(BigDecimal.new('1.0'), real_distance)
      end
    end
  end
end
