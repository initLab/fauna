require 'rails_helper'

describe UsersController, type: :controller do
  describe 'GET #present_embeddable' do
    it 'should return HTTP 410 Gone' do
      get 'present_embeddable'
      expect(response.code).to eq '410'
    end
  end

  describe 'GET #present' do
    it 'should assign a list of present users to @users' do
      user = build :user
      allow(Arp).to receive(:present_users).and_return([user])

      get 'present'
      expect(assigns(:users)).to eq [user]
    end
  end
end
