require 'rails_helper'

describe Api::Door::ActionsController, type: :controller do
  describe 'POST #create' do
    let(:user) { create :user }
    let(:token) { create :access_token, resource_owner_id: user.id, scopes: [:door_latch_control, :door_handle_control] }
    describe 'authentication' do
      it 'returns a HTTP 401 Unauthorized response code when the user provides an invalid token' do
        post :create, params: {door_action: {name: 'foo'}, access_token: 'foo'}
        expect(response.code).to eq '401'
      end

      it 'returns a HTTP 401 Unauthorized response code when the user does not provide a token' do
        post :create, params: {door_action: {name: 'foo'}}
        expect(response.code).to eq '401'
      end

      it "returns a HTTP 403 Forbidden response code when the user's token does not have the correct scopes" do
        token = create :access_token, resource_owner_id: user.id, scopes: [:public, :door_handle_control]
        post :create, params: {door_action: {name: 'foo'}, access_token: token.token}
        expect(response.code).to eq '403'
      end

      it 'returns HTTP 403 Forbidden when the current user is not authorized' do
        action = double Door::Actions::Action
        allow(action).to receive(:creatable_by?).and_return(false)
        allow(Door::Actions::Action).to receive(:from_name).and_return action

        post :create, params: {door_action: {name: 'foo'}, access_token: token.token}
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'when performed by an authorized user' do
      let(:action) { instance_double Door::Actions::Action }
      let(:user) { create :trusted_member }

      before :each do
        allow(action).to receive(:creatable_by?).and_return true
        allow(action).to receive(:initiator=)
        allow(action).to receive(:origin_information=)
        allow(action).to receive(:save)
        allow(Door::Actions::Action).to receive(:from_name).and_return(action)
      end

      it 'creates an Action instance from the door_action[name] parameter' do
        post :create, params: {door_action: {name: 'foo'}, access_token: token.token}
        expect(Door::Actions::Action).to have_received(:from_name).with 'foo'
      end

      describe 'when the status name is not valid' do
        before do
          allow(Door::Actions::Action).to receive(:from_name).with('foo').and_return(nil)
        end

        it 'returns HTTP 422 Unprocessable Entity' do
          post :create, params: {door_action: {name: 'foo'}, access_token: token.token}
          expect(response).to have_http_status(:unprocessable_entity)
        end

      end

      describe 'when the status name is valid' do
        it 'saves the action' do
          post :create, params: {door_action: {name: 'foo'}, access_token: token.token}
          expect(action).to have_received :save
        end

        describe 'when the status cannot be saved' do
          before do
            allow(action).to receive(:save).and_return(false)
          end

          it 'returns HTTP 422 Unprocessable Entity' do
            post :create, params: {door_action: {name: 'foo'}, access_token: token.token}
            expect(response).to have_http_status(:unprocessable_entity)
          end

          it 'sets sets an initiator and origin information for the action' do
            post :create, params: {door_action: {name: 'foo'}, access_token: token.token}
            expect(action).to have_received(:initiator=).with(user)
            expect(action).to have_received(:origin_information=).with(/#{request.remote_ip}/)
          end

        end

        describe 'when the status can be saved' do
          before do
            allow(action).to receive(:save).and_return(true)
          end

          it 'clears the door_current_status cache entry' do
            expect(Rails.cache).to receive(:delete).with('door_current_status')
            post :create, params: {door_action: {name: 'foo'}, access_token: token.token}
          end

          it 'returns HTTP 422 Unprocessiable entiry' do
            post :create, params: {door_action: {name: 'foo'}, access_token: token.token}
            expect(response).to have_http_status(:no_content)
          end
        end
      end
    end
  end
end
