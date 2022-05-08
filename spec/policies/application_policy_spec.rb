require "rails_helper"

describe ApplicationPolicy do
  subject { described_class.new instance_double(User), double(:anything) }

  context "when applied to a normal user" do
    before do
      expect(subject.user).to receive(:has_role?).with(:board_member).and_return(false)
    end

    [:create, :show, :update, :destroy, :index].each do |action|
      it { is_expected.not_to permit(action) }
    end
  end

  context "when applied to a board member" do
    before do
      expect(subject.user).to receive(:has_role?).with(:board_member).and_return(true)
    end

    [:create, :show, :update, :destroy, :index].each do |action|
      it { is_expected.to permit(action) }
    end
  end
end
