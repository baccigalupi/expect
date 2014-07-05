module Expectorant
  module Assertion
    class Existential < SimpleDelegator
      def exist
        negate # toggles so that the nil check turns to an exist
        assert('nil', actual)
      end

      alias :exists :exist
    end
  end
end
