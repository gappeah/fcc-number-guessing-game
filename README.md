# Number Guessing Game

This project is part of the FreeCodeCamp Relational Database certification. The objective was to build a PostgreSQL database to store user information and game results, as well as create a Bash script to handle the game logic and interact with the database.

## Project Structure

- **Database**: The database is managed using PostgreSQL.
- **Script**: A Bash script (`number_guess.sh`) was created to interact with the database by allowing users to play a number guessing game.

### Files

- `number_guess.sql`: Contains SQL commands to create the database, including tables for users and their game results.
- `number_guess.sh`: A Bash script to play the number guessing game, store user data, and track game results.

## Database Schema
![diagram-export-09-09-2024-16_32_56](https://github.com/user-attachments/assets/b4a9aa87-59c4-4884-a45c-edd4d3489539)

The database consists of the following tables:

### `users` Table

| Column Name | Data Type    | Constraints      |
| ----------- | ------------ | ---------------- |
| `user_id`   | SERIAL       | PRIMARY KEY      |
| `username`  | VARCHAR(20)  | UNIQUE, NOT NULL |

### `games` Table

| Column Name      | Data Type | Constraints                           |
| ---------------- | --------- | ------------------------------------- |
| `game_id`        | SERIAL    | PRIMARY KEY                           |
| `number_guesses` | INTEGER   | NOT NULL                              |
| `user_id`        | INTEGER   | REFERENCES `users(user_id)`            |

## Usage

### Prerequisites

- **PostgreSQL**: Ensure PostgreSQL is installed and running on your machine. Connect to the database using:

  ```bash
  psql --username=freecodecamp --dbname=number_guess
  ```

- **Database Setup**: The database should be created and populated using the provided `number_guess.sql` file.

### Running the Script

The `number_guess.sh` script allows users to play the number guessing game and saves the results to the database. To run the script:

```bash
./number_guess.sh
```

### Game Play Instructions

1. **Enter Username**: The script will prompt you to enter your username. If it is your first time, the username will be added to the `users` table.
   - If you are a returning user, the script will display the number of games you have played and your best game result (least number of guesses).
  
2. **Guess the Secret Number**: The script will randomly generate a number between 1 and 1000. You will be prompted to guess the number.
   - If your guess is too high or too low, you will be prompted to try again.
   - The game continues until you correctly guess the number.

3. **Save Game Results**: Once you guess the number, the script will tell you how many attempts it took, and the result will be saved to the database.

### Example Gameplay

```bash
Enter your username:
JohnDoe

Welcome back, JohnDoe! You have played 5 games, and your best game took 3 guesses.

Guess the secret number between 1 and 1000:
500
It's lower than that, guess again:
250
It's higher than that, guess again:
375
It's lower than that, guess again:
312
You guessed it in 4 tries. The secret number was 312. Nice job!
```

### Database Queries

The following information is stored in the database:
- **Usernames**: Stored in the `users` table.
- **Game Results**: Stored in the `games` table, tracking how many guesses each game took and which user played the game.

## Project Completion

### Git Repository

The project folder was initialized as a Git repository:

```bash
git init
```

The repository was ensured to have a `main` branch with at least five commits, using conventional prefixes like `fix:`, `feat:`, `refactor:`, etc.

### Bash Script

The `number_guess.sh` script was developed to handle user input, generate random numbers, and store game results in the database.

## Installation

1. Clone this repository.
2. Set up the database:
   - Log in to PostgreSQL:
     ```bash
     psql --username=freecodecamp --dbname=postgres
     ```
   - Run the SQL commands in `number_guess.sql` to create and populate the database:
     ```sql
     \i number_guess.sql
     ```
3. Make sure the `number_guess.sh` script has execution permissions:
   ```bash
   chmod +x number_guess.sh
   ```

4. Run the script as described above.
