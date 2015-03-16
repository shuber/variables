require 'abstract_class'
require 'variables/interface'
require 'variables/undefined_variable'

module Variables
  class Variable
    extend AbstractClass
    include Interface

    attr_reader :owner, :name

    def initialize(owner, name)
      @owner = owner
      @name = normalize(name)
    end

    def defined?
      variable(:defined?, name)
    end

    def fetch(*args)
      # We have to explicitly reference `self` here
      # since `defined?` is a `Kernel` method
      if self.defined?
        get
      elsif args.any?
        args.first
      elsif block_given?
        yield(name)
      else
        raise UndefinedVariable, "undefined variable #{name.inspect}"
      end
    end

    def get
      variable(:get, name)
    end

    def replace(value, &block)
      if block_given?
        replace_with_block(value, &block)
      else
        replace_without_block(value)
      end
    end

    def set(value)
      variable(:set, name, value)
    end

    private

    def normalize(name)
      name.to_s.sub(/^([^#{variable_prefix}])/, "#{variable_prefix}\\1")
    end

    def variable(method, *args)
      owner.send("#{method_prefix}_variable_#{method}", *args)
    end

    def replace_with_block(value)
      existing = replace_without_block(value)
      yield
    ensure
      replace_without_block(existing)
    end

    def replace_without_block(value)
      existing = get
      set(value)
      existing
    end
  end
end
