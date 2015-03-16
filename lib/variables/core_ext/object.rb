require 'variables/instance_variable'

module Variables
  module CoreExt
    module Object
      def instance_variable(name)
        InstanceVariable.new(self, name)
      end

      def instance_variable_fetch(name, *args, &block)
        instance_variable(name).fetch(*args, &block)
      end

      def instance_variable_replace(name, *args, &block)
        instance_variable(name).replace(*args, &block)
      end
    end
  end
end
