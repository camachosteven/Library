library = Hash.new
checkout = Hash.new
checkin = Hash.new
class Book
  attr_accessor :title, :author
  @@count = 0
  def initialize(title, author)
    @title = title
    @author = author
    @@count += 1
  end

  def to_s
    @title
  end

  def self.count
    @@count
  end
end

library["the_hunger_games_catching_fire"] = Book.new("The Hunger Games: Catching Fire", "Suzanne Collins")
library["the_hunger_games_mockingjay_part_1"] = Book.new("The Hunger Games: Mockingjay Part 1", "Suzanne Collins")

puts "Welcome to Steven Camacho's Book Library programmed by using Ruby. Are you a Guest or an Administrator?"
customer = gets.chomp.downcase
customer.gsub!(" ", "") if customer.include? " "
customer.gsub!(":", "") if customer.include? ":"

puts " "
case customer
when "administrator"
  print "Please type in the password: "
  password = gets.chomp
  if password == "Camachito"
    puts "You can do any one of the following actions:"
    puts "'Add' a book to the library."
    puts "'Remove' a book from the library."
    puts "'Display check-in' reports."
    puts "'Display checkout' reports."
    option = gets.chomp.downcase
    option.gsub!(" ","") if option.include? " "
    option.gsub!("-", "") if option.include? "-"
    puts " "

    case option
    when "add"
      print "Type in the title as written on the book. "
      title = gets.chomp
      array_title = title.gsub(":", "").gsub("/", "").gsub("-", "").gsub("'", "").downcase.gsub(" ", "_")
      puts " "
      print "Type in the author as written on the book. "
      author = gets.chomp
      book_details = Book.new(title, author)
      library[array_title] = book_details
      puts " "
      puts "This book has been added! Would you like to see the library's updated inventory? (Y/N)"
      answer = gets.chomp.downcase
      answer.gsub!("es", "").gsub!("o", "")
      puts " "
      if answer == "y"
        library.each do |key, value|
          puts "#{value.title} (#{value.author})"
        end
        puts " "
        puts "Thank you for visiting SC's Ruby library. Have a good day. :)"
      elsif answer == "n"
        puts "Okay, then. Thank you for visiting SC's Ruby library. Have a good day. :)"
      else
        puts "You didn't type in any one of the four options. Try again."
      end
    when "remove"
      puts "Which book would you like to remove?"
      library.each do |key, value|
        puts "#{key}: #{value.title} (#{value.author})"
      end
      delete_book = gets.chomp
      before = Book.count
      after = Book.count
      library.each do |key, book|
        if delete_book == book.title
          after -= 1
          library.delete(key)
          puts " "
          puts "This book has been deleted! Would you like to see the library's updated inventory? (Y/N)"
          answer = gets.chomp.downcase
          answer = answer.gsub("es", "").gsub("o", "")
          puts " "
          case answer
          when "y"
            library.each do |key, value|
            puts "#{key}: #{value.title} (#{value.author})"
            end
            puts " "
            puts "Thank you for visiting SC's Ruby library. Have a good day. :)"
          when "n"
            puts "Okay, then. Thank you for visiting SC's Ruby library. Have a good day. :)"
          else
          end
        end
      end
      if before == after
        puts " "
        puts "This book isn't in your library."
      end
    when "displaycheckin"
    when "displaycheckout"
    else
    end
  else
    puts "Incorrect password!"
  end
when "guest"
  puts "Would you like to check-in or check-out a book?"
  service = gets.chomp.downcase
  service.gsub!(" ","") if service.include? " "
  service.gsub!("-", "") if service.include? "-"
end
