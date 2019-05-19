class ContractMustHaveContentError < RuntimeError
  def initialize(message = 'Contract must have content')
    @message = message
  end
end
