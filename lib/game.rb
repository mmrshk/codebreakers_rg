require_relative 'interface.rb'
require_relative 'processing_service.rb'
require_relative 'menu.rb'
#comment
class Game

  include Interface

  def initialize
    @processing_service = ProcessingService.new
  end

  def self.ending_game
    Menu::end_game
  end

  def self.lost
    Interface::lost_message
    ending_game
  end

  def self.win
    Interface::win_message
    ending_game
  end

  def new_game
    loop do
      prompt_decision
      choice = gets.chomp
      @processing_service.command(choice)
    end
  end
end
