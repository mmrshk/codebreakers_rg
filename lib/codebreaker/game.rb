require_relative 'processor.rb'
require_relative 'data_manager.rb'
require_relative 'interface.rb'
require_relative 'command_manager.rb'

# Comment
class Game < CommandManager
  include Interface
  WIN_CONDITION = Array.new(4, '+')
  YES = 'yes'.freeze

  def initialize
    @processor = Processor.new
    @manager = DataManager.new
  end

  def generator
    Array.new(4) { rand(1..6) }
  end

  def game_preparations
    @code = generator
    @attempts = 5
    @game_end = false
    @hint_avaliable = true
  end

  def new_game
    game_preparations
    turn_start_message
    loop do
      result = action_processor
      attempts
      win(result)
      break if game_end?
      lost
      break if game_end?
    end
    save_results?
  end

  def attempts
    @attempts = @processor.attempts_left
  end

  def win(result)
    return unless result == WIN_CONDITION
    win_game_message
    @game_end = true
  end

  def lost
    return unless @attempts.zero?
    lost_game_message
    @game_end = true
  end

  def game_end?
    @game_end
  end

  def action_processor
    command = gets.chomp
    choice_processor(command) unless command =~ /^[1-6]{4}$/
    @processor.turn_processor(@code, command)
    @processor.display_results
#  rescue
#    incorrect_entry_message
#    retry
  end

  def show_hint
    return have_no_hints_message unless @hint_avaliable == true
    @processor.hint_processor(@code)
    @hint_avaliable = false
  end

  # def exit_game
  #   exit
  # end

  def save_results?
    save_results_message
    choice = gets.chomp.downcase
    @manager.write_results(@attempts, @hint_avaliable) if choice == YES
  end

#  def commands
#    {
#     h: -> { show_hint },
#      q: -> { exit_game }
#    }
#  end
end
