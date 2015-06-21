require 'rails_helper'

RSpec.describe Door::Actions::Unlock, type: :model do
  let(:backend) { Rails.application.config.door_status_manager_backend }

  it_behaves_like 'door action'

  describe '#backend_method' do
    it 'returns :unlock!' do
      expect(subject.backend_method).to eq :unlock!
    end
  end
end
