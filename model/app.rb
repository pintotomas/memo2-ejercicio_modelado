require_relative './sale_order'

order = SaleOrder.new(1000, 1, :AL)
puts order.calculate
