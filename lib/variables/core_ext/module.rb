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

      def class_variable_replace(name, *args, &block)
        if args.empty? && name.is_a?(Hash)
          class_variable_replace_hash(name, &block).call
        else
          class_variable(name).replace(*args, &block)
        end
      end

      private

      def class_variable_replace_hash(hash, &block)
        hash.reduce(block) do |original, (name, value)|
          proc do
            class_variable(name).replace(value) do
              original.call
            end
          end
        end
      end
    end
  end
end
