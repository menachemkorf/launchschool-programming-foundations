# input arr

# iterate over array with index
  # if index is fibonacci, return element

# get elements where index is fibonacci
require 'pry'

def fibonacci(num1, num2, limit=15)
  numbers = []
  while num1 <= limit do
    sum = num1 + num2
    numbers << num1
    num1 = num2
    num2 = sum
  end
  numbers
end

def fibonacci?(num)
  fibonacci(0,1,num).include?(num)
end

def fibonacci_elements(arr)
  selected_elements = []
  arr.each_with_index do |element, idx|
    selected_elements << element if fibonacci?(idx)
  end
  selected_elements
end

p fibonacci_elements(('a'..'z').to_a)