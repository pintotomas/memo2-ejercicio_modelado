class FrequencyAmendment < Amendment
  attr_accessor :frequency

  def initialize(frequency)
    @frequency = frequency
  end
end
