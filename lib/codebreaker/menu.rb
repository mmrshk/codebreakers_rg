require_relative 'game.rb'
require_relative 'data_manager.rb'
require_relative 'interface.rb'
# comment
class Menu < CommandManager
  include Interface
  def initialize
    @game = Game.new
    @manager = DataManager.new
  end

  def game_menu
    loop do
      main_menu_message
      choice = gets.chomp
      choice_processor(choice)
    end
  end
end
