require 'rails_helper'

module Door
  describe StatusNotificationsController, type: :controller do
    describe 'POST #create' do
      let(:status_notification) { build :door_status_notification }
      let(:token) { 'foobar' }

      before do
        Rails.application.secrets['door_notification_token'] = token
      end

      context 'when sent with a correct token' do
        it 'creates a new door log entry' do
          expect { post :create, params: {door: status_notification.door, latch: status_notification.latch, token: token} }.to change(Door::StatusNotification, :count).by(1)
        end

        it 'returns HTTP 201 Created upon success' do
          post :create, params: {door: status_notification.door, latch: status_notification.latch, token: token}
          expect(response).to be_created
        end

        it 'returns HTTP 422 Unprocessable Entity when passed invalid params' do
          post :create, params: {door: 'foo', latch: 'bar', token: token}
          expect(response).to be_unprocessable
        end
      end

      context 'when sent with an incorrect token' do
        let(:token) { 'foobar123' }

        it 'return HTTP 401 Unauthorized' do
          post :create, params: {door: 'foo', latch: 'bar', token: token}
          post :create, params: {door: 'foo', latch: 'bar'}

          expect(response).to be_unauthorized
        end
      end
    end
  end
end
