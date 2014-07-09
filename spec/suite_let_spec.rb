class ExpectorantSuiteLetTest < Expectorant::Suite
  let(:thing) { 'thing' }

  xit "makes the method available in tests" do
    expect(thing).to == 'thing'
  end
end
