require_relative 'game.rb'
require_relative 'interface.rb'
class ProcessingService

  include Interface

  def initialize
    @hint_available = true
    @code = generator
    @results_array = []
    @attempts = 2
    @data_manager = DataManager.new
  end

  def generator
    Array.new(4) { rand(1..6) }
  end

  def command(command_name)
    @command = method_list(command_name) unless command_name.match(/^[1-6]{4}$/)
    turn_processor(command_name)
  end

  def method_list(command)
    commands = { h: hint?, w: @data_manager.write_results(@attempts), r: @data_manager.view_results, p: Game::new_game}
  #  p commands[command]
    commands[command.to_sym]
  end

  def turn_processor(guess)
    p @code
    guess = guess.to_i.digits.reverse
    results_array = place_match(@code, guess)
    results_array = out_of_place_match(results_array, @code, guess)
    p results_array
    win?(results_array)
    attempt_used
    lost?
  end

  def place_match(code, guess)
    results_output = Array.new(4, ' ')
    code.zip(guess).each_with_index do |elements_by_their_place, index|
      if elements_by_their_place.first == elements_by_their_place.last
        results_output[index] = '+'
      end
    end
    results_output
  end

  def out_of_place_match(results_output, code, guess)
    matched_values = guess & code
    guess.each_with_index do |number, index|
        if matched_values.include?(number)
          results_output[index] = '-' unless results_output[index] == '+'
        end
    end
    results_output
  end

  def hint(code, compared_array)
    loop do
      @hint_index = code[rand(0..3)]
      @hint_value = code[@hint_index]
      break if compared_array[@hint_index] != '+'
    end
    hint_message(@hint_value, @hint_index)
  end

    def win?(compared)
    win_condition = Array.new(4, '+')
    return Game::win  unless win_condition != compared
  end

  def hint?
    if @hint_available && @results_array == nil
      @results_array = Array.new(4, ' ')
      hint(@code, @results_array)
      @hint_available = false
    elsif @hint_available
      hint(@code, @results_array)
      @hint_available = false
    else
      have_no_hints
    end
  end

  def attempt_used
    @attempts -= 1
  end

  def lost?
    return Game::lost unless @attempts > 0
    attempts_left(@attempts)
  end
end

