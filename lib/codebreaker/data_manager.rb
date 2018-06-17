class DataManager

  def write_results(attempts)
    username = gets.chomp
    results = './lib/results.yml'
    File.open(results, 'a') { |file| file.write("#{username} finished game with #{attempts -1} attempts left \n") }
  end

  def view_results
    File.open('./lib/results.yml', 'r') do |f|
      f.each_line do |line|
        puts line
      end
    end
  end
end