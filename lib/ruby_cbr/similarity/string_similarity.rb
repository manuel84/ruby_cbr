module CBR
  class Similarity
    class StringSimilarity < Similarity

      def initialize(opts={})
        opts[:tolerance_distance] ||= 2.0
        opts[:max_distance] ||= 10.0
        super(opts)
      end

      def compare(target_value, real_value)
        real_distance = BigDecimal.new(Levenshtein.distance(real_value.to_s, target_value.to_s))
        score(real_distance)
      end
    end
  end
end
