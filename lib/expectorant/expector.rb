module Expectorant
  class Expector
    attr_reader :test_context, :expected, :asserter

    def initialize(test_context)
      @test_context = test_context
      @asserter = Asserter.new(test_context)
    end

    extend Forwardable
    def_delegators :@asserter, :actual, :reset, :negated, :assert, :assert_comparison

    def expect(actual=Resolver::NullArgument, &block)
      reset
      asserter.actual = resolve(actual, block)
      self
    end

    def equal(expected=Resolver::NullArgument, &block)
      assert('equal', resolve(expected, block), actual)
    end

    alias :== :equal
    alias :equals :equal

    def exist
      asserter.negate # toggles so that the nil check turns to an exist
      assert('nil', actual)
    end

    def empty
      assert('empty', actual)
    end

    def within(delta)
      p = Proximal.new(asserter)
      p.delta = delta
      p
    end

    alias :be_within :within

    def close_to(expected=Resolver::NullArgument, &block)
      p = Proximal.new(asserter)
      p.assert_close(resolve(expected, block))
    end

    def include(expected=Resolver::NullArgument, &block)
      assert('includes', actual, resolve(expected, block))
    end

    alias :contain :include

    def instance_of(klass)
      assert('instance_of', klass, actual)
    end

    alias :an :instance_of
    alias :a :instance_of

    def match(expression)
      assert('match', expression, actual)
    end

    alias :matches :match

    def greater_than(other=Resolver::NullArgument, &block)
      assert_comparison(:>, resolve(other, block))
    end

    def greater_than_or_equal(other=Resolver::NullArgument, &block)
      assert_comparison(:>=, resolve(other, block))
    end

    def less_than(other=Resolver::NullArgument, &block)
      assert_comparison(:<, resolve(other, block))
    end

    def less_than_or_equal(other=Resolver::NullArgument, &block)
      assert_comparison(:<=, resolve(other, block))
    end

    alias :>  :greater_than
    alias :>= :greater_than_or_equal
    alias :<  :less_than
    alias :<= :less_than_or_equal

    def change(expected=nil, &block)

    end

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

    private

    def resolve(object, block)
      Resolver.new(object, block).value
    end
  end
end
