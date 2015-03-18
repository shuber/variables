module Variables
  module VariableMethods
    private

    def fetch_variable_with(variable, name, *args, &block)
      send(variable, name).fetch(*args, &block)
    end

    def replace_variable_with(variable, name, *args, &block)
      if name.is_a?(Hash) && args.empty?
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
