class Contract
  attr_reader :license, :amendments
  attr_accessor :signature_date, :client, :mont, :content, :confirmed

  def initialize(data = {})
    @signature_date = data[:signature_date]
    @client = data[:client]
    @mont = data[:mont]
    @content = data[:content]
    @license = data[:license]
    @amendments = []
    @confirmed = false
  end

  def check_if_can_change_property
    raise UpdateContractError if @confirmed
  end

  def change_mont(mont)
    check_if_can_change_property
    @mont = mont
  end

  def add_amendment(amendment)
    @amendments << amendment
  end

  def add_content(amendment)
    @amendments << amendment
  end
end
