class InfoAmendment < Amendment
  attr_accessor :info

  def initialize(info)
    @info = info
  end
end
