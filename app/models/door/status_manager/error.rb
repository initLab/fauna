module Door::StatusManager
  class Error < StandardError; end

  class UnexpectedResponseCodeError < Error; end
end
