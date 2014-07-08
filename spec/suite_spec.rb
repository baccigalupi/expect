class ExpectorantSuiteTest < Expectorant::Suite
  def test_expect_is_included
    expect(true).to.equal(true)
  end

  it "tests via class level .it with a block" do
    expect(true).to.equal(true)
  end

  # it doesn't require a description
  it { expect(true).to.equal(true) }

  it "will be pending without a block"
end
