module Expectorant
  class Proximal < SimpleDelegator
    attr_writer :delta

    def assert_close(expected=nil, &block)
      assert('in_delta', Expector.resolve(expected || block), actual, delta)
    end

    alias :of :assert_close

    def delta
      @delta || 0.001
    end
  end
end
