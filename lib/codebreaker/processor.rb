require_relative 'interface.rb'
# comment
class Processor
  RESULTS_OUTPUT = Array.new(4, ' ')
  def initialize
    @attempts = 3
  end

  include Interface
  def turn_processor(code, guess)
    p code
    guess = guess.to_i.digits.reverse
    results_array = place_match(code, guess)
    attempt_used
    @results_array = out_of_place_match(results_array, code, guess)
  end

  def display_results
    p @results_array
  end

  def place_match(code, guess)
    results_output = RESULTS_OUTPUT
    code.zip(guess).each_with_index { |elements_by_their_place, index|
       results_output[index] = '+' if elements_by_their_place.uniq! }
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

  def hint_processor(code)
    number = code.sample
    hint_message(number, code.index(number))
  end

  def attempt_used
    @attempts -= 1
  end

  def attempts_left
    @attempts
  end
end
