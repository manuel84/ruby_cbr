module CBR
  class Similarity
    class DateSimilarity < Similarity

      def initialize(opts={})
        opts[:max_distance] ||= 100.days
        super(opts)
      end

      def normalize(real_distance)# TODO: ...
        max_distance = @options[:max_distance]
        [max_distance, real_distance].min
      end

      def transform(normalized_distance)# TODO: ...
        max_distance = BigDecimal.new(@options[:max_distance])
        (max_distance - normalized_distance) / max_distance
      end

      def compare(a, b)
        real_distance = (a-b).abs
        transform(normalize(real_distance))
      end
    end
  end
end
