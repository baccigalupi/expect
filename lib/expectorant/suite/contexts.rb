module Expectorant
  class Suite
    class Contexts
      attr_reader :collection
      attr_accessor :current

      def initialize(suite_class)
        @collection = [Context.new(suite_class, suite_class.name)]
        @current = collection.first
      end

      def add(context)
        self.current = context
        collection << context
        context.run_block
        context
      end

      def run(type, identifier)
        index = collection.find_index{|context| context.has_spec?(identifier) }
        collection[0..index].each{|context| context.send("run_#{type}s")}
      end
    end
  end
end
