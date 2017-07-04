module CBR
  module Case
    attr_accessor :cbr, :compared_case, :score
    def query
      @cbr ||= CBR::Engine.instance
      @cbr.retrieve_all(self)
    end

    #def cbr_attributes
  end
end
