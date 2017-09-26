require 'active_support/all'

module CBR
  class Similarity
    class DateSimilarity < Similarity

      def initialize(opts={})
        opts[:borderpoints] = Hash[opts[:borderpoints].map {|k, v| [date_time_of(k.to_s), v]}]
        super(opts)
      end

      def compare(real_value)
        real_value = date_time_of(real_value)
        return BigDecimal('0.0') if real_value.nil?
        score(real_value)
      end

      def date_time_of(str)
        return str.to_datetime if str.is_a?(Date) or str.is_a?(Time)
        return 10.years.ago if str.nil?
        result = Time.now if str.eql?('{{now}}')
        result ||= Time.yesterday if str.eql?('{{yesterday}}')
        result ||= eval(str) rescue nil
        result ||= DateTime.parse(str)
        result.to_datetime
      end
    end
  end
end
