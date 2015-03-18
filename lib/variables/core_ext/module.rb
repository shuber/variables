require 'variables/class_variable'
require 'variables/variable_methods'

module Variables
  module CoreExt
    module Module
      include VariableMethods

      def class_variable(name)
        ClassVariable.new(self, name)
      end

      def class_variable_fetch(name, *args, &block)
        fetch_variable_with(:class_variable, name, *args, &block)
      end

      def class_variable_replace(name, *args, &block)
        replace_variable_with(:class_variable, name, *args, &block)
      end
    end
  end
end
