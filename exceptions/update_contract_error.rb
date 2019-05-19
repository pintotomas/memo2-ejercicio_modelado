class UpdateContractError < RuntimeError
  def initialize(message = 'Cannot modify confirmed contract')
    @message = message
  end
end

class CantAddAmendments < RuntimeError
  def initialize(message = 'Cannot make amendments to an uncofirmed contract')
    @message = message
  end
end
