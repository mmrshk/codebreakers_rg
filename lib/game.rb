#comment
class Game
  require_relative 'interface.rb'
  include Interface
  @hint_available = true
  def initialize
    @attempts = 5
    @hint_available = true
    @code = []
    @reults_array = []
  end

  def generator
    code = []
    4.times { code.push(rand(1..6)) }
    code
  end

  def guess
    guess_code_message
    gets.to_i.digits.reverse
  end

  def compare(generated, guess)
    results_output = Array.new(4, ' ')
    generated.zip(guess).each_with_index do |elements_by_their_place, index|
      if elements_by_their_place.first == elements_by_their_place.last
        results_output[index] = '+'
      end
      generated.each_with_index do |_variable, ind|
        if results_output[index] == ' ' && elements_by_their_place.last == generated[ind]
          results_output[index] = '-'
        end
      end
    end
    results_output
  end

  def attempt_used
    @attempts -= 1
  end

  def lost?
    if @attempts > 0
      attempts_left(@attempts)
    else
      lost
    end
  end

  def lost
    loop do
      lost_message
      num = gets.to_i
      case num
      when 1
        @hint_available = true
        @attempts = 5
        new_game
      when 2 then view_results
      when 3 then exit
      else
        incorrect_entry
      end
    end
  end

  def write_results
    your_name
    username = gets.chomp
    results = 'results.txt'
    File.open(results, 'a') { |file| file.write("#{username} finished game with #{@attempts -1} attempts left \n") }
  end

  def view_results
    File.open('results.txt', 'r') do |f|
      f.each_line do |line|
        puts line
      end
    end
  end

  def win
    loop do
      win_message
      num = gets.to_i
      case num
      when 1
        @hint_available = true
        @attempts = 5
        new_game
      when 2 then view_results
      when 3 then write_results
      when 4 then exit
      else incorrect_entry
      end
    end
  end

  def win?(compared)
    win_condition = Array.new(4, '+')
    return unless win_condition == compared
    win
  end

  def process_hint
    hint(@code, @reults_array)
    @hint_available = false
  end

  def hint?
    if @hint_available && @reults_array == nil
      @reults_array = Array.new(4, ' ')
      process_hint
    elsif @hint_available
      process_hint
    else
      have_no_hints
    end
  end

  def hint(generated_code, compared_array)
    loop do
      @hint_index = generated_code[rand(0..3)]
      @hint_value = generated_code[@hint_index]
      break if compared_array[@hint_index] != '+'
    end
    hint_message(@hint_value, @hint_index)
  end

  def new_game
    p @code = generator
    loop do
      prompt_decision
      choice = gets.to_i
      case choice
      when 1
        @reults_array = compare(@code, guess)
        p @reults_array
        win?(@reults_array)
        lost?
        attempt_used
      when 2 then hint?
      else
        incorrect_entry
      end
    end
  end
end
