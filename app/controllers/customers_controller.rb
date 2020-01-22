require_relative '../views/customers_view'
require_relative '../models/customer'

class CustomersController
  def initialize(customer_repo)
    @customer_repo = customer_repo
    @customers_view = CustomersView.new
  end

  def list
    display_customers
  end

  def add_customer
    name = @customers_view.ask_user_for(:name)
    address = @customers_view.ask_user_for(:address)
    customer = Customer.new(name: name, address: address)
    @customer_repo.add(customer)
    display_customers
  end

  private

  def display_customers
    customers = @customer_repo.all
    @customers_view.display(customers)
  end
end
