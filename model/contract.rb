class Contract
  attr_reader :license, :amendments
  attr_accessor :signature_date, :client, :mont, :contents, :confirmed
  MINIMUM_CONTRATCT_CONTENTS_CONST = 1

  def initialize(data = {})
    @signature_date = data[:signature_date]
    @client = data[:client]
    @mont = data[:mont]
    @contents = data[:contents]
    raise ContractMustHaveContentError unless
    !@contents.nil? && @contents.size >= MINIMUM_CONTRATCT_CONTENTS_CONST

    @license = data[:license]
    @amendments = []
    @confirmed = false
  end

  def change_signature_date(signature_date)
    check_if_can_change_property
    @signature_date = signature_date
  end

  def confirm
    @confirmed = true
  end

  def change_client(client)
    check_if_can_change_property
    @client = client
  end

  def change_mont(mont)
    check_if_can_change_property
    @mont = mont
  end

  def add_content(content)
    check_if_can_change_property
    @contents << content
  end

  def remove_content(content)
    check_if_can_change_property
    raise ContractMustHaveContentError unless @contents.length > MINIMUM_CONTRATCT_CONTENTS_CONST

    @contents.delete(content)
  end

  def add_amendment(amendment)
    raise CantAddAmendments unless @confirmed

    @amendments << amendment
  end

  protected

  def check_if_can_change_property
    raise UpdateContractError if @confirmed
  end
end
