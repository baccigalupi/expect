module Expectorant
  module Assertion
    class Cambiarse < SimpleDelegator
      def change(expected=Resolver::NullArgument, &block)
        negate
        assert('equal', resolve(expected, block), actual)
      end
    end
  end
end
