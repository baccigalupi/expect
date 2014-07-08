module Expectorant
  class Asserter
    class Comparitor < SimpleDelegator
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

      def assert_comparison(operator, other)
        assert('operator', actual, operator, other)
      end
    end
  end
end
