module Expectorant
  class Asserter
    class Matcher < SimpleDelegator
      def match(expression)
        assert('match', expression, actual)
      end

      alias :matches :match
    end
  end
end
