require 'singleton'
module CBR
  class Engine
    include Singleton
    attr_accessor :dedicated_cases, :treshold, :config

    def initialize
      @config ||= CBR::Config.instance
      @treshold = BigDecimal.new('0.0')
    end


    def retrieve(c, treshold=nil)
      result = []
      attributes = c.cbr_attributes
      if attributes
        target_case = c.cbr_target_case
        @config ||= CBR::Config.instance
        cbr_config = target_case.cbr_config
        @config.similarities = cbr_config if cbr_config
        @config.calculate_relative_weights!
        treshold ||= @treshold
        treshold = BigDecimal.new(treshold)
        cases.each do |c|
          c.compared_case = target_case
          c.score_details = {}
          attributes.each do |attr_name, attr_value|
            c.score_details[attr_name] = @config.weighted_similarity(c, attr_name, attr_value)
          end
          c.score = c.score_details.values.map {|ws| ws[:value]}.reduce(:+)
          #pp c.score
          result << c if c.score >= treshold
        end
      end
      result
    end

    def retrieve_all(c)
      all_treshold = BigDecimal.new('0.0')
      retrieve(c, all_treshold)
    end

    def calculate_score(c)
      attributes = c.cbr_attributes
      if attributes
        target_case = c.cbr_target_case
        @config ||= CBR::Config.instance
        cbr_config = target_case.cbr_config
        @config.similarities = cbr_config if cbr_config
        @config.calculate_relative_weights!
        c.compared_case = target_case
        c.score_details = {}
        attributes.select {|a_name, a_val| @config.similarities.keys.include?(a_name)}.each do |attr_name, attr_value|
          c.score_details[attr_name] = @config.weighted_similarity(c, attr_name, attr_value)
        end
        c.score_details['penalty'] = c.cbr_penalty
        c.score = [BigDecimal.new(1), [BigDecimal.new(0), (c.score_details.values.map {|ws| ws[:value]}.reduce(:+))].min].max
        c.score
      end
      c
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
