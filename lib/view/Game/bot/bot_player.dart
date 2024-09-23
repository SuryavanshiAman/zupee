import 'dart:async';
import 'dart:math';

class BotPlayer {
  final String name;
  List<int> pawnsPositions = [0, 0, 0, 0]; // Initial positions of the bot's pawns

  BotPlayer({required this.name});

  // Function to simulate the bot rolling the dice
  int rollDice() {
    Random random = Random();
    int diceValue = random.nextInt(6) + 1;
    print('$name rolled a $diceValue');
    return diceValue;
  }

  // Function to decide which pawn to move based on a dice roll
  int selectPawnToMove(List<int> movablePawns) {
    // For simplicity, just pick the first movable pawn
    return movablePawns.isNotEmpty ? movablePawns.first : -1;
  }

  // Function to move the selected pawn
  void movePawn(int pawnIndex, int steps) {
    if (pawnIndex >= 0 && pawnIndex < pawnsPositions.length) {
      pawnsPositions[pawnIndex] += steps;
      print('$name moved pawn $pawnIndex to position ${pawnsPositions[pawnIndex]}');
    }
  }

  // Function to check which pawns can move (assuming you need a 6 to start moving from home)
  List<int> getMovablePawns(int diceValue) {
    List<int> movablePawns = [];
    for (int i = 0; i < pawnsPositions.length; i++) {
      if (pawnsPositions[i] > 0 || diceValue == 6) {
        movablePawns.add(i);
      }
    }
    return movablePawns;
  }

  // Bot takes its turn: rolls dice, selects pawn, and moves it
  void takeTurn() {
    int diceValue = rollDice();
    List<int> movablePawns = getMovablePawns(diceValue);
    if (movablePawns.isNotEmpty) {
      int selectedPawn = selectPawnToMove(movablePawns);
      movePawn(selectedPawn, diceValue);
    } else {
      print('$name cannot move any pawns');
    }
  }
}


// Assuming you have other players, including bots
List<BotPlayer> players = [
  BotPlayer(name: 'Bot 1'),
  BotPlayer(name: 'Bot 2'),
  // Add more bot players or human players here
];

// Current turn tracking
int currentPlayerIndex = 0;

void nextTurn() {
  if (players.isNotEmpty) {
    BotPlayer currentPlayer = players[currentPlayerIndex];

    // If it's a bot, make the bot play
    if (currentPlayer is BotPlayer) {
      currentPlayer.takeTurn();
    }

    // Move to the next player
    currentPlayerIndex = (currentPlayerIndex + 1) % players.length;
  }
}

// Game loop or event-driven system to trigger turns
void startGame() {
  Timer.periodic(Duration(seconds: 2), (timer) {
    nextTurn();
  });
}

void main() {
  // Start the game loop
  startGame();
}
