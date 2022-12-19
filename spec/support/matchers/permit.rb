RSpec::Matchers.define :permit do |expected|
  method_name = (expected.to_s + "?").to_sym

  description do
    "permit the #{expected} action"
  end

  match do |actual|
    actual.respond_to?(method_name) && actual.public_send(method_name)
  end

  failure_message do |actual|
    if !actual.respond_to?(method_name)
      "expected #{actual.inspect} to respond to #{method_name}"
    else
      "expected #{actual.inspect} to permit the #{expected} action"
    end
  end

  match_when_negated do |actual|
    actual.respond_to?(method_name) && !actual.public_send(method_name)
  end

  failure_message_when_negated do |actual|
    if !actual.respond_to?(method_name)
      "expected #{actual.inspect} to respond to #{method_name}"
    else
      "expected #{actual.inspect} not to permit the #{expected} action"
    end
  end
end
