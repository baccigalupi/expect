module Expectorant
  class Suite
    class Spec
      attr_reader :description, :block, :identifier

      def initialize(description, block)
        @description = description
        @block = block
        @identifier = Identify.new(description).identifier
      end

      def proc
        block ? wrapped_block(identifier, block) : skip(description)
      end

      def wrapped_block(identifier, block)
        -> do
          self.class.contexts.run(:let, identifier)
          self.class.contexts.run(:before, identifier)

          instance_eval &block

          self.class.contexts.run(:after, identifier)
        end
      end

      def skip(description)
        -> { skip "'#{description}' not yet defined"}
      end
    end
  end
end
