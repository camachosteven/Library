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

date = Time.new(2017, 8, 8, 0, 0, 0, "-04:00")
morning = "AM"
afternoon = "PM"
library["avengers_age_of_ultron"] = Book.new("Avengers: Age of Ultron", "Stan Lee")
library["the_hunger_games_mockingjay_part_1"] = Book.new("The Hunger Games: Mockingjay Part 1", "Suzanne Collins")
library["the_hunger_games_catching_fire"] = Book.new("The Hunger Games: Catching Fire", "Suzanne Collins")
checkout["the_hunger_games_catching_fire"] = Hash.new
checkout["the_hunger_games_mockingjay_part_1"] = Hash.new
checkout["avengers_age_of_ultron"] = Hash.new
checkin["the_hunger_games_catching_fire"] = Hash.new
checkin["the_hunger_games_mockingjay_part_1"] = Hash.new
checkin["avengers_age_of_ultron"] = Hash.new
checkout["avengers_age_of_ultron"]["checkout_1"] = date.hour > 12 ? "#{date.month}/#{date.day}/#{date.year} #{date.hour - 12}:#{date.min}:#{date.sec} #{afternoon} -0400 5days"
: "#{date.month}/#{date.day}/#{date.year} #{date.hour}:#{date.min}:#{date.sec} #{morning} -0400 5days"
checkout["the_hunger_games_mockingjay_part_1"]["checkout_1"] = date.hour > 12 ? "#{date.month}/#{date.day}/#{date.year} #{date.hour - 12}:#{date.min}:#{date.sec} #{afternoon} -0400 10days"
: "#{date.month}/#{date.day}/#{date.year} #{date.hour}:#{date.min}:#{date.sec} #{morning} -0400 10days"
checkout["the_hunger_games_catching_fire"]["checkout_1"] = date.hour > 12 ? "#{date.month}/#{date.day}/#{date.year} #{date.hour - 12}:#{date.min}:#{date.sec} #{afternoon} -0400 20days"
: "#{date.month}/#{date.day}/#{date.year} #{date.hour}:#{date.min}:#{date.sec} #{morning} -0400 20days"

puts "Welcome to Steven Camacho's Book Library programmed by using Ruby. Are you a Guest or an Administrator?"
customer = gets.chomp.downcase

puts " "
case substitute(customer)
when "administrator"
  print "Please type in the password: "
  password = gets.chomp
  puts " "
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
        library = library.sort.to_h
        library.each do |key, value|
          puts "#{value.title} (#{value.author}) [#{key}]"
        end
        puts " "
        puts "Thank you for visiting SC's Ruby library. Have a good day. :)"
      elsif answer == "n"
        puts "Okay, then. Thank you for visiting SC's Ruby library. Have a good day. :)"
      else
        puts "You didn't type in any one of the four options. Try again."
      end
    when "remove"
      library.each do |key, value|
        puts "#{value.title} (#{value.author}) [#{key}]"
      end
      puts " "
      puts "Which book would you like to remove?"
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
      checkin = checkin.sort.to_h
      puts "Here are the check-in (return) records:"
      puts " "
      checkin.map { |key, value| puts "#{key}, #{value}" }
    when "displaycheckout"
      checkout = checkout.sort.to_h
      puts "Here are the check-out records:"
      puts " "
      checkout.map { |key, value| puts "#{key}, #{value}" }
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
  puts " "
  if service == "checkin" || service == "return"
    library = library.sort_by {|_key, value| value.title}.to_h
    library.each do |key, value|
      puts "#{value.title} (#{value.author})"
    end
    puts " "
    puts "Which book do you want to checkin (return)?"
    selected_books = gets.chomp
    puts " "
    before = Book.count
    after = Book.count
    library.map do |id, book|
      if substitute(selected_books) == substitute(book.title).downcase
        after += 1
        now = 0
        later = 0
        time = ""
        checkout_month = ""
        checkout_day = ""
        checkout_year = ""
        supposed_checkout_period = ""
        multiple = 0
        checkin_time = Time.new(Time.now.year, Time.now.month, Time.new.day, 0, 0, 0, "-04:00")
        todays_date = Time.now
        number_of_checkins = ""
        number_of_checkouts = ""
        checkin.map do |key, value|
          if check_form(selected_books) == key
            later += 1
            number_of_checkins = checkin[key].length
            hash_inside_hash = checkin[key]
            if hash_inside_hash.empty?
              later += 1
            end
          end
        end
        checkout.map do |key, value|
          if check_form(selected_books) == key
            number_of_checkouts = checkout[key].length
            supposed_checkout_period = checkout[key]["checkout_#{number_of_checkouts}"].split(" ")[-1].gsub!("days", "").to_i
            checkout_month = checkout[key]["checkout_#{number_of_checkouts}"].split("/")[0].to_i
            checkout_day = checkout[key]["checkout_#{number_of_checkouts}"].split("/")[1].to_i
            checkout_year = checkout[key]["checkout_#{number_of_checkouts}"].split("/")[2].split(" ")[0].to_i
          end
        end
        checkout_time = Time.new(checkout_year, checkout_month, checkout_day, 0, 0, 0, "-04:00")
        checkout_period = checkin_time - checkout_time
        checkout_period = (checkout_period / 60 / 60 / 24).to_i
        late_fee = 0.25 * (checkout_period - supposed_checkout_period) if checkout_period > supposed_checkout_period
      number_of_checkins = number_of_checkins.to_i
      number_of_checkouts = number_of_checkouts.to_i
      late_boolean = checkout_period > supposed_checkout_period ? " *returned #{checkout_period} days late" : ""
      if number_of_checkins < number_of_checkouts
        case later - now
        when 2
          checkin[check_form(selected_books)]["checkin_1"] = todays_date.hour > 12 ? "#{todays_date.month}/#{todays_date.day}/#{todays_date.year} #{todays_date.hour - 12}:#{todays_date.min}:#{todays_date.sec} #{afternoon} -0400#{late_boolean}"
          : "#{todays_date.month}/#{todays_date.day}/#{todays_date.year} #{todays_date.hour}:#{todays_date.min}:#{todays_date.sec} #{morning} -0400#{late_boolean}"
        when 1
          number_of_checkins += 1
          checkin[check_form(selected_books)]["checkin_#{number_of_checkins}"] = todays_date.hour > 12 ? "#{todays_date.month}/#{todays_date.day}/#{todays_date.year} #{todays_date.hour - 12}:#{todays_date.min}:#{todays_date.sec} #{afternoon} -0400#{late_boolean}"
          : "#{todays_date.month}/#{todays_date.day}/#{todays_date.year} #{todays_date.hour}:#{todays_date.min}:#{todays_date.sec} #{morning} -0400#{late_boolean}"
        end
        puts checkout_period > supposed_checkout_period ? "Thank you for returning the book. However, you have returned the book late. Please pay $#{late_fee} in late fees at the cashier."
        : "Thank you for returning the book on time. We hope to have precious, responsible cilents like you back at our library."
        puts "Thank you once again for visiting SC's Ruby Library. Have a wonderful day! :D"
      else
        puts "This book hasn't been checked out yet."
      end
      end
    end
  elsif service == "checkout"
    library = library.sort_by {|_key, value| value.title}.to_h
    library.each do |key, value|
      puts "#{value.title} (#{value.author})"
    end
    puts " "
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
        number_of_days = substitute(number_of_days).to_i
        if number_of_days < 20
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
            checkout[check_form(selected_books)]["checkout_#{number_of_checkouts}"] = todays_date.hour > 12 ? "#{todays_date.month}/#{todays_date.day}/#{todays_date.year} #{todays_date.hour - 12}:#{todays_date.min}:#{todays_date.sec} #{afternoon} -0400#{number_of_days}days"
            : "#{todays_date.month}/#{todays_date.day}/#{todays_date.year} #{todays_date.hour}:#{todays_date.min}:#{todays_date.sec} #{morning} -0400 #{number_of_days}days"
          elsif later - now == 2
            checkout[check_form(selected_books)]["checkout_1"] = todays_date.hour > 12 ? "#{todays_date.month}/#{todays_date.day}/#{todays_date.year} #{todays_date.hour - 12}:#{todays_date.min}:#{todays_date.sec} #{afternoon} -0400"
            : "#{todays_date.month}/#{todays_date.day}/#{todays_date.year} #{todays_date.hour}:#{todays_date.min}:#{todays_date.sec} #{morning} -0400 #{number_of_days}days"
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
          puts "Thank you for visiting SC's Ruby library. Have a wonderful day! :D"
        else
          puts " "
          puts "That's too many days! Select fewer days next time. :("
        end
      end
    end
    puts "This book isn't in my Library's inventory." if before == after
  else
    puts "Looks like you typed in an option that's not available to you as a guest."
  end
else
  puts "Error!"
end
