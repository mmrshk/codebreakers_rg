# comment
class DataManager
  def write_results(attempts, hint)
    game_result = []
    # username = gets.chomp
    username = 'u. s, r'
    results = './lib/results.yml'
    game_result.push(username).push(attempts).push(hint)
    File.open(results, 'a') { |file| file.write(game_result) }
    File.open(results, 'a') { |file| file.write("\n") }
  end

  def view_results
#    puts File.read('./lib/results.yml')
    results = File.open('./lib/results.yml')
    results.each_line do |line|
    #  puts "User #{line[0]} have finished game with #{line[1]} attempts left. Hint left: #{line[2]} "
    end
  end
end
