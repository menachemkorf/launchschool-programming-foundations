def palindrome(str)
  str_arr = str.split('')
  reversed_arr = []
  str.length.times do
    reversed_arr << str_arr.pop
  end
  reversed_word = reversed_arr.join
  true if reversed_word == str
end

p palindrome("hello")
p palindrome("anna")