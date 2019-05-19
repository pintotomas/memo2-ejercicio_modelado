class MontAmendment < Amendment
  attr_accessor :mont

  def initialize(mont)
    @mont = mont
  end

  def apply(contract)
    contract.mont = @mont
  end
end
