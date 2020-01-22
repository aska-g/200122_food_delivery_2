require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repo = employee_repository
    @sessions_view = SessionsView.new
  end

  def login
    # view: ask for username
    username = @sessions_view.ask_for('username')
    # view: ask for password
    password = @sessions_view.ask_for('password')

    # repo: check if username exists
    employee = @employee_repo.find_by_username(username)
    # repo: check if password correct
    if employee && employee.password == password
      # view: if username and password match, greet
      @sessions_view.welcome(username)
      return employee
    else
      # view: else: incorrect credentials
      @sessions_view.incorrect_credentials
      login # recursive call
    end

  end
end
