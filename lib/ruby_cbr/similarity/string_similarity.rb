module CBR
  class Similarity
    class StringSimilarity < Similarity

      def initialize(opts={})
        opts[:max_distance] ||= 20
        super(opts)
      end

      def compare(a, b)
        real_distance = BigDecimal.new(Levenshtein.distance(a.to_s, b.to_s))
        transform(normalize(real_distance))
      end
    end
  end
end
