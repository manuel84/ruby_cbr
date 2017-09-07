module CBR
  class Similarity
    class StringSimilarity < Similarity

      def initialize(opts={})
        super(opts)
      end

      def compare(real_value)
        real_distance = BigDecimal.new(Levenshtein.distance(real_value.to_s, @options[:borderpoints].keys.last))
        one = BigDecimal.new('1.0', 4)
        zero = BigDecimal.new('0.0', 4)
        begin_val = BigDecimal.new(@options[:borderpoints].first.last, 4)
        target_val = BigDecimal.new(@options[:borderpoints].values.last, 4)
        m = one / (target_val - begin_val)
        x = target_val - real_distance - begin_val
        [(m * x), zero].max
      end
    end
  end
end
