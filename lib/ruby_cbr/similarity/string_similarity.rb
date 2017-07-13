module CBR
  class Similarity
    class StringSimilarity < Similarity

      def initialize(opts={})
        opts[:max_distance] ||= 20
        super(opts)
      end

      def compare(value, target_value)
        real_distance = BigDecimal.new(Levenshtein.distance(value.to_s, target_value.to_s))
        super(real_distance, BigDecimal.new('1.0'))
      end
    end
  end
end
