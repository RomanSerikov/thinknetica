puts "Введите основание треугольника"
base = gets.chomp.to_f
puts "Введите высоту треугольника"
height = gets.chomp.to_f

area = 0.5 * base * height
puts "Площадь треугольника: #{area}."