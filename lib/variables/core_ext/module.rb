require 'variables/class_variable'
require 'variables/core_ext/object'

module Variables
  module CoreExt
    module Module
      def class_variable(name)
        ClassVariable.new(self, name)
      end

      def class_variable_fetch(name, *args, &block)
        fetch_variable(:class_variable, name, *args, &block)
      end

      def class_variable_replace(name, *args, &block)
        replace_variable(:class_variable, name, *args, &block)
      end
    end
  end
end

Module.send(:include, Variables::CoreExt::Module)
