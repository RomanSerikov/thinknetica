cart          = {}
cart_total    = 0
input_message = "Введите <название товара>, <цену за 1 шт> и <кол-во товара> через пробел.\nВведите <стоп>, чтобы закончить."

loop do
  puts input_message
  input = gets.chomp.split

  break if input == ["стоп"]

  product  = input[0].downcase
  price    = input[1].to_f
  quantity = input[2].to_f

  if cart.key?(product)
    puts "Такой товар уже есть. Принять новые значения цены и кол-ва? <да> <нет>"
    choice = gets.chomp
    if choice == "да"
      cart[product] = { price => quantity }
      puts "Товар #{product} успешно изменен."
    else
      puts "Товар #{product} остался без изменений."
    end
  else
    cart[product] = { price => quantity }
  end
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