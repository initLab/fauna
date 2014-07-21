RSpec::Matchers.define :have_error_on do |expected|
  match do |actual|
    expect(actual).to_not be_valid
    expect(actual.errors.keys).to include expected
  end
end
