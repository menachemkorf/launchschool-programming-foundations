puts "What's the first number?"
number1 = gets.to_f

puts "What's the second number?"
number2 = gets.to_f

puts "What operation should I perform? 1) add 2) subtract 3) multiply 4) divide"
operator = gets.chomp

if operator == '1'
  result = number1 + number2
elsif operator == '2'
  result = number1 - number2
elsif operator == '3'
  result = number1 * number2
elsif operator == '4'
  result = number1 / number2
end

puts "The result is #{result.to_s}"