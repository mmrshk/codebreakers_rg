class CommandManager
require_relative 'game.rb'
require_relative 'menu.rb'

  def initialize
    @game = Game.new
    @manager = DataManager.new
  end

  def choice_processor(command_name)
    commands.dig(command_name.to_sym).call
  end

  def commands
    {
      p: -> { start_game },
      q: -> { exit_game },
      h: -> { show_hint },
      r: -> { read_results }
    }
  end

  def start_game
    @game.new_game
  end

  def exit_game
    exit
  end

  def read_results
    @manager.view_results
  end
end
