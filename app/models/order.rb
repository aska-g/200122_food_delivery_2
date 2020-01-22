class Order
  attr_accessor :id
  attr_reader :meal, :employee, :customer

  def initialize(attr={})
    @id = attr[:id]
    @delivered = attr[:delivered]
    @meal = attr[:meal]
    @employee = attr[:employee]
    @customer = attr[:customer]
    @delivered = attr[:delivered] || false
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end
end
