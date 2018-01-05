class Number
    
    def initialize(x)
        @game_num = x
        @guess_count = 0
        @cheat = false
        @number = rand(100).to_i
        @number = @number.to_s
        
        puts "I have generated a random number for you to guess!"
    end

    def guess()
        
        print "What is your guess? > "
        guess = gets.chomp
        
        if @guess_count % 5 == 0 && !(@guess_count == 0)
            @guess_count += 1
            hint()
        elsif guess == "cheat" || guess == "c"
            @cheat = true
            puts "That's cheating! The number is #{@number}. Guess again."
            guess()
        elsif !(guess.scan(/\D/).empty?)
            puts "Please guess a number."
            guess()   
        elsif guess == @number
            @guess_count += 1
            win()
            again()
        elsif guess > @number
            @guess_count += 1
            puts "You guessed too high! Guess again."
            guess()
        elsif guess < @number
            @guess_count += 1
            puts "You guessed too low! Guess again."
            guess()
        else
            puts "Not sure how you broke it..."
            guess()
        end
    
    end
    
    def win()
        puts "You got it right!!"
        puts "It took you #{@guess_count} guesses!"
        if @cheat == true
            puts "It's easy when you cheat!"
        elsif @guess_count < 5
            puts "That didn't take long!"
        else
            puts "That's a lot of guesses..."
        end
    end
    
    def hint()
        if @number.to_i.even?
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
            game = Number.new(@game_num + 1)
            game.guess()
        else
            puts "You played #{@game_num} games!"
            puts "Goodbye!"
            exit(0)
        end
    end
end

game = Number.new(1)
game.guess()