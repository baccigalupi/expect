module Expectorant
  class AssertMapper
    attr_reader :test_context, :actual, :negated

    def initialize(test_context, actual)
      @test_context = test_context
      @actual = self.class.resolve(actual)
      @negated = false
    end

    def negate
      @negated = !negated
    end

    def assert_comparison(operator, other, block)
      assert(assertion_method('operator'), actual, operator, resolve(other || block))
    end

    def assert(method, *args)
      test_context.send(method, *args)
    end

    def assertion_method(postfix)
      "#{prefix}_#{postfix}"
    end

    def prefix
      negated ? 'refute' : 'assert'
    end

    def self.resolve(object)
      object.respond_to?(:call) ? object.call : object
    end
  end
end
