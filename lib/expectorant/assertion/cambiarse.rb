module Expectorant
  module Assertion
    class Cambiarse < SimpleDelegator
      attr_reader :original_value

      def change(expected=Resolver::NullArgument, &block)
        negate
        @original_value = resolve(expected, block)
        assert('equal', original_value, actual)
        self
      end

      def by(expected=Resolver::NullArgument, &block)
        negate # assuming that the change was tested first
        assert('equal', actual - original_value, resolve(expected, block))
      end
    end
  end
end
