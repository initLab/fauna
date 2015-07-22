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
        expect(response).to be_success
      end

      it 'assigns the current status' do
        get :show
        expect(assigns(:current_status)).to_not be_nil
      end
    end
  end

  describe 'PATCH #update' do
    before do
      request.env["HTTP_REFERER"] = 'back'
    end

    describe 'authentication' do
      it 'redirects to the login page when the current user is not authenticated' do
        patch :update, {status: {name: 'foo'}}
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'redirects to the referer with an error message when the current user is not authorized' do
        sign_in create :user
        action = double Door::Actions::Action
        allow(action).to receive(:creatable_by?).and_return(false)
        allow(Door::Actions::Action).to receive(:from_name).and_return action

        patch :update, {status: {name: 'foo'}}
        expect(response).to redirect_to('back')
        expect(flash[:error]).to be_present
      end
    end

    describe 'when performed by an authorized user' do
      let(:action) { action = instance_double Door::Actions::Action }

      before do
        sign_in create :trusted_member
      end

      before :each do
        allow(action).to receive(:creatable_by?).and_return true
        allow(action).to receive(:save)
        allow(Door::Actions::Action).to receive(:from_name).and_return(action)
      end

      it 'creates an Action instance from the status[name] parameter' do
        patch :update, {status: {name: 'foo'}}
        expect(Door::Actions::Action).to have_received(:from_name).with 'foo'
      end

      it 'redirects to the referer' do
        patch :update, {status: {name: 'foo'}}
        expect(response).to redirect_to 'back'
      end

      describe 'when the status name is not valid' do
        before do
          allow(Door::Actions::Action).to receive(:from_name).with('foo').and_return(nil)
        end

        it 'sets an error flash' do
          patch :update, {status: {name: 'foo'}}
          expect(flash[:error]).to be_present
        end

      end

      describe 'when the status name is valid' do
        it 'saves the action' do
          patch :update, {status: {name: 'foo'}}
          expect(action).to have_received :save
        end

        describe 'when the status cannot be saved' do
          before do
            allow(action).to receive(:save).and_return(false)
          end

          it 'sets an error flash' do
            patch :update, {status: {name: 'foo'}}
            expect(flash[:error]).to be_present
          end
        end


        describe 'when the status can be saved' do
          before do
            allow(action).to receive(:save).and_return(true)
          end

          it 'sets a notice flash' do
            patch :update, {status: {name: 'foo'}}
            expect(flash[:notice]).to be_present
          end
        end
      end
    end
  end
end
