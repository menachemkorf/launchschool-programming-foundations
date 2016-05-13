def prompt(msg)
  puts "#{msg} >>"
end

def result(msg)
  puts "=> #{msg}"
end

def error(msg)
  puts "! #{msg}"
end

def valid_number?(input)
  input.to_f.to_s == input || input.to_i.to_s == input
end

def valid_apr?(input)
  valid_number?(input) && input.to_f >= 0 && input.to_f < 100
end

puts "Welcome to the Mortgage Calculator!"

loop do
  prompt "How much is the total loan?"
  loan_amount = ''
  loop do
    loan_amount = gets.to_f
    break unless loan_amount <= 0

    error "Invalid number"
    prompt "Please enter a valid number (more then 0)"
  end

  prompt "Whats the Annual Percentage Rate (APR)? type 5 for 5%, 10.2 for 10.2%"
  apr = ''
  loop do
    apr = gets.chomp
    if valid_apr?(apr)
      apr = apr.to_f / 100
      break
    else
      error "Invalid number"
      prompt "Please enter a number valid (between 0 and 100)"
    end
  end

  prompt "How many years is the loan?"
  duration_years = ''
  loop do
    duration_years = gets.to_f
    break unless duration_years <= 0

    error "Invalid number"
    prompt "Please enter a valid number (more then 0)"
  end

  puts "Calculating..."

  duration_months = duration_years * 12

  if apr > 0
    r = apr / 12
    monthly_payment = (r + r / ((1 + r)**duration_months - 1)) * loan_amount
  else
    monthly_payment = loan_amount / duration_months
  end

  result "Loan duration: #{duration_months.round} months"
  result "Monthly payments: $#{format('%.2f', monthly_payment)}"

  prompt "Another calculation? (y/n)"
  answer = ''
  loop do
    answer = gets.chomp.downcase
    if answer == 'y' || answer == 'n'
      break
    else
      error "Invalid option."
      prompt "Please enter a valid option (y/n)"
    end
  end
  break if answer == 'n'
end

puts "Thank you for using the Mortgage Calculator. Good bye!"
