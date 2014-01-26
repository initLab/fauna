require 'spec_helper'

describe Device do
  it { should belong_to :owner }
  it { should validate_presence_of :value }
end
