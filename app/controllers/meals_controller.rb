require_relative '../views/meals_view'
require_relative '../models/meal'

class MealsController
  def initialize(meal_repo)
    @meal_repo = meal_repo
    @meal_view = MealsView.new
  end

  def list
    display_meals
  end

  def add_meal
    name = @meal_view.ask_user_for(:name)
    price = @meal_view.ask_user_for(:price).to_i
    meal = Meal.new(name: name, price: price)
    @meal_repo.add(meal)
    display_meals
  end

  private

  def display_meals
    meals = @meal_repo.all
    @meal_view.display(meals)
  end
end
