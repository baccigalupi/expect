module Expectorant
  class Expector
    attr_reader :test_context, :expected, :asserter, :delegates

    def initialize(test_context)
      @test_context = test_context
      @asserter = Asserter.new(test_context)
      @delegates = {}
    end

    # ------ setup
    def expect(a=Resolver::NullArgument, &block)
      asserter.reset
      asserter.actuals(a, block)
      self
    end

    # chaining methods for the DSL ------

    def to
      self
    end

    alias :should :to
    alias :be :to
    alias :is :to

    def not
      asserter.negate
      self
    end

    alias :should_not :not
    alias :not_to :not
    alias :to_not :not

    # ----- delegation to asserters
    
    def registrar
      Expectorant.registrar
    end

    def method_missing(method_name, *args, &block)
      if klass = registrar.get(method_name)
        delegate = delegate_for(klass) || build_delegate(klass)
        delegate.send(method_name, *args, &block)
      else
        super
      end
    end

    def delegate_for(klass)
      delegate = delegates.detect{|name, d| name == klass.name} || []
      delegate[1] # delegates should be an array of an object, because this is stinky
      # probably the thing in the registrar should come out
    end

    def responds_to?(method_name)
      registrar.keys.include?(method_name)
    end

    def build_delegate(klass)
      delegates[klass.name] = klass.new(asserter)
    end
  end
end
