require 'active_support/all'

module CBR
  class Similarity
    class DateSimilarity < Similarity

      def initialize(opts={})
        opts[:max_distance] ||= 100.days
        super(opts)
      end

      def normalize(real_distance)# TODO: ...
        max_distance = @options[:max_distance].to_i
        [max_distance, real_distance].min
      end

      def transform(normalized_distance)# TODO: ...
        max_distance = BigDecimal.new(@options[:max_distance])
        (max_distance - normalized_distance) / max_distance
      end

      def compare(a, b)
        a = Time.zone.now if a.eql?('{{now}}')
        b = Time.zone.now if b.eql?('{{now}}')
        a = Time.zone.yesterday if a.eql?('{{yesterday}}')
        b = Time.zone.yesterday if b.eql?('{{yesterday}}')
        return BigDecimal('0.0') if a.nil? or b.nil?
        real_distance = ((a-b) / (24)).to_i # in minutes
        transform(normalize(real_distance))
      end
    end
  end
end
