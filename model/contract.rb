class Contract
  attr_reader :info, :frequency, :mont, :content

  attr_accessor :amendments, :confirmed

  def initialize(data = {})
    @info = data[:info]
    @frequency = data[:frequency]
    @mont = data[:mont]
    @content = data[:content]
    @amendments = []
    @confirmed = false
  end

  def latest; end

  def change_info(info)
    raise UpdateContractError if @confirmed

    @info = info
  end

  def change_frequency(frequency); end

  def change_mont(mont); end

  def version(number); end

  def add_amendments(amendment)
    @amendments.push(amendment)
  end
end
