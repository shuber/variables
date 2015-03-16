require 'variables/class_variable'

module Variables
  module CoreExt
    module Module
      def class_variable(name)
        ClassVariable.new(self, name)
      end

      def class_variable_fetch(name, *args, &block)
        class_variable(name).fetch(*args, &block)
      end

      def class_variable_replace(*args, &block)
        class_variable(name).replace(*args, &block)
      end
    end
  end
end
