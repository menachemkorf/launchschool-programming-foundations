# question 1

if false
  greeting = "hello world"
end

greeting  # => nil

# question 2

greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings  #  => "hi there"

def generate_UUID
  characters = []
  (1..9).each { |digit| characters << digit.to_s }
  ('a'..'f').each { |digit| characters << digit }

  uuid = ""
  sections = [8, 4, 4, 4, 12]

  sections.each_with_index do |section, index|
    section.times { |section| uuid += characters.sample }
    uuid += "-" unless sections.length - 1 == index
  end
  uuid
end
generate_UUID

# question 5

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false unless dot_separated_words.length == 4

  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false unless is_a_number?(word)
  end
  return true
end
