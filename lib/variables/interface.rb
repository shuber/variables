module Variables
  module Interface
    def method_prefix
      raise NotImplementedError
    end

    def variable_prefix
      raise NotImplementedError
    end
  end
end
