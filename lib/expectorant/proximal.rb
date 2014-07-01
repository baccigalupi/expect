module Expectorant
  class Proximal < SimpleDelegator
    attr_writer :delta

    def assert_close(expected=Resolver::NullArgument, &block)
      assert('in_delta', resolve(expected, block), actual, delta)
    end

    alias :of :assert_close

    def delta
      @delta || 0.001
    end

    def resolve(object, block)
      Resolver.new(object, block).value
    end
  end
end
