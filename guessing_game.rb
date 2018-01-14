class GuessingGame

  @@game_tracker = []

    def initialize()
        @game_info = {
          guess_count: 0,
          cheat: false,
          number: rand(100).to_i,
          hint: false
        }

        puts "I have generated a random number for you to guess!"
    end

    def guess()
        if @game_info[:guess_count] == 5 && @game_info[:hint] == false
          hint()
        end

        print "What is your guess? > "
        guess = gets.chomp

        if guess =~ /cheat/ || guess == "c" #If it matches cheat then do cheat
          @game_info[:cheat] = true
          puts "That's cheating! The number is #{@game_info[:number]}. Guess again."
          guess()
        elsif guess.scan(/\D/).empty? #If it is all digits run test, move please guess to catch-all
          guess = guess.to_i
          @game_info[:guess_count] += 1
          test(guess)
        else
          puts "Please guess a number."
          guess()
        end
    end

    def test(guess)
        if guess == @game_info[:number]
          win()
        elsif guess > @game_info[:number]
          puts "You guessed too high! Guess again."
          guess()
        elsif guess < @game_info[:number]
          puts "You guessed too low! Guess again."
          guess()
        end
    end

    def win()
        puts "You got it right!!"
        puts "It took you #{@game_info[:guess_count]} guesses!"
        if @game_info[:cheat] == true
            puts "It's easy when you cheat!"
        elsif @game_info[:guess_count] < 5
            puts "That didn't take long!"
        else
            puts "That's a lot of guesses..."
        end
        @@game_tracker << @game_info
        again()
    end

    def hint(number = @game_info[:number])
      @game_info[:hint] = true

      if number.even?
          puts "The number is even!"
          guess()
      else
          puts "The number is odd!"
          guess()
      end
    end

    def again()
        print "Would you like to play again? Yes/No > "
        again = gets.chomp
        if again =~ /yes/i
            game = GuessingGame.new()
            game.guess()
        else
            puts "You played #{@@game_tracker.length} games!"
            print "Would you like to see how you did? Yes/No > "
            track = gets.chomp
            tracker(track)
        end
    end

    def tracker(track)
        if track =~ /yes/i
          @@game_tracker.each_with_index do |game_info, index|
            puts "Game #{index + 1}: #{game_info}"
          end
          puts "Goodbye!"
          exit(0)
        else
          puts "Goodbye!"
          exit(0)
        end
    end

end

game = GuessingGame.new()
game.guess()
