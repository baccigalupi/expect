module Expectorant
  class Asserter
    class Equalizer < SimpleDelegator
      def equal(expected=Resolver::NullArgument, &block)
        assert('equal', resolve(expected, block), actual)
      end

      alias :== :equal
      alias :equals :equal
    end
  end
end
