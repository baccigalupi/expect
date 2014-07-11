module Expectorant
  class Suite
    class Context < Struct.new(:suite_class, :description, :block)
      def callbacks
        @callbacks ||= []
      end

      def lets
        @lets ||= []
      end

      def add_hook(type, block)
        callbacks << Callback.new(type, block)
      end

      def add_let(name, block)
        add_let_callbacks
        lets << Callback.new(name, block)
      end

      def add_let_callbacks
        return unless callbacks_by(:let).empty?
        callbacks << Callback.new(:let, Letter.new(suite_class, lets).block)
      end

      def run(type)
        callbacks_by(type).each{|callback| callback.block.call }
      end

      def callbacks_by(type)
        callbacks.find_all{|callback| callback.type == type}
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

      class Callback < Struct.new(:type, :block)
      end

      class Letter < Struct.new(:suite_class, :lets)
        def block
          callbacks = lets
          -> {
            callbacks.each do |callback|
              suite_class.define_let(callback.type, callback.block)
            end
          }
        end
      end
    end
  end
end
