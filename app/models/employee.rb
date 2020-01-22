class Employee
  attr_reader :username, :password
  def initialize(attr={})
    @username = attr[:username]
    @password = attr[:password]
    @role = attr[:role]
    @id = attr[:id]
  end

  def manager?
    @role == 'manager'
  end
end
