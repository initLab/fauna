require 'rails_helper'

RSpec.describe Door::Actions::Lock, type: :model do
  let(:backend) { Rails.application.config.door_status_manager.backend }

  it_behaves_like 'door action' do
    subject { Door::Actions::Lock.new(initiator: create(:board_member)) }
  end

  describe 'authorization' do
    it 'is creatable by trusted members' do
      expect(subject).to be_creatable_by create(:trusted_member)
    end

    it 'is creatable by board members' do
      expect(subject).to be_creatable_by create(:board_member)
    end

    it 'is not creatable by plain users' do
      expect(subject).to_not be_creatable_by create(:user)
    end
  end

  describe '#backend_method' do
    it 'returns :lock!' do
      expect(subject.backend_method).to eq :lock!
    end
  end
end
