def prime?(number)
  (2..(number-1)).each do |divisor|
    return false if number % divisor == 0
  end
  true
end

def prime(start, finish)
  (start..finish).to_a.select do |number|
    prime?(number)
  end
end

p prime(1, 20)