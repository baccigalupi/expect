class ExpectorantRegistrarTest < Minitest::Test
  include Expectorant::Expect

  class FooeyMatcher < Struct.new(:asserter)
    def nilish
      asserter.assert('nil', asserter.actual)
    end

    def not_so_nilish
      asserter.negate
      asserter.assert('nil', asserter.actual)
    end

    def exist
      asserter.assert('nil', asserter.actual) # this should be exactly wrong
    end
  end

  def setup
    Expectorant.registrar.clear
    Expectorant.register_defaults
  end

  def registrar
    Expectorant.registrar
  end

  def expect_test_to_fail(&block)
    assert_raises Minitest::Assertion, &block
  end

  def test_registration_with_single_to_make_asserters_accessible
    Expectorant.register :fooey, FooeyMatcher

    expect(registrar.get(:fooey)).to.equal(FooeyMatcher)
  end

  def test_registration_with_many_makes_asserters_accessible
    Expectorant.register :fooey, :barrey, FooeyMatcher

    expect(registrar.get(:barrey)).to.equal(FooeyMatcher)
    expect(registrar.get(:fooey)).to.equal(FooeyMatcher)
  end

  def test_inclusion_in_expector
    Expectorant.register :nilish, :not_so_nilish, FooeyMatcher

    expect(nil).to.be.nilish
    expect(true).to.be.not_so_nilish

    expect_test_to_fail do
      expect(true).to.be.nilish
    end

    expect_test_to_fail do
      expect(nil).to.be.not_so_nilish
    end
  end

  def test_override_of_default_assertions
    Expectorant.register :exist, FooeyMatcher
    expect(nil).to.exist # that's fooey!
  end
end
