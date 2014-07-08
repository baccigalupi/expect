module Expectorant
  class Asserter
    class Existential < SimpleDelegator
      def asserter
        __getobj__
      end

      def exist
        asserter.message = "Expected #{actual.inspect} #{not_description}to exist"
        negate # toggles so that the nil check turns to an exist
        assert('nil', actual)
      end

      alias :exists :exist
    end
  end
end
