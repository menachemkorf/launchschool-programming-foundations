def pangram?(str)
  str = str.downcase
  ('a'..'z').each do |letter|
    return false unless str.include?(alpha)
  end
  true
end

p pangram?("Hello world")
p pangram?("The quick brown fox jumps over the lazy dog.")