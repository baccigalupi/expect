class ExpectorantSuiteLetTest < Expectorant::Suite
  let(:thing) { 'thing' }
  let(:one_time_rand) { rand(1000) }

  it "makes the method available in tests" do
    expect(thing).to == 'thing'
  end

  it "memoizes it" do
    expect(one_time_rand).to.equal(one_time_rand)
  end
end
