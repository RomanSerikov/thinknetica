puts "Введите через пробел значения коэффициентов a, b и c:"
a, b, c = gets.chomp.split.map(&:to_i)

discr = b ** 2 - 4 * a * c

puts "Дискриминант: #{discr}"

if discr < 0
  puts "Корней нет."
elsif discr == 0
  puts "x = #{(-b).fdiv  2 * a}"
else
  puts "x1 = #{(-b + Math.sqrt(discr)).fdiv 2 * a}"
  puts "x2 = #{(-b - Math.sqrt(discr)).fdiv 2 * a}"
end