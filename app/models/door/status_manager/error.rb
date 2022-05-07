module Door
  module StatusManager
    class Error < StandardError; end

    class UnexpectedResponseCodeError < Error; end
  end
end
