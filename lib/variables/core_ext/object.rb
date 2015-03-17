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
        if args.empty? && name.is_a?(Hash)
          instance_variable_replace_hash(name, &block).call
        else
          instance_variable(name).replace(*args, &block)
        end
      end

      private

      def instance_variable_replace_hash(hash, &block)
        hash.reduce(block) do |original, (name, value)|
          proc do
            instance_variable(name).replace(value) do
              original.call
            end
          end
        end
      end
    end
  end
end
