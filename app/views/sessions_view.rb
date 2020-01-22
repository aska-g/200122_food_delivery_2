class SessionsView
  def ask_for(something)
    puts "#{something}?"
    gets.chomp
  end

  def welcome(username)
    puts "You're now logged in, #{username}"
  end

  def incorrect_credentials
    puts "WRONGGG, try again please"
  end
end
