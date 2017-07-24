require 'active_support/all'

module CBR
  class Similarity
    class DateSimilarity < Similarity

      def initialize(opts={})
        opts[:max_distance] ||= (100.days).to_i * 60 # in minutes
        super(opts)
      end

      def compare(target_value, real_value)
        real_value = Time.now if real_value.eql?('{{now}}')
        target_value = Time.now if target_value.eql?('{{now}}')
        real_value = Time.yesterday if real_value.eql?('{{yesterday}}')
        target_value = Time.yesterday if target_value.eql?('{{yesterday}}')
        return BigDecimal('0.0') if real_value.nil? or target_value.nil?
        target_value = Time.parse(target_value) if target_value.is_a?(String)
        real_value = Time.parse(real_value) if real_value.is_a?(String)
        real_distance = BigDecimal.new(((target_value - real_value) / 24).to_i, 2).abs # in minutes
        tv = BigDecimal.new(((Time.now-target_value)/24).to_i, 2)
        if tv.zero?
          tv += 1
          real_distance += 1
        end
        super(tv, real_distance)
      end
    end
  end
end
