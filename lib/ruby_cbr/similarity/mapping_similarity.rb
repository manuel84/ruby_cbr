module CBR
  class Similarity
    class MappingSimilarity < Similarity

      def initialize(opts={})
        opts[:mapping] = {}
        opts[:mapping].default = BigDecimal.new(0)
        opts[:borderpoints].each do |k, v|
          if k.eql?('{{default}}')
            opts[:mapping].default = BigDecimal.new(v)
          else
            opts[:mapping][k] = BigDecimal(v, 4)
          end
        end
        # maybe normalize mapping
        super(opts)
      end

      def compare(real_value)
        @options[:mapping][real_value]
      end
    end
  end
end
