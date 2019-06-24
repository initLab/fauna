require "rails_helper"

describe LightsPolicyManagementPolicy do
  context 'given the user is a board member' do
    let(:board_member) { instance_double(User) }
    subject { described_class.new board_member, double }

    before do
      allow(board_member).to receive(:has_role?).with(:board_member).and_return(true)
      allow(board_member).to receive(:has_role?).with(:trusted_member).and_return(false)
    end

    it { is_expected.to permit(:create) }
    it { is_expected.to permit(:show) }
  end

  context 'given the user is a trusted member' do
    let(:trusted_member) { instance_double(User) }
    subject { described_class.new trusted_member, double }

    before do
      allow(trusted_member).to receive(:has_role?).with(:board_member).and_return(false)
      allow(trusted_member).to receive(:has_role?).with(:trusted_member).and_return(true)
    end

    it { is_expected.to permit(:create) }
    it { is_expected.to permit(:show) }
  end

  context 'given the user is a regular user' do
    let(:regular_user) { instance_double(User) }
    subject { described_class.new regular_user, double }

    before do
      allow(regular_user).to receive(:has_role?).with(:board_member).and_return(false)
      allow(regular_user).to receive(:has_role?).with(:trusted_member).and_return(false)
    end

    it { is_expected.not_to permit(:create) }
    it { is_expected.not_to permit(:show) }
  end

  context 'given the user has not signed in' do
    subject { described_class.new nil, double }

    it { is_expected.not_to permit(:create) }
    it { is_expected.not_to permit(:show) }
  end
end
