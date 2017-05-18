cart       = {}
cart_total = 0

puts "Введите <название товара>, <цену за 1 шт> и <кол-во товара> через пробел."
puts "Введите <стоп>, чтобы закончить."

loop do
  input = gets.chomp.split

  break if input == ["стоп"]

  product  = input[0]
  price    = input[1].to_f
  quantity = input[2].to_f

  cart[product] = { price => quantity }
end

if cart.empty? 
  puts "В корзине нет покупок."
else
  puts "#{cart}"

  cart.each do |product, info|
    total = info.flatten.reduce(&:*)
    cart_total += total

    puts "Итого за #{product}: #{total}." 
  end

  puts "Сумма всех покупок: #{cart_total}."
end