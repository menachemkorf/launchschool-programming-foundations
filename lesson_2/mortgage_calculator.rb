def valid_number?(input)
  input.to_f.to_s == input || input.to_i.to_s == input
end

def format_no_decimal(input)
  if input.length == 1
    ("0.0" + input).to_f
  elsif input.length == 2
    ("0." + input).to_f
  end
end

def format_with_decimal(input)
  if input.index('.') == 1
    input.slice!('.')
    ("0.0" + input).to_f
  elsif input.index('.') == 2
    input.slice!('.')
    ("0." + input).to_f
  end
end

def formatted_apr(input)
  if !valid_number?(input)
    nil
  elsif !input.include?('.')
    format_no_decimal(input)
  elsif input.include?('.')
    format_with_decimal(input)
  end
end

puts "Welcome to the Mortgage Calculator!"

loop do
  puts "How much is the total loan?"
  loan_amount = ''
  loop do
    loan_amount = gets.to_i
    break unless loan_amount <= 0

    puts "Please enter a valid number (more then 0)"
  end

  puts "Whats the Annual Percentage Rate (APR)? type 5 for 5%, 10.2 for 10.2%"
  apr = ''
  loop do
    apr = gets.chomp
    apr = formatted_apr(apr)

    break unless apr.nil?

    puts "Please enter a number between 0 and 100"
  end

  puts "How many years is the loan?"
  duration_years = ''
  loop do
    duration_years = gets.to_i
    break unless duration_years <= 0

    puts "Please enter a valid number (more then 0)"
  end

  puts "Calculating..."

  duration_months   = duration_years * 12
  interest_per_year = loan_amount * apr
  total_interest    = interest_per_year * duration_years
  total_due         = loan_amount + total_interest
  total_per_year    = total_due / duration_years
  total_per_month   = total_per_year / 12

  puts "Loan duration: #{duration_months} months"
  puts "Monthly payments: $#{total_per_month}"

  puts "Another calculation?(y/n)"
  answer = ''

  loop do
    answer = gets.chomp.downcase
    if answer == 'y' || answer == 'n'
      break
    else
      puts "That's not a valid option."
    end
  end
  break if answer == 'n'
end

puts "Thank you for using the Mortgage Calculator. Good bye!"
