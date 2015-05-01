require 'rails_helper'

module Door
  describe LogEntriesController, type: :controller do
    describe 'POST #create' do
      let(:log_entry) { build :door_log_entry }

      it 'creates a new door log entry' do
        expect { post :create, door: log_entry.door, latch: log_entry.latch }.to change(Door::LogEntry, :count).by(1)
      end

      it 'returns HTTP 201 Created upon success' do
        post :create, door: log_entry.door, latch: log_entry.latch
        expect(response).to be_created
      end

      it 'returns HTTP 422 Unprocessable Entity when passed invalid params' do
        post :create, door: 'foo', latch: 'bar'
        expect(response).to be_unprocessable
      end
    end
  end
end
