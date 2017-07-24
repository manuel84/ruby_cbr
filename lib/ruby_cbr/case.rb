module CBR
  module Case
    attr_accessor :cbr, :compared_case, :score, :score_details

    def cbr_query
      @cbr ||= CBR::Engine.instance
      @cbr.calculate_score(self)
    end

    def cbr_retrieve
      @cbr ||= CBR::Engine.instance
      @cbr.retrieve_all(self)
    end

    def cbr_config
      raise NotImplementedError
    end

    def cbr_attributes
      raise NotImplementedError
    end
  end
end
