module Interface
  def prompt_decision
    puts "1 - Enter code
2 - Get a hint"
  end

  def guess_code_message
    puts 'enter code'
  end

  def attempts_left(attempts)
    puts "Number of attempts left: #{attempts}"
  end

  def your_name
    puts 'Enter your name'
  end

  def hint_message(code_number_value, code_number_index)
    puts "Number #{code_number_value} is on position #{code_number_index + 1}"
  end

  def have_no_hints
    puts 'You dont have hints'
  end

  def win_message
    puts "Congratulations! You won the game!
Please select:
1 - Play again
2 - View results
3 - Write your result
4 - exit"
  end

  def incorrect_entry
    puts 'Please enter correct number'
  end

  def lost_message
    puts "Sorry, you lost
Please select:
1 - Play again
2 - View results
3 - exit"
  end
end