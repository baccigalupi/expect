# global state to test before/after calls
module TestValues
  class << self
    attr_accessor :first_level, :second_level, :third_level
    attr_writer :reset_count, :call_stack

    def reset_count
      @reset_count ||= 0
    end

    def call_stack
      @call_stack ||= []
    end

    def reset
      self.first_level = nil
      self.second_level = nil
      self.third_level = nil
      self.call_stack = []
      self.reset_count += 1
    end
  end
end

class ExpectorantSuiteContextsTest < Expectorant::Suite
  before do
    TestValues.first_level = 1
    TestValues.call_stack << 'before first'
  end

  after do
    TestValues.reset
  end

  it "will run .before before the test if one is defined" do
    expect(TestValues.first_level).to.equal(1)
  end

  it "will not run other context befores" do
    expect(TestValues.second_level).not.to.exist
    expect(TestValues.third_level).not.to.exist
  end

  context 'second level context' do
    before do
      TestValues.second_level = 1
      TestValues.call_stack << 'before second'
    end

    it "will run these (error raised if spec count is wrong)" do
      expect(true).to.equal(true)
    end

    it "runs the before block for this context" do
      expect(TestValues.second_level).to.equal(1)
    end

    it "runs the top level before block" do
      expect(TestValues.first_level).to.equal(1)
    end

    it "runs the before blocks in the right order" do
      expect(TestValues.call_stack).to.equal(['before first', 'before second'])
    end

    describe "third level context, aliased to describe" do
      before do
        TestValues.third_level = 1
        TestValues.call_stack << 'before third'
      end

      it "runs the before blocks in the right order" do
        expect(TestValues.third_level).to.equal(1)
        expect(TestValues.call_stack).to.equal(['before first', 'before second', 'before third'])
      end

      specify "runs as an alias" do
        expect(true).to.equal(true)
      end
    end
  end

  x_context "this won't get run" do
    it "should not get here" do
      expect(true).to.equal(false)
    end
  end

  xit "this will be pending" do
    expect(true).to.equal(false)
  end

  # testing general class state

  def self.raise_if_number_of_specs_wrong(expected) # if context blocks not evaluated
    number_of_specs = public_instance_methods.grep(/^test_/).size
    raise "Expected #{expected} specs, but got #{number_of_specs}" unless number_of_specs == expected
  end

  def self.raise_if_after_not_called(expected)
    raise "Expected .after to have been called #{expected} times" unless TestValues.first_level == nil
  end
end

NUMBER_OF_SPECS = 9 + 1 # 1 for the x_context which creates a pending
ExpectorantSuiteContextsTest.raise_if_number_of_specs_wrong(NUMBER_OF_SPECS)
ExpectorantSuiteContextsTest.raise_if_after_not_called(NUMBER_OF_SPECS)
