module Expectorant
  class Suite
    class Context < Struct.new(:suite_class, :description, :block)
      def blocks
        @blocks ||= []
      end

      class Block < Struct.new(:type, :block)
      end

      def add_hook(type, block)
        blocks << Block.new(type, block)
      end

      def run(type)
        relevant = blocks.find_all{|block| block.type == type}
        relevant.each(&:call)
      end

      def befores
        @befores ||= []
      end

      def afters
        @afters ||= []
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

      def run_befores
        befores.each(&:call)
      end

      def run_afters
        afters.each(&:call)
      end

      def has_spec?(identifier)
        specs.any?{|spec| spec.identifier == identifier }
      end
    end
  end
end
