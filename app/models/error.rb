# frozen_string_literal: true

# Error class to respond to failed requests
class Error
  attr_accessor :code, :message

  def initialize(code:, message:)
    @code = code
    @message = message
  end
end
