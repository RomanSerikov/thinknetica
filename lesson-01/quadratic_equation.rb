puts "Введите через пробел значения коэффициентов a, b и c:"
a, b, c = gets.chomp.split.map(&:to_f)

discr = b ** 2 - 4 * a * c

puts "Дискриминант: #{discr}."

if discr < 0
  puts "Корней нет."
elsif discr == 0
  x = (-b).fdiv 2 * a
  puts "Корень: x = #{x}."
else
  x1 = (-b + Math.sqrt(discr)).fdiv 2 * a
  x2 = (-b - Math.sqrt(discr)).fdiv 2 * a
  puts "Корни: x1 = #{x1}, x2 = #{x2}."
end