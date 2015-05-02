require 'rails_helper'

module Door
  describe StatusNotificationsController, type: :controller do
    describe 'POST #create' do
      let(:status_notification) { build :door_status_notification }

      context 'when sent from a trusted IP' do
        before do
          @request.env['REMOTE_ADDR'] = Rails.application.config.door_status_manager.host
        end

        it 'creates a new door log entry' do
          expect { post :create, door: status_notification.door, latch: status_notification.latch }.to change(Door::StatusNotification, :count).by(1)
        end

        it 'returns HTTP 201 Created upon success' do
          post :create, door: status_notification.door, latch: status_notification.latch
          expect(response).to be_created
        end

        it 'returns HTTP 422 Unprocessable Entity when passed invalid params' do
          post :create, door: 'foo', latch: 'bar'
          expect(response).to be_unprocessable
        end
      end

      context 'when sent from an untrusted IP' do
        before do
          @request.env['REMOTE_ADDR'] = '127.0.0.2'
        end

        it 'return HTTP 401 Unauthorized' do
          post :create, door: 'foo', latch: 'bar'
          expect(response).to be_unauthorized
        end
      end
    end
  end
end
