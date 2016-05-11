def format_no_decimal(string)
  if string.length == 1
    ("0.0" + string).to_f
  elsif string.length == 2
    ("0." + string).to_f
  end
end

def format_with_decimal(string)
  if string.index('.') == 1
    string.slice!('.')
    ("0.0" + string).to_f
  elsif string.index('.') == 2
    string.slice!('.')
    ("0." + string).to_f
  end
end

def formatted_apr(string)
  if !string.include?('.')
    format_no_decimal(string)
  elsif string.include?('.')
    format_with_decimal(string)
  end
end

puts "How much is the total loan?"
loan_amount = ''
loop do
  loan_amount = gets.to_i
  if loan_amount > 0
    break
  else
    puts "Please enter a valid number (more then 0)"
  end
end

puts "Whats the Annual Percentage Rate (APR)? type 5 for 5%, 10.2 for 10.2%"
apr = ''
loop do
  apr = gets.chomp
  apr = formatted_apr(apr)
  if !apr.nil?
    break
  else
    puts "Please enter a number between 0 and 100"
  end
end

puts "How many years is the loan?"
duration_years = gets.to_i
interest_per_year = loan_amount * apr
# interest_per_mounth = interest_per_year / 12
total_interest = interest_per_year * duration_years
total_due = loan_amount + total_interest
total_per_year = total_due / duration_years
duration_mounths = duration_years * 12
total_per_mounth = total_per_year / 12

puts "apr: #{apr}"
puts "Duration in mounths: #{duration_mounths}"
puts "Payment per mounth: $#{total_per_mounth}"
