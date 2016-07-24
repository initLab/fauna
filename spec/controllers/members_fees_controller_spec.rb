require 'rails_helper'

RSpec.describe MembersFeesController, type: :controller do
  let(:user) { create :user }
  let(:valid_attributes) { {user: user, month: Time.now} }
  before { sign_in user }

  describe "GET #index" do
    it "assigns all members_fees as @members_fees" do
      members_fee = MembersFee.create! valid_attributes
      get 'index'
      expect(assigns(:members_fees)).to eq([members_fee])
    end

    it "assignes members_fees filtered by user to @members_fees" do
      user2 = create :user
      members_fee = MembersFee.create! valid_attributes
      MembersFee.create! user: user2, month: Time.now
      filtered_memebers_fee = MembersFee.where(user: user)
      get 'index', user_id: user.id
      expect(assigns(:members_fees)).to eq(filtered_memebers_fee)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new MembersFee" do
        expect {
          post :create, {:members_fee => valid_attributes}, valid_session
        }.to change(MembersFee, :count).by(1)
      end

      it "assigns a newly created members_fee as @members_fee" do
        post 'create', {:members_fee => valid_attributes}, valid_session
        expect(assigns(:members_fee)).to be_a(MembersFee)
        expect(assigns(:members_fee)).to be_persisted
      end

      it "redirects to the created members_fee" do
        post :create, {:members_fee => valid_attributes}, valid_session
        expect(response).to redirect_to(MembersFee.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved members_fee as @members_fee" do
        post :create, {:members_fee => invalid_attributes}, valid_session
        expect(assigns(:members_fee)).to be_a_new(MembersFee)
      end

      it "re-renders the 'new' template" do
        post :create, {:members_fee => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested members_fee" do
      members_fee = MembersFee.create! valid_attributes
      expect {
        delete :destroy, {:id => members_fee.to_param}, valid_session
      }.to change(MembersFee, :count).by(-1)
    end

    it "redirects to the members_fees list" do
      members_fee = MembersFee.create! valid_attributes
      delete :destroy, {:id => members_fee.to_param}, valid_session
      expect(response).to redirect_to(members_fees_url)
    end
  end

end
