class UpdateContractError < RuntimeError
  def initialize(message = 'Cannot modify confirmed contract')
    @message = message
  end
end
