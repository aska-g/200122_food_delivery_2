require_relative '../models/order'
require 'csv'

class OrderRepository
  def initialize(csv_file, meal_repo, employee_repo, customer_repo)
    @csv_file = csv_file
    @orders = []
    @next_id = 1

    @meal_repo = meal_repo
    @employee_repo = employee_repo
    @customer_repo = customer_repo

    load_csv
  end

  def all
    @orders
  end

  def add_order(order)
    order.id = @next_id
    @orders << order
    @next_id += 1
    save_csv
  end

  def save
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      # row = { id: '1', meal_id: '1', customer_id: '2', emploee_id: '3', delivered: 'true'}
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == 'true'

      meal_id = row[:meal_id].to_i
      employee_id = row[:employee_id].to_i
      customer_id = row[:customer_id].to_i

      row[:meal] = @meal_repo.find(meal_id) #=> instance of a Meal class
      row[:employee] = @employee_repo.find(employee_id) #=> instance of a Meal class
      row[:customer] = @customer_repo.find(customer_id) #=> instance of a Meal class

      # row = { id: '1', meal_id: '1', customer_id: '2', emploee_id: '3', delivered: 'true', meal: (an instance of a Meal class).....}

      @orders << Order.new(row)
    end
    @next_id = @orders.last.id + 1 unless @orders.empty?
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << %w(id meal_id employee_id customer_id delivered)
      @orders.each do |order|
        csv << [ order.id, order.meal.id, order.employee.id, order.customer.id, order.delivered? ]
      end
    end
  end
end









