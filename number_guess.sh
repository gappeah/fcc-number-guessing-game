#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Generate secret number between 1 and 1000
SECRET_NUMBER=$(( ( RANDOM % 1000 )  + 1 ))
echo $SECRET_NUMBER

# Initialize guesses
GUESSES=0

# Prompt for username
echo -e "Enter your username:"
read NAME

# Fetch user from database
USERNAME=$($PSQL "SELECT username FROM games WHERE username='$NAME'")

# If the username does not exist
if [[ -z $USERNAME ]]
then
  USERNAME=$NAME
  BEST_GAME=1000  # Initialize best_game to a high value for first-time users
  # Insert new user into the database with initial values
  echo $($PSQL "INSERT INTO games(username, games_played, best_game) VALUES ('$USERNAME', 1, 1000)")
  echo "Welcome, $USERNAME! It looks like this is your first time here."
else
  # Fetch games_played and best_game for existing user
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM games WHERE username='$USERNAME'")
  BEST_GAME=$($PSQL "SELECT best_game FROM games WHERE username='$USERNAME'")
  
  # Output the welcome back message
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  
  # Increment games_played for returning users
  ((GAMES_PLAYED++))
  echo $($PSQL "UPDATE games SET games_played=$GAMES_PLAYED WHERE username='$USERNAME'")
fi

# Start the guessing game
echo -e "Guess the secret number between 1 and 1000:"
while true
do
  read GUESS
  ((GUESSES++))
  
  # Check if guess is an integer
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo -e "That is not an integer, guess again:"
  else
    if [[ $GUESS -lt $SECRET_NUMBER ]]
    then
      echo -e "It's higher than that, guess again:"
    elif [[ $GUESS -gt $SECRET_NUMBER ]]
    then
      echo -e "It's lower than that, guess again:"
    else
      # Player guessed the correct number
      if [[ $GUESSES -lt $BEST_GAME ]]
      then
        echo $($PSQL "UPDATE games SET best_game=$GUESSES WHERE username='$USERNAME'")
      fi
      echo "You guessed it in $GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
      exit
    fi
  fi
done
