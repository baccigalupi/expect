module Expectorant
  class Suite < Minitest::Test
    include Expectorant::Mixin::Expect
    extend  Expectorant::Mixin::Contexts
  end
end
