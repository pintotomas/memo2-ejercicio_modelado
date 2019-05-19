class FrequencyAmendment < Amendment
  attr_accessor :frequency

  def initialize(frequency)
    @frequency = frequency
  end

  def apply(contract)
    contract.license.repetition_frequency = @frequency
  end
end
