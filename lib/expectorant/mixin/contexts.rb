module Expectorant
  module Mixin
    module Contexts
      def contexts
        @contexts ||= ::Expectorant::Suite::Contexts.new(self)
      end

      def context(description='anonymous', &block)
        contexts.add( ::Expectorant::Suite::Context.new(self, description, block) )
      end

      alias :describe :context

      def x_context(description='anonymous', &block)
        warn "Context '#{description}' is temporarily x'd out"
      end

      alias :x_describe :x_context
      alias :xdescribe :x_context
      alias :xcontext :x_context

      def it(description='anonymous', &block)
        contexts.current.it(description, block)
      end

      alias :specify :it

      def xit(description='anonymous', &block)
        contexts.current.it(description, nil)
      end

      def before(&block)
        contexts.current.befores << block
      end

      def after(&block)
        contexts.current.afters << block
      end

      def define_spec(spec)
        define_method(spec.identifier, &spec.proc)
      end
    end
  end
end
