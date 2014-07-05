module Expectorant
  module Assertion
    class Collector < SimpleDelegator
      def empty
        assert('empty', actual)
      end

      def include(expected=Resolver::NullArgument, &block)
        assert('includes', actual, resolve(expected, block))
      end

      alias :contain :include
    end
  end
end
