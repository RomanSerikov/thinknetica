puts "Как Вас зовут?"
name = gets.chomp
puts "Какой у Вас рост?"
height = gets.chomp.to_i

perfect_weight = height - 110
message = (perfect_weight < 0) ? "Ваш вес уже оптимальный" : "Ваш идеальный вес #{perfect_weight}"

puts "#{name}, #{message}."