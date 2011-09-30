module OrdersHelper
  
  def payment_types
    return [[t(:cash, :scope => "orders"), 'cash'], [t(:transfer, :scope => "orders"), 'transfer']]
  end
  
end
