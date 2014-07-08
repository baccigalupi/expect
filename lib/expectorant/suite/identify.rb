module Expectorant
  class Suite
    class Identify < Struct.new(:description)
      attr_writer :n

      def identifier
        "test_#{description.gsub(/\W/, '_')}_#{rand(n)}"
      end

      def n
        @n || 1000
      end
    end
  end
end
