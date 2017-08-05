library = Hash.new

puts "Welcome to Steven Camacho's Book Library programmed by using Ruby. Are you a Guest or an Administrator?"
customer = gets.chomp.downcase
customer.gsub!(" ", "") if customer.include? " "
customer.gsub!(":", "") if customer.include? ":"

case customer
when "administrator"
  print "Please type in the password: "
  passsword = gets.chomp
  if password == "Camachito"
    puts "You can do any one of the following actions:"
    puts "Add a book to the library."
    puts "Remove a book from the library."
    puts "Display checkout"
  else
    puts "Incorrect password!"
  end
when "guest"
  puts "Would you like to check-in or check-out a book?"
  service = gets.chomp.downcase
  service.gsub!(" ","") if service.include? " "
  service.gsub!("-", "") if service.include? "-"
end
