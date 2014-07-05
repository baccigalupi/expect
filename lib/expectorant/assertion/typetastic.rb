module Expectorant
  module Assertion
    class Typetastic < SimpleDelegator
      def instance_of(klass)
        assert('instance_of', klass, actual)
      end

      alias :an :instance_of
      alias :a :instance_of
    end
  end
end
