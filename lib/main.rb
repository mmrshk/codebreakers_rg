class Cb
  attr_accessor :store
  @hint_available = true
  def initialize
    @@store =[]
    @attempts = 5
    @hint_available = true
    @code = []
    @b
  end

  def generator
    @code = []
    @@store = 4.times {@code.push(rand(1..6))}
    p @code
  end

  def guess
    p "enter code"
    attempt = gets.to_i.digits.reverse
  end

  def compare(generated, guess)
    arr = Array.new(4, " ")
    generated.zip(guess).each_with_index do |elements_by_their_place, index|
      if elements_by_their_place.first == elements_by_their_place.last
        arr[index] = "+"
      end
      generated.each_with_index do |_variable, ind|
        if arr[index] == " " && elements_by_their_place.last == generated[ind]
          arr[index] = "-"
        end
      end
    end
    arr
  end

  def attempt_used
    @attempts -= 1
  end

  def lost?
    if @attempts > 0
      puts "Number of attempts left: #{@attempts}"
    else
      puts "You lost a game"
      lost
    end
  end

  def lost
    puts "Please select:
1 - Play again
2 - View results
3 - exit"
    num = gets.to_i
    case num
      when 1
        @hint_available = true
        @attempts = 5
        new_game
      when 2
        view_results
      when 3
        exit
      else
        puts "Please enter correct number"
    end
  end

  def write_results
    puts "Enter your name"
    username = gets
    results = "results.txt"
    File.open(results, 'a') { |file| file.write("#{username} finished game with #{@attempts -1} left \n") }
  end

    def view_results
        File.open("results.txt", "r") do |f|
            f.each_line do |line|
                puts line
            end
        end
    end

    def win
        puts "Please select:
1 - Play again
2 - View results
3 - Write your result
4 - exit"
        num = gets.to_i
        case num
            when 1
                @hint_available = true
                @attempts = 5
                new_game
            when 2
                view_results
            when 3
                write_results
            when 4
                exit
            else
                puts "Please enter correct number"
            end
    end
    def win?(compared)
        arr = ["+", "+", "+","+"]
        if compared == arr 
            puts "You win"  
            win  
        end
    end

    def hint?
        if @hint_available && @b == nil
           @b = [" ", " ", " ", " "] 
           hint(@code, @b)
           @hint_available = false
        elsif @hint_available
           hint(@code, @b)
           @hint_available = false
           p @hint_available
        else p "You dont have hints"
        end
    end

    def hint(generated_code, compared_array)
        loop do
            @hint_index = generated_code[rand(0..3)]
            @hint_value = generated_code[@hint_index]
            break if compared_array[@hint_index] != "+"
        end
        puts "Number #{@hint_value} is on position #{@hint_index + 1}"  
    end

    def new_game
        p @code = generator
        loop do
            puts "1 - Enter code
2 - Get a hint"
            choice = gets.to_i
            case choice
                when 1
                @b = compare(@code, guess)
                p @b
                p win?(@b)
                p attempt_used
                p lost?
                when 2
                hint?
                else
                puts "Please enter 1 or 2"
            end
        end
    end
end

#a = Cb.new
# a.compare([1,2,3,4], [1,2,3,4])
# p a.compare([1,2,3,1], [1,3,7,1])
#a.hint([1,2,3,1], ["+"," "," ","+"])
