module Expectorant
  class Asserter
    class Cambiarse < SimpleDelegator
      attr_reader :original_value

      def asserter
        __getobj__
      end

      def change(expected=Resolver::NullArgument, &block)
        asserter.message = "Expected #{pp_object(original_value)} #{not_description}to change"
        negate
        @original_value = resolve(expected, block)
        assert('equal', original_value, actual)
        self
      end

      def by(expected=Resolver::NullArgument, &block)
        resolved = resolve(expected, block)
        negate # assuming that the change was tested first
        asserter.message = "Expected #{pp_object(original_value)} #{not_description}to change by #{pp_object(resolved)}, but changed by #{actual - original_value}"
        assert('equal', resolved, actual - original_value)
      end

      def pp_object(obj)
        test_context.mu_pp(obj)
      end
    end
  end
end
