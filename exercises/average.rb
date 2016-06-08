def average(numbers)
  numbers.inject { |acc, num| acc + num } / numbers.length
end

p average([1, 45, 3, 98, 22, 10])