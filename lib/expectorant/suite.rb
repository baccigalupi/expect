module Expectorant
  class Suite < Minitest::Test
    include Expectorant::Mixin::Expect

    def self.contexts
      @contexts ||= Contexts.new(self)
    end

    def self.context(description='anonymous', &block)
      contexts.add( Context.new(self, description, block) )
    end

    def self.it(description='', &block)
      contexts.current.it(description, block)
    end

    def self.before(&block)
      contexts.current.befores << block
    end

    def self.after(&block)
      contexts.current.afters << block
    end

    def self.define_spec(spec)
      define_method(spec.identifier, &spec.proc)
    end
  end
end
