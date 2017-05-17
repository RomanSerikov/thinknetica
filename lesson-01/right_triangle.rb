puts "Введите значения 3 сторон треугольника через пробел:"
sides = gets.chomp.split.map(&:to_f).sort


def test_triangle(sides)
  
  message         = []
  error_message   = "Треугольник с такими значениями сторон не может существовать."
  triangle_exists = sides[0] + sides[1] > sides[2]

  return error_message unless triangle_exists && sides.all? { |side| side > 0 } && sides.size == 3

  message << "прямоугольный"  if sides[0] ** 2 + sides[1] ** 2 == sides[2] ** 2
  message << "равнобедренный" if sides[0] == sides[1]
  message << "равносторонний" if sides.uniq.size == 1

  "Треугольник #{message.join(', ')}."
end

puts test_triangle(sides)