def leap_year?(year)
  year % 400 == 0 ? true : year % 4 == 0 && year % 100 != 0
end

months = {
  1 => 31, 2 => 28, 3 => 31, 4  => 30, 5  => 31, 6  => 30, 
  7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31
}

puts "Введите число, месяц и год через пробел:"
date = gets.chomp.split.map(&:to_i)

day, month, year = date
counter          = 0

months[2] = 29 if leap_year?(year)

if month == 1
  counter = day
else
  (1...month).each { |i| counter += months[i] }
  counter += day
end

puts "Порядковый номер даты #{date.join('.')}: #{counter}"