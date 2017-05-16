puts "Введите значения 3 сторон треугольника через пробел:"
sides = gets.chomp.split.map(&:to_f).sort

message = []

message << "прямоугольный"  if sides[0] ** 2 + sides[1] ** 2 == sides[2] ** 2
message << "равнобедренный" if sides[0] == sides[1]
message << "равносторонний" if sides.uniq.size == 1

triangle_exists = (sides[0] + sides[1] > sides[2]) && 
                  (sides[0] + sides[2] > sides[1]) && 
                  (sides[1] + sides[2] > sides[0])

message = ["не может существовать с такими значениями сторон"] unless (triangle_exists &&
                                                                       sides.all? { |side| side > 0 } && 
                                                                       sides.size == 3)

puts "Треугольник #{message.join(', ')}."