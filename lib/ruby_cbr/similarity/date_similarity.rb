require 'active_support/all'

module CBR
  class Similarity
    class DateSimilarity < Similarity

      def initialize(opts={})
        opts[:max_distance] ||= (100.days).to_i * 60 # in minutes
        super(opts)
      end

      def score(normalized_distance)
        # target_value = 10
        # real_value = 4
        # max_distance = 3 (A)
        # max_distance = nil (B)
        # normalized_value = 7 (A)
        # normalized_value = 4 (B)
        md = @options[:max_distance] ? @options[:max_distance] : BigDecimal.new(@options[:target_value])
        (md - normalized_distance) / md
      end

      def compare(real_value, target_value)
        real_value = Time.zone.now if real_value.eql?('{{now}}')
        target_value = Time.zone.now if target_value.eql?('{{now}}')
        real_value = Time.zone.yesterday if real_value.eql?('{{yesterday}}')
        target_value = Time.zone.yesterday if target_value.eql?('{{yesterday}}')

        return BigDecimal('0.0') if real_value.nil? or target_value.nil?
        real_distance = BigDecimal((target_value-real_value) / (24).to_i, 2).abs # in minutes
        tv = BigDecimal.new((Time.now - target_value), 2)
        super(real_distance, tv)
      end
    end
  end
end
