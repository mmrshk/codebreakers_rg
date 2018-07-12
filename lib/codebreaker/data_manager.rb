require 'yaml'
# comment
class DataManager
  include Interface
  def write_results(attempts, hint)
    your_name
    username = gets.chomp
    game_result = { username: username, attempts_left: attempts, hint_available: hint}
    path = './lib/results.yml'
    data = YAML.load_file path
    data[:results] << game_result
    file = File.open(path, 'w')
    file.write(data.to_yaml)
    file.close
  end

  def view_results
    results = YAML.load_file('./lib/results.yml')
    results[:results].each do |result|
      result_output(result[:username], result[:attempts_left], result[:hint_available])
    end
  end
end
