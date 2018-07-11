# comment
require 'yaml'
class DataManager
  def write_results(attempts, hint)
    
    username = gets.chomp
    results = './lib/results.yml'
    game_result = {result: {name: username, attempts_left: attempts, hint_available: hint}}.to_yaml
    File.open(results, 'a') { |file| file.write(game_result).to_yaml }
  end

  def view_results
    results = YAML.load_file('./lib/results.yml')
    p results
    results.each_value do |value|
      puts 'User: ' + value[:name].to_s + ', attempts left: ' + value[:attempts_left].to_s + ', hint available: ' + value[:hint_available].to_s
    end
  end
end
