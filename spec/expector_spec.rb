class ExpectorantExpectorTest < Minitest::Test
  def setup
    @expector = Expectorant::Expector.new(self)
  end

  def expect_test_to_fail(&block)
    assert_raises Minitest::Assertion, &block
  end

  # basic equality ---------

  def test_equality_pass
    @expector.expect(true).to.equal(true)
    @expector.expect(true).should.equal(true)
  end

  def test_equality_with_operator
    @expector.expect(true).to == true
    @expector.expect(true) == true
  end

  def test_equality_fail
    expect_test_to_fail do
      @expector.expect(true).to.equal(false)
    end
  end

  def test_equality_negation_pass
    @expector.expect(true).to.not.equal(false)
    @expector.expect(true).should_not.equal(false)
  end

  def test_equality_negation_pass_different_order
    @expector.expect(true).not.to.equal(false)
  end

  def test_equality_negation_fail
    expect_test_to_fail do
      @expector.expect(true).not.to.equal(true)
    end
  end

  # other minitest matchers --------------
  def test_existence
    @expector.expect(true).to.exist
    @expector.expect(nil).to_not.exist
  end

  def test_empty
    @expector.expect({}).is.empty
    @expector.expect([]).to.be.empty
    @expector.expect([1]).should_not.be.empty
    @expector.expect([1]).not.empty
  end

  def test_proximity
    @expector.expect(3.2).to.be.within(0.1).of(3.25)
    @expector.expect(3.2).within(0.1).of(3.25)
    @expector.expect(3.2).close_to(3.200001)
  end

  def test_inclusion
    @expector.expect([23]).to.include(23)
    @expector.expect([]).should_not.include(23)
    @expector.expect('foo-bar').should.include('foo')
    @expector.expect('foo-bar').to.contain('foo')
  end

  def test_type
    @expector.expect([]).is.instance_of(Array)
    @expector.expect('string').is.not.a(Hash)
    @expector.expect([]).is.an(Array)
  end

  def test_regex_matching
    @expector.expect('Hello world!').not.to.match(/hello/)
    @expector.expect('Hello world!').matches(/hello/i)
  end

  def test_comparisons
    @expector.expect(23).is.greater_than(22)
    @expector.expect(21).is.not.greater_than(22)
    @expector.expect(22) >= 22
    @expector.expect(0).not <= -2
  end

  # ---------------
  # Handling expectation blocks

  def test_actual_value_is_a_block
    @expector.expect{ 2 * 2 } == 4
  end

  def test_expection_is_a_block
    @expector.expect{ 2 * 2 }.equals{ 2 + 2 }
    @expector.expect(4.06).within(0.1).of{ 2 * 2 }
    @expector.expect(4.00001).to.be.close_to{ 2 * 2 }
    @expector.expect([42]).not.to.include{ 2 * 2 }
    @expector.expect(0).greater_than{ 0 - 2 }
  end

  def test_expecting_change
    foo = 1

    @expector.expect{ foo += 1 }.to.change(foo)

    expect_test_to_fail do
      @expector.expect{ foo }.to.change{ foo }
    end
  end

  def x_test_expecting_change_by_amount
    foo = 1

    @expector.expect{ foo += 1 }.to.change{ foo }.by(1)

    expect_test_to_fail do
      @expector.expect{ foo += 1 }.to.change{ foo }.by(7)
    end
  end
end
