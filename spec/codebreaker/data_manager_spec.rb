require "spec_helper.rb"

describe DataManager
  context "when testing #write_result method" do
    let(:player_name) { 'Test_Player_' + rand(1..9999).to_s }
    it 'returns player saved result' do
      attempts = 5
      allow(subject).to receive(:gets).and_return(player_name)
      subject.write_results.with(5)
      data = File.read('./lib/game_data.yml')
      expect(data).to include(player_name)
    end
  end
