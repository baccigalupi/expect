module Expectorant
  module Assertion
    class Matcher < SimpleDelegator
      def match(expression)
        assert('match', expression, actual)
      end

      alias :matches :match
    end
  end
end
