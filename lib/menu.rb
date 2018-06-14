require_relative 'interface.rb'
require_relative 'game.rb'
require_relative 'data_manager.rb'
require_relative 'processing_service.rb'

class Menu

  include Interface

  def initialize
    @game = Game.new
    @data_manager = DataManager.new
    @processing_service = ProcessingService.new
  end

  def begin_game
    loop do
      begin_game_message
      choice = gets.chomp
#      @processing_service.command(choice)
      case choice
        when '1' then @game.new_game
        when 'r' then @data_manager.view_results
        when 'q' then exit
       else
         incorrect_entry
      end
    end
  end

  def self.end_game
    @game = Game.new
    @data_manager = DataManager.new
    loop do
      Interface::end_game_message
      num = gets.chomp
      case num
      when '1' then @game.new_game
      when 'r' then @data_manager.view_results
      when 'w' then @data_manager.write_results(@game.instance_variable_get(:@attempts))
      when 'q' then exit
      else 
        incorrect_entry
      end
    end 
  end
    
end