class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    while @running
    @employee = @sessions_controller.login
      while @employee # instance of Employee
        if @employee.manager?
          display_manager_menu
          choice = gets.chomp.to_i
          print `clear`
          route_manager_action(choice)
        else
          display_delivery_guy_menu
          choice = gets.chomp.to_i
          print `clear`
          route_delivery_guy_action(choice)
        end
      end
    end
  end

  private

  def display_manager_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. List all meals"
    puts "2. Add new meal"
    puts "3. List all customers"
    puts "4. Add new customer"
    puts "5. List undelivered orders"
    puts "6. Add new order"
    puts "7. Log out"
    puts "8. Exit"
    print "> "
  end

  def display_delivery_guy_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. List my orders"
    puts "2. Mark an order as delivered"
    puts "7. Log out"
    puts "8. Exit"
    print "> "
  end

  def route_manager_action(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add_meal
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add_customer
    when 5 then @orders_controller.undelivered_orders
    when 6 then @orders_controller.add_order
    when 7 then @employee = nil
    when 8 then stop!
    else
      puts "Try again..."
    end
  end

  def route_delivery_guy_action(choice)
    case choice
    when 1 then @orders_controller.list_my_undelivered
    when 2 then @orders_controller.mark_as_delivered
    when 7 then @employee = nil
    when 8 then stop!
    else
      puts "Try again..."
    end
  end

  def stop!
    @employee = nil
    @running = false
  end
end
