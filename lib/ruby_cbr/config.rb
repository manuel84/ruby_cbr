require 'singleton'
require 'pp'
require 'active_support/core_ext/hash/indifferent_access'

module CBR
  class Config
    include Singleton

    attr_accessor :similarities

    def initialize
      @similarities = {}
      @similarities.default = {
          'Tweet': {
              similarity: 'StringSimilarity',
              weight: 1,
              values: nil,
              max_distance: 2,
              default: '',
              display_name: '(not set)',
              display_type: 'text'
          }
      }
    end

    def calculate_relative_weights!
      @similarities = @similarities.with_indifferent_access
      total_weights = @similarities.values.map {|attributes| attributes[:weight]}.flatten.reduce(BigDecimal.new('0.0')) do |memo, w|
        memo += BigDecimal.new(w)
      end
      @similarities.each do |attr_name, attr_values|
        attr_values[:weight] = BigDecimal.new(attr_values[:weight])
        attr_values[:rel_weight] = attr_values[:weight] / total_weights
      end
      @similarities
    end

    def similarity(c, attr_name, attr_value)
      #('CBR::Similarity::'+@similarities[c.class.name][attr][:similarity]).constantize
      attr_config = @similarities[attr_name].with_indifferent_access
      opts = {}
      opts[:borderpoints] = {}
      opts[:borderpoints] = Hash[attr_config[:borderpoints].split("\n").map {|line| line.split(',')}]
      class_name = 'CBR::Similarity::'+attr_config[:similarity]
      similarity_class = Object.const_get(class_name).new(opts)
      similarity_class.compare(attr_value)
    end

    def weighted_similarity(c, attr_name, attr_value)
      attr_config = @similarities[attr_name]
      weight = attr_config[:rel_weight]
      similarity = similarity(c, attr_name, attr_value)
      {
          weight: weight,
          local_similarity: similarity,
          value: weight * similarity
      }
    end

  end
end
