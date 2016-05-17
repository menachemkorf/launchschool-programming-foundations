h = {}
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

flintstones.each_with_index do |item, index|
  h[index] = item
end

p h