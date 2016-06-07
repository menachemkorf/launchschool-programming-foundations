def reverse_text(text)
  text_arr = text.split('')
  reversed_text = []
  text.length.times do
    reversed_text.push(text_arr.pop)
  end
  reversed_text.join
end

p reverse_text("Hello world")
