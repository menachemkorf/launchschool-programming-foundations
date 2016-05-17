# question 1
statement = "The Flintstones Rock!"

10.times do |num|
  # puts (" " * num) + statement
end

# question 2

result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a

letters.each do |l|
  result[l] = statement.count(l) if statement.count(l) > 0
end

# question 3

# puts "the value of 40 + 2 is " + (40 + 2) => error

"the value of 40 + 2 is " + (40 + 2).to_s
"the value of 40 + 2 is #{40 + 2}"

# question 4

numbers = [1, 2, 3, 4]
numbers.each do |number|
  # p number
  numbers.shift(1)
end
# => 1, 3

numbers = [1, 2, 3, 4]
numbers.each do |number|
  # p number
  numbers.pop(1)
end
# => 1, 2

# question 5

def factors(number)
  dividend = number
  divisors = []
  while dividend > 0
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end

factors(6)

# question 6