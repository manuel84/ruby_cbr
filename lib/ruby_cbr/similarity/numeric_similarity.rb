module CBR
  class Similarity
    class NumericSimilarity < Similarity

      def initialize(opts={})
        opts[:borderpoints] = Hash[opts[:borderpoints].map {|k, v| [BigDecimal.new(k, 4), v]}]
        super(opts)
      end

      def compare(real_value)
        real_value = BigDecimal.new(real_value, 4)
        score(real_value)
      end
    end
  end
end
