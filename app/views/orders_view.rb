class OrdersView
  def display_orders(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1}. Customer: #{order.customer.name}, employee: #{order.employee.username}, meal: #{order.meal.name}"
    end
  end

  def ask_for(something)
    puts "Which #{something} id?"
    gets.chomp.to_i
  end
end
