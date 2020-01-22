require_relative '../models/order'
require_relative '../views/orders_view'

class OrdersController
  def initialize(orders_repo, meal_repo, employee_repo, customer_repo)
    @orders_repo = orders_repo
    @meal_repo = meal_repo
    @employee_repo = employee_repo
    @customer_repo = customer_repo
    @view = OrdersView.new
  end

  def undelivered_orders
    # order repo: get all orders
    orders = @orders_repo.all
    # filter orders by status
    undelivered_orders = orders.select { |order| !order.delivered? }
    # view: display
    @view.display_orders(undelivered_orders)
  end

  def add_order
    # view: ask manager for meal_id
    meal_id = @view.ask_for('meal')
    # meal_repo: find meal
    meal = @meal_repo.find(meal_id)
    # view: ask manager for customer_id
    customer_id = @view.ask_for('customer')
    # customer_repo: find customer
    customer = @customer_repo.find(customer_id)
    # view: ask manager for employee_id
    employee_id = @view.ask_for('employee')
    # employee_repo: find employee
    employee = @employee_repo.find(employee_id)
    # create a new instance of Order
    order = Order.new(meal: meal, customer: customer, employee: employee)
    # repo: call add(order)
    @orders_repo.add_order(order)
    # save repo
    @orders_repo.save
  end
end
