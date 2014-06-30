module Expectorant
  class Expector
    attr_reader :test_context, :expected, :negated, :maper

    def initialize(test_context)
      @test_context = test_context
    end

    def reset
      @actual = nil
      @negated = nil
    end

    def expect(actual=nil, &block)
      reset
      @actual = actual || block
      self
    end

    def to
      self
    end

    alias :should :to
    alias :be :to
    alias :is :to

    def not
      @negated = true
      self
    end

    alias :should_not :not
    alias :not_to :not
    alias :to_not :not

    def equal(expected=nil, &block)
      assert(assertion_method('equal'), resolve(expected || block), actual)
    end

    alias :== :equal
    alias :equals :equal

    def exist
      method = "#{inverse_prefix}_nil"
      assert(method, actual)
    end

    def empty
      assert(assertion_method('empty'), actual)
    end

    def within(delta)
      p = Proximal.new(self)
      p.delta = delta
      p
    end

    alias :be_within :within

    def close_to(expected=nil, &block)
      p = Proximal.new(self)
      p.assert_close(expected || block)
    end

    def include(expected=nil, &block)
      assert(assertion_method('includes'), actual, resolve(expected || block))
    end

    alias :contain :include

    def instance_of(klass)
      assert(assertion_method('instance_of'), klass, actual)
    end

    alias :an :instance_of
    alias :a :instance_of

    def match(expression)
      assert(assertion_method('match'), expression, actual)
    end

    alias :matches :match

    def greater_than(other=nil, &block)
      assert_comparison(:>, other, block)
    end

    def greater_than_or_equal(other=nil, &block)
      assert_comparison(:>=, other, block)
    end

    def less_than(other=nil, &block)
      assert_comparison(:<, other, block)
    end

    def less_than_or_equal(other=nil, &block)
      assert_comparison(:<=, other, block)
    end

    alias :>  :greater_than
    alias :>= :greater_than_or_equal
    alias :<  :less_than
    alias :<= :less_than_or_equal

    def change(expected=nil, &block)

    end

    # -----------------------
    # private methods, but then SimpleDelegator can't find them

    def actual
      resolve(@actual)
    end

    def resolve(object)
      object.respond_to?(:call) ? object.call : object
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

    def inverse_prefix
      negated ? 'assert' : 'refute'
    end
  end
end
