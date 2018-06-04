require "../lib/main.rb"
describe Cb do
  let(:subject) { Cb.new }
  context 'When testing the #generator method'
  it 'returns an array size of 4' do
    ary_size = subject.generator.size
    expect(ary_size).to eq 4
  end

  it 'returns array of integers' do
    aray = subject.generator
    integers_array = aray.select { |x| x.is_a? Integer }
    expect(aray).to eq integers_array
  end
  context 'When testing the #compare method'
  it "returns all '+' when codes match" do
    expect(subject.compare([1, 2, 3, 4], [1, 2, 3, 4])).to eq ['+', '+', '+', '+']
  end

  it "returns all ' ' when codes does not match" do
    expect(subject.compare([1, 2, 3, 4], [5, 5, 5, 5])).to eq [' ', ' ', ' ', ' ']
  end

  it "returns all '-' when codes numbers are not in place" do
    expect(subject.compare([1, 2, 3, 4], [4, 3, 2, 1])).to eq ['-', '-', '-', '-']
  end

  it 'will check rest of numbers if match was found' do
    expect(subject.compare([1, 2, 3, 4], [1, 3, 5, 1])).to eq ['+', '-', ' ', '-']
  end
  context 'when testing #gues method'
  it 'returns array of integers' do
    allow(subject).to receive(:gets) {'1234'}
    expect(subject.guess).to eq [1, 2, 3, 4]
  end

  context 'When testing #attempt_used method'
  it 'decreases attempts by 1 when used' do
    allow(subject).to receive(:@attempts) { 5 }
    expect(subject.attempt_used).to eq 4
  end

  context 'when testing #lost? method'

  it 'returns number of attempts left when not lost' do
    allow(subject).to receive(:@attempts) { 5 }
    expect { subject.lost? }.to output("Number of attempts left: 5\n").to_stdout
  end

  it 'calls #lost methot when attempts are 0' do
    subject.instance_variable_set(:@attempts, 0)
    expect(subject).to receive(:lost)
    subject.lost?
  end

  context 'when testing #win? method'
  it 'tests if #win method called on full match' do
    expect(subject).to receive(:win)
    subject.win?(['+', '+', '+', '+'])
  end

  it 'tests that #win method is not called on non-full match' do
    expect(subject).not_to receive(:win)
    subject.win?(['+', '+', '-', ' '])
  end

  context 'when testing #hint? method'
  it 'checks that #hint method is called if user have hints' do
    subject.instance_variable_set(:@hint_available, true)
    expect(subject).to receive(:hint)
    subject.hint?
  end

  it "checks that #hint method is not called if user don't have hints" do
    subject.instance_variable_set(:@hint_available, false)
    expect(subject).not_to receive(:hint)
    subject.hint?
  end

  context "when testing #hint method"
  it 'check that hint outputs correct value' do
    expect { subject.hint([1, 2, 3, 4], ["+", "+", "+", "-"]) }.to output(/Number 4 is on position 4/).to_stdout
  end

#    context "when testing #new_game method"
#
#    it "checks that #hint? method is called" do
#      subject.instance_variable_set(:@hint_available, true)
#      allow(subject).to receive(:gets) {"2"}
#      expect(subject).to receive(:hint?).at_least(10).times
#     subject.new_game
#    end

  context 'When testing #win class'
  it 'test reset game' do
    allow(subject).to receive(:gets) {'1'}
    expect(subject).to receive(:new_game).once
    subject.win
  end

  context 'When testing #lost class'
  it do
    allow(subject).to receive(:gets) {'1'}
    expect(subject).to receive(:new_game).once
    subject.win
  end
end
