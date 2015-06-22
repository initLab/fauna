require 'rails_helper'

RSpec.describe Door::Actions::Lock, type: :model do
  let(:backend) { Rails.application.config.door_status_manager.backend }

  it_behaves_like 'door action'

  describe '#backend_method' do
    it 'returns :lock!' do
      expect(subject.backend_method).to eq :lock!
    end
  end
end
