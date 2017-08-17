require 'active_support/all'

module CBR
  class Similarity
    class DateSimilarity < Similarity

      def initialize(opts={})
        opts[:tolerance_distance] ||= (2.hours).to_i * 3600 # in seconds
        opts[:max_distance] ||= (10.days).to_i * 3600 # in seconds
        super(opts)
      end

      def compare(target_value, real_value)
        target_value = Time.now if target_value.eql?('{{now}}')
        target_value = Time.yesterday if target_value.eql?('{{yesterday}}')
        return BigDecimal('0.0') if real_value.nil? or target_value.nil?
        target_value = Time.parse(target_value) if target_value.is_a?(String)
        real_value = Time.parse(real_value) if real_value.is_a?(String)
        real_distance = BigDecimal.new((real_value - target_value).to_i, 4) # in seconds
        score(real_distance)
      end
    end
  end
end
