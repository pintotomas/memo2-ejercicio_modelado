class Contract
  attr_accessor :info, :frequency, :cost, :content, :amendments

  def initialize(data = {})
    @info = data[:info]
    @frequency = data[:frequency]
    @cost = data[:cost]
    @content = data[:content]
    @amendments = []
  end

  def latest; end

  def version(number); end

  def add_amendments(amendment)
    @amendments.push(amendment)
  end
end
