require 'variables/variable'

module Variables
  class ClassVariable < Variable
    def get
      super
    rescue NameError
    end

    def method_prefix
      'class'
    end

    def variable_prefix
      '@@'
    end
  end
end
