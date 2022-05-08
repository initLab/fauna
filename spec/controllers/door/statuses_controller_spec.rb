require 'rails_helper'

describe Door::StatusesController, type: :controller do
  describe 'GET #show' do
    describe 'authentication' do
      it 'redirects to the login page when the current user is not signed in' do
        get :show
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'when performed by an authenticated in user' do
      before do
        sign_in create :user
      end

      it 'returns HTTP Success' do
        get :show
        expect(response.status).to eq 200
      end
    end
  end

  describe 'PATCH #update' do
    before do
      request.env["HTTP_REFERER"] = 'back'
    end

    describe 'authentication' do
      it 'redirects to the login page when the current user is not authenticated' do
        patch :update, params: {status: {name: 'foo'}}
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'redirects to the referer with an error message when the current user is not authorized' do
        sign_in create :user
        allow(Door::Actions::Action).to receive(:from_name).and_return(double(Door::Actions::Action))

        patch :update, params: {status: {name: 'foo'}}
        expect(response).to redirect_to('back')
        expect(flash[:error]).to be_present
      end
    end

    describe 'when performed by an authorized user' do
      let(:action) { instance_double Door::Actions::Action }
      let(:user) { create :trusted_member }
      before do
        sign_in user
      end

      before :each do
        allow(action).to receive(:initiator=)
        allow(action).to receive(:origin_information=)
        allow(action).to receive(:save)
        allow(Door::Actions::Action).to receive(:from_name).and_return(action)
      end

      it 'creates an Action instance from the status[name] parameter' do
        patch :update, params: {status: {name: 'foo'}}
        expect(Door::Actions::Action).to have_received(:from_name).with 'foo'
      end

      it 'redirects to the referer' do
        patch :update, params: {status: {name: 'foo'}}
        expect(response).to redirect_to 'back'
      end

      describe 'when the status name is not valid' do
        before do
          allow(Door::Actions::Action).to receive(:from_name).with('foo').and_return(nil)
        end

        it 'sets an error flash' do
          patch :update, params: {status: {name: 'foo'}}
          expect(flash[:error]).to be_present
        end

      end

      describe 'when the status name is valid' do
        it 'saves the action' do
          patch :update, params: {status: {name: 'foo'}}
          expect(action).to have_received :save
        end

        describe 'when the status cannot be saved' do
          before do
            allow(action).to receive(:save).and_return(false)
          end

          it 'sets an error flash' do
            patch :update, params: {status: {name: 'foo'}}
            expect(flash[:error]).to be_present
          end

          it 'sets sets an initiator and origin information for the action' do
            patch :update, params: {status: {name: 'foo'}}
            expect(action).to have_received(:initiator=).with(user)
            expect(action).to have_received(:origin_information=).with(/#{request.remote_ip}/)
          end

        end

        describe 'when the status can be saved' do
          before do
            allow(action).to receive(:save).and_return(true)
          end

          it 'sets a notice flash' do
            patch :update, params: {status: {name: 'foo'}}
            expect(flash[:notice]).to be_present
          end

          it 'clears the door_current_status cache entry' do
            expect(Rails.cache).to receive(:delete).with('door_current_status')
            patch :update, params: {status: {name: 'foo'}}
          end
        end
      end
    end
  end
end
