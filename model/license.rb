class License
  attr_reader :signals
  attr_accessor :amount_of_repetitions, :repetition_frequency, :contract

  def initialize(amount_of_repetitions, repetition_frequency, signals)
    @amount_of_repetitions = amount_of_repetitions
    @repetition_frequency = repetition_frequency
    @signals = signals
    @contract = nil
  end

  def check_if_can_change_property
    raise UpdateContractError if @contract.confirmed
  end

  def add_signal(signal_name)
    check_if_can_change_property
    @signals << signal_name
  end

  def remove_signal(signal_name)
    check_if_can_change_property
    @signals.delete(signal_name)
  end

  def confirm
    @confirmed = true
  end

  def change_amount_of_repetitions(amount_of_repetitions)
    check_if_can_change_property
    @amount_of_repetitions = amount_of_repetitions
  end

  def change_repetition_frequency(repetition_frequency)
    check_if_can_change_property
    @repetition_frequency = repetition_frequency
  end
end
