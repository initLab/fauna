require 'rails_helper'

RSpec.describe Door::Actions::Open, type: :model do
  let(:backend) { Rails.application.config.door_status_manager.backend }

  it_behaves_like 'door action' do
    subject {Door::Actions::Open.new(initiator: create(:board_member))}
  end

  describe '#backend_method' do
    it 'returns :open!' do
      expect(subject.backend_method).to eq :open!
    end
  end
end
