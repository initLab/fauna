require "rails_helper"

describe ApplicationPolicy do
  subject { described_class.new instance_double(User), double(:anything) }

  [:create, :show, :update, :destroy, :index].each do |action|
    it { is_expected.not_to permit(action) }
  end
end
