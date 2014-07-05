module Expectorant
  module Assertion
    class Proximal < SimpleDelegator
      def close_to(expected=Resolver::NullArgument, &block)
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
