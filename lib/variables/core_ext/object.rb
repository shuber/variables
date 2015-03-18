require 'variables/instance_variable'
require 'variables/variable_methods'

module Variables
  module CoreExt
    module Object
      include VariableMethods

      def instance_variable(name)
        InstanceVariable.new(self, name)
      end

      def instance_variable_fetch(name, *args, &block)
        fetch_variable_with(:instance_variable, name, *args, &block)
      end

      def instance_variable_replace(name, *args, &block)
        replace_variable_with(:instance_variable, name, *args, &block)
      end
    end
  end
end
