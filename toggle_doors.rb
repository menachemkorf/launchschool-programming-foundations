def initialize_doors(numbers, doors)
  numbers.each do |num|
    doors << false
  end
end

def toogle_doors!(doors)
  (1..100).each do |divisor|
    doors.each_with_index { |door, idx| doors[idx] = !door if (idx + 1) % divisor == 0}
  end
end

doors = []
initialize_doors(1..100, doors)
toogle_doors!(doors)

doors.each_with_index { |door, idx| puts "Door #{idx+1} is #{door ? :open : :closed}." }
