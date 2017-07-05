require 'singleton'
module CBR
  class Engine
    include Singleton
    attr_accessor :dedicated_cases, :treshold, :config

    def initialize
      @config ||= CBR::Config.instance
      @treshold = BigDecimal.new('0.0')
    end

    def retrieve(compared_case, treshold=nil)
      result = []
      attributes = compared_case.cbr_attributes
      if attributes
        @config ||= CBR::Config.instance
        @config.calculate_relative_weights
        treshold ||= @treshold
        treshold = BigDecimal.new(treshold)
        cases.each do |c|
          c.compared_case = compared_case
          c.score = attributes.map do |attr_name, attr_value|
            @config.weighted_similarity(c, attr_name, attr_value)
          end.reduce(:+)
          result << c if c.score >= treshold
        end
      end
      result
    end

    def retrieve_all(attributes)
      all_treshold = BigDecimal.new('0.0')
      retrieve(attributes, all_treshold)
    end

    def cases
      if dedicated_cases
        dedicated_cases
      else
        ObjectSpace.each_object(Class).select {|c| c.included_modules.include? CBR::Case}.map(&:all).reduce(:+)
      end
    end

  end
end
