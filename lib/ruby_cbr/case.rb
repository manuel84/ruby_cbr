module CBR
  module Case
    attr_accessor :cbr, :compared_case, :score

    def cbr_query
      @cbr ||= CBR::Engine.instance
      @cbr.config.similarities[self.class.name] = self.cbr_config
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
