def leap_year?(year)
  year % 400 == 0 ? true : year % 4 == 0 && year % 100 != 0
end

months = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

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