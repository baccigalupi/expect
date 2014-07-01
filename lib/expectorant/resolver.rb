module Expectorant
  class Resolver
    attr_reader :object, :block

    def initialize(object, block)
      @object = object
      @block = block
    end

    def argument
      raise ArgumentError.new('Expectations must take in either a value for comparison, or a block') if no_argument?
      @argument ||= object == NullArgument ? block : object
    end

    def no_argument?
      object == NullArgument && !block
    end

    def value
      argument.respond_to?(:call) ? argument.call : argument
    end

    NullArgument = Class.new
  end
end
