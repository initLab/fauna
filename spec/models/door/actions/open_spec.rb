require 'rails_helper'

RSpec.describe Door::Actions::Open, type: :model do
  let(:backend) { Rails.application.config.door_status_manager_backend }

  it_behaves_like 'door action'

  it 'calls the open! method of the status manager after saving' do
    expect(backend).to receive(:open!)
    create :door_actions_open
  end
end
