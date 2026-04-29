# frozen_string_literal: true

RSpec::Matchers.define :have_error_on do |expected|
  match do |actual|
    expect(actual).not_to be_valid
    expect(actual.errors.attribute_names).to include expected
  end
end
