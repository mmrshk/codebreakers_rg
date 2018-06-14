module Interface
  def prompt_decision
    puts "Enter 4 1-6 digits or:
h - get a hint
q - exit game"
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

  def begin_game_message
    puts "Please select:
p - Play game
r - Write your result
q - exit"
  end

  def self.end_game_message
  puts "Please select:
p - Play again
w - Write results
r - Read results
q - exit"
  end

  def self.win_message
    puts 'Congratulations! You won the game!'
  end

  def incorrect_entry
    puts 'Please enter correct number'
  end

  def self.lost_message
    puts "Sorry, you lost"
  end
end
