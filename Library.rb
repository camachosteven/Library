
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

def substitute(input)
  input.gsub(":", "").gsub("/", "").gsub("-", "").gsub("'", "").gsub(" ", "")
end

def check_form(input)
  input.gsub(":", "").gsub("/", "").gsub("-", "").gsub("'", "").gsub(" ", "_")
end

date = Time.new(2016, 11, 30, 5, 30, 24, "-04:00")
morning = "AM"
afternoon = "PM"
library["avengers_age_of_ultron"] = Book.new("Avengers: Age of Ultron", "Stan Lee")
library["the_hunger_games_mockingjay_part_1"] = Book.new("The Hunger Games: Mockingjay Part 1", "Suzanne Collins")
library["the_hunger_games_catching_fire"] = Book.new("The Hunger Games: Catching Fire", "Suzanne Collins")
checkout["the_hunger_games_catching_fire"] = Hash.new
checkout["the_hunger_games_mockingjay_part_1"] = Hash.new
checkout["avengers_age_of_ultron"] = Hash.new
checkout["avengers_age_of_ultron"]["checkout_1"] = date.hour > 12 ? "#{date.month}/#{date.day}/#{date.year} #{date.hour - 12}:#{date.min}:#{date.sec} #{afternoon} -0400"
: "#{date.month}/#{date.day}/#{date.year} #{date.hour}:#{date.min}:#{date.sec} #{morning} -0400"
checkout["the_hunger_games_mockingjay_part_1"]["checkout_1"] = date.hour > 12 ? "#{date.month}/#{date.day}/#{date.year} #{date.hour - 12}:#{date.min}:#{date.sec} #{afternoon} -0400"
: "#{date.month}/#{date.day}/#{date.year} #{date.hour}:#{date.min}:#{date.sec} #{morning} -0400"
checkout["the_hunger_games_catching_fire"]["checkout_1"] = date.hour > 12 ? "#{date.month}/#{date.day}/#{date.year} #{date.hour - 12}:#{date.min}:#{date.sec} #{afternoon} -0400"
: "#{date.month}/#{date.day}/#{date.year} #{date.hour}:#{date.min}:#{date.sec} #{morning} -0400"

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
      library[array_title] = Book.new(title, author)
      checkout[array_title] = Hash.new
      checkin[array_title] = Hash.new
      puts " "
      puts "This book has been added! Would you like to see the library's updated inventory? (Y/N)"
      answer = gets.chomp.downcase
      answer = answer.gsub("es", "").gsub("o", "")
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
        if substitute(delete_book).downcase == substitute(book.title).downcase
          after -= 1
          library.delete(key)
          puts " "
          puts "This book has been deleted! Would you like to see the library's updated inventory? (Y/N)"
          answer = gets.chomp.downcase
          answer = answer.gsub("es", "").gsub("o", "")
          puts " "
          case answer
          when "y"
            library.each do |id, book|
            puts "#{book.title} (#{book.author}) [#{id}]"
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
  puts "Would you like to check-in (return) or check-out a book?"
  service = gets.chomp
  service.gsub!(" ","") if service.include? " "
  service.gsub!("-", "") if service.include? "-"
  service.downcase!
  if service == "checkin" || service == "return"
    
  elsif service == "checkout"
    puts " "
    library = library.sort_by {|_key, value| value.title}.to_h
    library.each do |key, value|
      puts "#{value.title} (#{value.author})"
    end
    puts "Which book do you want to checkout?"
    selected_books = gets.chomp
    before = Book.count
    after = Book.count
    puts " "
    library.each do |id, book|
      if substitute(selected_books).downcase == substitute(book.title).downcase
        after -= 1
        puts "How many days do you want to check it out? (20 days max.)"
        number_of_days = gets.chomp
        number_of_days = substitute(number_of_days)
        todays_date = Time.new
        now = 0
        later = 0
        number_of_checkouts = ""
        checkout.map do |key, value|
          if check_form(selected_books).downcase == key
            later += 1
            number_of_checkouts = checkout[key].length
            hash_inside_hash = checkout[key]
            if hash_inside_hash.empty?
              later += 1
            end
          end
        end
        number_of_checkouts = number_of_checkouts.to_i
        if later - now == 1
          number_of_checkouts += 1
          checkout[check_form(selected_books)]["checkout_#{number_of_checkouts}"] = todays_date.hour > 12 ? "#{todays_date.month}/#{todays_date.day}/#{todays_date.year} #{todays_date.hour - 12}:#{todays_date.min}:#{todays_date.sec} #{afternoon} -0400"
          : "#{todays_date.month}/#{todays_date.day}/#{todays_date.year} #{todays_date.hour}:#{todays_date.min}:#{todays_date.sec} #{morning} -0400"
        elsif later - now == 2
          checkout[check_form(selected_books)]["checkout_1"] = todays_date.hour > 12 ? "#{todays_date.month}/#{todays_date.day}/#{todays_date.year} #{todays_date.hour - 12}:#{todays_date.min}:#{todays_date.sec} #{afternoon} -0400"
          : "#{todays_date.month}/#{todays_date.day}/#{todays_date.year} #{todays_date.hour}:#{todays_date.min}:#{todays_date.sec} #{morning} -0400"
        end
        due_date = todays_date + (number_of_days.to_i * (60 * 60 * 24))
        due_weekday = due_date.wday
        due_month = due_date.month
        due_day = due_date.day
        due_year = due_date.year
        case due_weekday
        when 0 then due_weekday = "Sunday"
        when 1 then due_weekday = "Monday"
        when 2 then due_weekday = "Tuesday"
        when 3 then due_weekday = "Wednesday"
        when 4 then due_weekday = "Thursday"
        when 5 then due_weekday = "Friday"
        when 6 then due_weekday = "Saturday"
        else puts "Error"
        end
        case due_month
        when 1 then due_month = "January"
        when 2 then due_month = "February"
        when 3 then due_month = "March"
        when 4 then due_month = "April"
        when 5 then due_month = "May"
        when 6 then due_month = "June"
        when 7 then due_month = "July"
        when 8 then due_month = "August"
        when 9 then due_month = "September"
        when 10 then due_month = "October"
        when 11 then due_month = "November"
        when 12 then due_month = "December"
        else puts "Error"
        end

        puts " "
        puts "The book(s) are due on #{due_weekday} #{due_month} #{due_day}, #{due_year}. You can checkout books at my library for free. There's a charge of 25 cents per day late."
        checkout.map do |title, hash|
          puts "#{title}: #{hash}"
        end
        puts "Thank you for visiting SC's Ruby library. Have a good day. :)"
      end
    end

    puts "This book isn't in my Library's inventory." if before == after
  else
    puts "Looks like you typed in an option that's not available to you as a guest."
  end
else
  puts "Error!"
end
