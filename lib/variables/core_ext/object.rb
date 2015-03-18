require 'variables/instance_variable'

module Variables
  module CoreExt
    module Object
      def instance_variable(name)
        InstanceVariable.new(self, name)
      end

      def instance_variable_fetch(name, *args, &block)
        fetch_variable(:instance_variable, name, *args, &block)
      end

      def instance_variable_replace(name, *args, &block)
        replace_variable(:instance_variable, name, *args, &block)
      end

      private

      def fetch_variable(variable, name, *args, &block)
        send(variable, name).fetch(*args, &block)
      end

      def replace_variable(variable, name, *args, &block)
        if name.is_a?(Hash) && args.empty? && block_given?
          replace_variable_proc(variable, name, &block).call
        else
          send(variable, name).replace(*args, &block)
        end
      end

      def replace_variable_proc(variable, hash, &block)
        hash.reduce(block) do |original, (name, value)|
          proc do
            send(variable, name).replace(value) do
              original.call
            end
          end
        end
      end
    end
  end
end

Object.send(:include, Variables::CoreExt::Object)
