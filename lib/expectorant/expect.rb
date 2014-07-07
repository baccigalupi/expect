module Expectorant
  module Expect
    extend Forwardable

    def _expector
      @_expector ||= Expectorant::Expector.new(self)
    end

    def_delegators :_expector, :expect
  end
end
