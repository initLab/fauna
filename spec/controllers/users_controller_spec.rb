require 'rails_helper'

describe UsersController, type: :controller do
  describe 'GET #present_embeddable' do
    it 'returns HTTP 410 Gone' do
      get 'present_embeddable'
      expect(response.code).to eq '410'
    end
  end

  describe 'GET #present' do
    it 'assigns a list of present users to @users' do
      user = build :user

      radwho_instance = instance_double(RadWho)
      allow(radwho_instance).to receive(:present_users).and_return([user])
      expect(RadWho).to receive(:new).and_return(radwho_instance)

      get 'present'
      expect(assigns(:users)).to eq [user]
    end
  end
end
