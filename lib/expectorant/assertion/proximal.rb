module Expectorant
  module Assertion
    class Proximal < SimpleDelegator
      def asserter
        __getobj__
      end

      def close_to(expected=Resolver::NullArgument, &block)
        resolved = resolve(expected, block)
        asserter.message = "Expected #{resolved} and #{actual} #{not_description}to be within #{delta} of each other"
        assert('in_delta', resolve(expected, block), actual, delta)
      end

      alias :of :close_to

      def within(d)
        @delta = d
        self
      end

      def delta
        @delta || 0.001
      end

      def resolve(object, block)
        Resolver.new(object, block).value
      end
    end
  end
end
