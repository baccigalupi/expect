module Expectorant
  class Asserter
    attr_reader :test_context, :negated, :actuals_resolver
    attr_accessor :message

    def initialize(test_context)
      @test_context = test_context
      reset
    end

    def reset
      @negated = false
      @actual = nil
      @actuals_resolver = nil
    end

    def negate
      @negated = !negated
    end

    def actuals(object, block)
      @actuals_resolver ||= Resolver.new(object, block)
    end

    def actual
      @actual ||= actuals_resolver.value
    end

    def assert(postfix, *args)
      args << message if message
      test_context.send(assertion_method(postfix), *args)
      self
    end

    def assertion_method(postfix)
      "#{prefix}_#{postfix}"
    end

    def prefix
      negated ? 'refute' : 'assert'
    end

    def not_description
      negated ? 'not ' : ''
    end

    def resolve(object, block)
      Resolver.new(object, block).value
    end
  end
end
