fibonacci = [0 , 1]

for i in (2..100) do
  current_num = fibonacci[i - 1] + fibonacci[i - 2]
  current_num > 100 ? break : fibonacci << current_num
end