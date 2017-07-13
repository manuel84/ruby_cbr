module CBR
  class Similarity
    attr_accessor :options

    def initialize(opts={})
      @options = opts
      @options[:max_distance] = BigDecimal.new(@options[:max_distance]) if @options[:max_distance]
    end

    def normalize(real_distance)
      # target_value = 10
      # real_value = 4
      # max_distance = 3 (A)
      # max_distance = nil (B)
      # normalized_value = 7 (A)
      # normalized_value = 4 (B)
      raise Exception if real_distance < 0
      normalized_distance = real_distance
      normalized_distance = [@options[:max_distance], real_distance].min if @options[:max_distance]
      normalized_distance
    end


    def score(normalized_distance)
      # target_value = 10
      # real_value = 4
      # max_distance = 3 (A)
      # max_distance = nil (B)
      # normalized_value = 7 (A)
      # normalized_value = 4 (B)
      md = @options[:max_distance].present? ? @options[:max_distance] : BigDecimal.new(@options[:target_value])
      return BigDecimal.new('0.0') if md.zero?
      (md - normalized_distance) / md
    end

    def normalize2(real_value)
      # target_value = 10
      # real_value = 4
      # max_distance = 3 (A)
      # max_distance = nil (B)
      # normalized_value = 7 (A)
      # normalized_value = 4 (B)
      normalized_value = real_value
      normalized_value = [(@options[:target_value] - @options[:max_distance]), real_value].max if @options[:max_distance]
      normalized_value
    end


    def score2(normalized_value)
      # target_value = 10
      # real_value = 4
      # max_distance = 3 (A)
      # max_distance = nil (B)
      # normalized_value = 7 (A)
      # normalized_value = 4 (B)
      md = @options[:max_distance] ? @options[:max_distance] : BigDecimal.new('0.0')
      (normalized_value - md) / @options[:target_value]
    end

    def compare(target_value, real_distance)
      @options[:target_value] = BigDecimal.new(target_value)
      return BigDecimal.new('0.0') if @options[:target_value].zero? # avoid divison by zero
      result = score(normalize(real_distance)) # real value as calculated sitance
      result
    end
  end
end
