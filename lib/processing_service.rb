require_relative 'interface.rb'
class ProcessingService

  include Interface

#  def compare(code, guess)
#    results_output = Array.new(4, ' ')
#    code.zip(guess).each_with_index do |elements_by_their_place, index|
#      if elements_by_their_place.first == elements_by_their_place.last
#        results_output[index] = '+'
#      end
#      code.each_with_index do |_variable, ind|
#        if results_output[index] == ' ' && elements_by_their_place.last == code[ind]
#          results_output[index] = '-'
#        end
#      end
#    end
#    results_output
#  end

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
    guess.each_with_index do |_variable, index|
      if guess[index] == code.each { |number| number } && results_output[index] == ' '
        results_output[index] = '-'
      end
      results_output
    end
#    code.each_with_index do |_variable, ind|
#      if results_output[index] == ' ' && elements_by_their_place.last == code[ind]
#        results_output[index] = '-'
#      end
#      results_output
#    end  
  end

  def hint(code, compared_array)
    loop do
      @hint_index = code[rand(0..3)]
      @hint_value = code[@hint_index]
      break if compared_array[@hint_index] != '+'
    end
    hint_message(@hint_value, @hint_index)
  end

#  def end_game
#    loop do
#      num = gets.to_i
#      case num
#      when 1
#        @hint_available = true
#        @attempts = 5
#        new_game
#      when 2 then view_results
#      when 3 then write_results
#      when 4 then exit
#      else incorrect_entry
#      end
#    end 
#  end
end