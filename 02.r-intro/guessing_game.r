# get a random number for the user to guess
# using the built-in function sample()
rand <- sample(1:20, 1)

# start the game
cat("Guess a number between 1 and 20.\n")

# something that will start the loop
guess <- -1

# while the guess is not equal to the number, ask them to guess again
while (guess != rand) {
    guess <- readline(prompt="Enter your guess:") # get input using readline()
    guess <- as.integer(unlist(strsplit(guess, ","))) # make sure it's an integer
    
    if (guess < rand) { # if the guess is too high, tell the user and pick again
        cat("Too low. Guess again.\n")
    }
    else if (guess > rand) {
        cat("Too high. Guess again.\n")
    }    
}

# if they get it right, let them know!
cat("Congratulations!", guess, "is right!\n")
