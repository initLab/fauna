require 'rails_helper'

describe Api::Door::ActionsController, type: :controller do
  before { skip("Awaiting implementation of PIN requirement") }

  describe 'POST #create' do
    describe 'authentication' do
      it 'redirects to the login page when the current user is not authenticated' do
        post :create, {door_action: {name: 'foo'}}
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'returns HTTP 403 Forbidden when the current user is not authorized' do
        sign_in create :user
        action = double Door::Actions::Action
        allow(action).to receive(:creatable_by?).and_return(false)
        allow(Door::Actions::Action).to receive(:from_name).and_return action

        post :create, {door_action: {name: 'foo'}}
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'when performed by an authorized user' do
      let(:action) { action = instance_double Door::Actions::Action }
      let(:user) { create :trusted_member }
      before do
        sign_in user
      end

      before :each do
        allow(action).to receive(:creatable_by?).and_return true
        allow(action).to receive(:initiator=)
        allow(action).to receive(:origin_information=)
        allow(action).to receive(:save)
        allow(Door::Actions::Action).to receive(:from_name).and_return(action)
      end

      it 'creates an Action instance from the door_action[name] parameter' do
        post :create, {door_action: {name: 'foo'}}
        expect(Door::Actions::Action).to have_received(:from_name).with 'foo'
      end

      describe 'when the status name is not valid' do
        before do
          allow(Door::Actions::Action).to receive(:from_name).with('foo').and_return(nil)
        end

        it 'returns HTTP 422 Unprocessable Entity' do
          post :create, {door_action: {name: 'foo'}}
          expect(response).to have_http_status(:unprocessable_entity)
        end

      end

      describe 'when the status name is valid' do
        it 'saves the action' do
          post :create, {door_action: {name: 'foo'}}
          expect(action).to have_received :save
        end

        describe 'when the status cannot be saved' do
          before do
            allow(action).to receive(:save).and_return(false)
          end

          it 'returns HTTP 422 Unprocessable Entity' do
            post :create, {door_action: {name: 'foo'}}
            expect(response).to have_http_status(:unprocessable_entity)
          end

          it 'sets sets an initiator and origin information for the action' do
            post :create, {door_action: {name: 'foo'}}
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
            post :create, {door_action: {name: 'foo'}}
          end

          it 'returns HTTP 422 Unprocessiable entiry' do
            post :create, {door_action: {name: 'foo'}}
            expect(response).to have_http_status(:no_content)
          end
        end
      end
    end
  end
end
