class License
  attr_reader :signals
  attr_accessor :amount_of_repetitions, :repetition_frequency

  def initialize(amount_of_repetitions, repetition_frequency, signals)
    @amount_of_repetitions = amount_of_repetitions
    @repetition_frequency = repetition_frequency
    @signals = signals
  end

  def add_signal(signal_name)
    @signals << signal_name
  end

  def remove_signal(signal_name)
    @signals.delete(signal_name)
  end
end
