require 'variables/variable'

module Variables
  class InstanceVariable < Variable
    def method_prefix
      'instance'
    end

    def variable_prefix
      '@'
    end
  end
end
