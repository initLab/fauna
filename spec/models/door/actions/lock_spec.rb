require 'rails_helper'

RSpec.describe Door::Actions::Lock, type: :model do
  let(:backend) { Rails.application.config.door_status_manager.backend }

  it_behaves_like 'door action' do
    subject { Door::Actions::Lock.new(initiator: create(:board_member)) }
  end

  describe '#backend_method' do
    it 'returns :lock!' do
      expect(subject.backend_method).to eq :lock!
    end
  end
end
