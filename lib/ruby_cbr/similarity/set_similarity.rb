module CBR
  class Similarity
    class SetSimilarity < Similarity

      def initialize(opts={})
        opts[:target_set] = {}
        opts[:borderpoints].each do |k, v|
          if k.start_with?('{{') and k.end_with?('}}')
            method = k.gsub('{{', '').gsub('}}', '')
            opts[:target_set] = opts[:case].send(method)
          end
        end

        opts[:borderpoints] = Hash[opts[:borderpoints].map {|k, v| [max_value_of(k, opts), v]}]
        super(opts)
      end

      def compare(real_value)
        intersection = real_value & @options[:target_set].keys
        val = intersection.map {|k| @options[:target_set][k]}.sum
        score(val)
      end

      def max_value_of(val, opts)
        if val.start_with?('{{') and val.end_with?('}}')
          method = val.gsub('{{', '').gsub('}}', '')
          target_set = opts[:case].send(method)
          target_set.values.max || 0
        else
          0
        end
      end
    end
  end
end
