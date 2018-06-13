require_relative 'interface.rb'
require_relative 'processing_service.rb'
require_relative 'menu.rb'
#comment
class Game

  include Interface

  def initialize
    @processing_service = ProcessingService.new
    @hint_available = true
    @code = []
    @results_array = []
  end

  def generator
    Array.new(4) { rand(1..6) }
  end

  def begining_game
    Menu::begin_game
  end

  def ending_game
    Menu::end_game
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
    lost_message
    ending_game
  end

  def win
    win_message
    ending_game
  end

  def win?(compared)
    win_condition = Array.new(4, '+')
    return unless win_condition == compared
    win
  end

  def hint?
    if @hint_available && @results_array == nil
      @results_array = Array.new(4, ' ')
      @processing_service.hint(@code, @results_array)
      @hint_available = false
    elsif @hint_available
    @processing_service.hint(@code, @results_array)
    @hint_available = false
    else
      have_no_hints
    end
  end

  def new_game
    @hint_available = true
    @attempts = 2
    p @code = generator
    loop do
      prompt_decision
      choice = gets.chomp
      choice
      case choice
      when /^[1-6]{4}$/
        choice = choice.to_i.digits.reverse
        @results_array = @processing_service.place_match(@code, choice)
        p @results_array
        @results_array = @processing_service.out_of_place_match(@results_array, @code, choice)
        p @results_array
#        p @results_array
        win?(@results_array)
        lost?
        attempt_used
      when 'h' then hint?
      when 'q' then exit
      else
        incorrect_entry
      end
    end
  end
end
