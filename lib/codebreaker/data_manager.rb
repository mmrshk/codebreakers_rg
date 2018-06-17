class DataManager

  def write_results(attempts)
    username = gets.chomp
    results = './db/results.txt'
    File.open(results, 'a') { |file| file.write("#{username} finished game with #{attempts -1} attempts left \n") }
  end

  def view_results
    File.open('./db/results.txt', 'r') do |f|
      f.each_line do |line|
        puts line
      end
    end
  end
end