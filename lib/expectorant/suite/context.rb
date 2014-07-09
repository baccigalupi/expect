module Expectorant
  class Suite
    class Context < Struct.new(:suite_class, :description, :block)
      def callbacks
        @callbacks ||= []
      end

      class Callback < Struct.new(:type, :block)
      end

      def add_hook(type, block)
        callbacks << Callback.new(type, block)
      end

      def run(type)
        relevant = callbacks.find_all{|callback| callback.type == type}
        relevant.each{|callback| callback.block.call }
      end

      def specs
        @specs ||= []
      end

      def run_block
        suite_class.instance_eval &block
      end

      def it(description='anonymous', block)
        specs << spec = Spec.new(description, block)
        suite_class.define_spec(spec)
      end

      def has_spec?(identifier)
        specs.any?{|spec| spec.identifier == identifier }
      end
    end
  end
end
