module Expectorant
  class Expector
    attr_reader :test_context, :expected, :asserter

    def initialize(test_context)
      @test_context = test_context
      @asserter = Asserter.new(test_context)
    end

    extend Forwardable
    def_delegators :asserter, :actual, :assert, :assert_comparison

    # ------ setup
    def expect(a=Resolver::NullArgument, &block)
      asserter.reset
      asserter.actuals(a, block)
      self
    end

    # --------- assertions
    def equalizer
      @equalizer ||= Assertion::Equalizer.new(asserter)
    end

    def_delegators :equalizer, :equal, :equals, :==

    def existential
      @existential ||= Assertion::Existential.new(asserter)
    end

    def_delegators :existential, :exist, :exists

    def collector
      @collector ||= Assertion::Collector.new(asserter)
    end

    def_delegators :collector, :empty, :include, :contain

    def proximal
      @proximal ||= Assertion::Proximal.new(asserter)
    end

    def_delegators :proximal, :within, :close_to

    def typetastic
      @typetastic ||= Assertion::Typetastic.new(asserter)
    end

    def_delegators :typetastic, :instance_of, :an, :a

    def matcher
      @matcher ||= Assertion::Matcher.new(asserter)
    end

    def_delegators :matcher, :match, :matches

    def comparitor
      @comparitor ||= Assertion::Comparitor.new(asserter)
    end

    def_delegators :comparitor,
      :greater_than, :greater_than_or_equal,
      :>, :>=,
      :less_than, :less_than_or_equal,
      :<, :<=

    def cambiarse
      @cambiarse ||= Assertion::Cambiarse.new(asserter)
    end

    def_delegators :cambiarse, :change, :by

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

    private

    def resolve(object, block)
      Resolver.new(object, block).value
    end
  end
end
