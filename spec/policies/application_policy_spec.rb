# frozen_string_literal: true

require 'rails_helper'

describe ApplicationPolicy, type: :helper do
  context 'when applied to a normal user' do
    subject { described_class.new (create :trusted_member), instance_double(ApplicationController) }

    %i[create show update destroy index].each do |action|
      it { is_expected.not_to permit(action) }
    end
  end

  context 'when applied to a board member' do
    subject { described_class.new (create :board_member), instance_double(ApplicationController) }

    %i[create show update destroy index].each do |action|
      it { is_expected.to permit(action) }
    end
  end
end
