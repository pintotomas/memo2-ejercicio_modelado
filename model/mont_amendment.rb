class MontAmendment < Amendment
  attr_accessor :frequency

  def initialize(frequency)
    @frequency = frequency
  end

  def apply(contract); end
end
