module Expectorant
  class Asserter
    attr_reader :test_context, :negated
    attr_accessor :actual

    def initialize(test_context)
      @test_context = test_context
      reset
    end

    def reset
      @negated = false
      @actual = nil
    end

    def negate
      @negated = !negated
    end

    def assert(postfix, *args)
      test_context.send(assertion_method(postfix), *args)
    end

    def assert_comparison(operator, other)
      assert('operator', actual, operator, other)
    end

    def assertion_method(postfix)
      "#{prefix}_#{postfix}"
    end

    def prefix
      negated ? 'refute' : 'assert'
    end
  end
end
