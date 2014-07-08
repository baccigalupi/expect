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

      # NOTE: block will only keep arguments passed in, not local variables
      # or accessors
      #
      # this doesn't work
      # def wrapped_block
      #   identifier
      #   block
      #
      #   -> do
      #     self.class.contexts.first.run_befores(identifier)
      #     instance_eval &block
      #   end
      # end
      #
      # So, passing the state as arguments
      # Could set local variables to needed state??

      def wrapped_block(identifier, block)
        -> do
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
