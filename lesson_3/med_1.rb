# question 1

statement = "The Flintstones Rock!"

10.times do |num|
  puts (" " * num) + statement
end

# question 2

result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a

letters.each do |l|
  result[l] = statement.count(l) if statement.count(l) > 0
end

p result

# question 3

# "the value of 40 + 2 is " + (40 + 2) => error

puts "the value of 40 + 2 is " + (40 + 2).to_s
puts "the value of 40 + 2 is #{40 + 2}"

# question 4

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end
# => 1, 3

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
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

def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end # => mutates caller

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end # => does not mutate caller

max_buffer_size = 5
buffer = %w(Mike Paul Abe Neil Ryan)

rolling_buffer2(buffer, max_buffer_size, "Alex")
p buffer
rolling_buffer1(buffer, max_buffer_size, "Max")
p buffer

# question 7

LIMIT = 15

def fib(first_num, second_num)
  while second_num < LIMIT
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1)
puts "result is #{result}"

# question 8

words = "the quick brown fox jumped over the lazy dog"
words = words.split.map { |word| word.capitalize }.join(' ')

# question 9

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |key, value|
  case value["age"]
  when 0..17
    value["age_group"] = "kid"
  when 18..64
    value["age_group"] = "adult"
  else
    value["age_group"] = "senior"
  end
end
p munsters
