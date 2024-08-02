import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'generated/assets.dart';


class LudoGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ludo Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Board()),
            Dice(),
          ],
        ),
      ),
    );
  }
}

class Board extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.ludoLudoBoard),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(15, (i) => LudoRow(i)),
          ),
        ),
      ),
    );
  }
}

class LudoRow extends StatelessWidget {
  final int index;
  LudoRow(this.index);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: List.generate(15, (i) => LudoCell(i, index)),
      ),
    );
  }
}

class LudoCell extends StatelessWidget {
  final int x;
  final int y;
  LudoCell(this.x, this.y);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: Stack(
          children: [
            // Add tokens here if any
          ],
        ),
      ),
    );
  }
}

class Dice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dice = Provider.of<DiceModel>(context);
    final img = Image.asset(
      "assets/${dice.diceOne}.png",
      gaplessPlayback: true,
      fit: BoxFit.fill,
    );

    return Card(
      elevation: 10,
      child: Container(
        height: 40,
        width: 40,
        child: GestureDetector(
          onTap: () => dice.generateDiceOne(),
          child: img,
        ),
      ),
    );
  }
}

class DiceModel with ChangeNotifier {
  int diceOne = 1;

  int get diceOneCount => diceOne;

  void generateDiceOne() {
    diceOne = Random().nextInt(6) + 1;
    notifyListeners();
  }
}

class TokenWidget extends StatelessWidget {
  final Token token;
  final List<double> dimensions;
  TokenWidget(this.token, this.dimensions);

  Color _getColor() {
    switch (this.token.type) {
      case TokenType.green:
        return Colors.green;
      case TokenType.yellow:
        return Colors.yellow[900]!;
      case TokenType.blue:
        return Colors.blue[600]!;
      case TokenType.red:
        return Colors.red;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    final dice = Provider.of<DiceModel>(context);
    return AnimatedPositioned(
      duration: Duration(milliseconds: 100),
      left: dimensions[0],
      top: dimensions[1],
      width: dimensions[2],
      height: dimensions[3],
      child: GestureDetector(
        onTap: () {
          gameState.moveToken(token, dice.diceOne);
        },
        child: Card(
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getColor(),
              boxShadow: [
                BoxShadow(
                  color: _getColor(),
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum TokenType { green, yellow, blue, red }
enum TokenState { initial, home, normal, safe, safeinpair }

class Position {
  final int x;
  final int y;
  Position(this.x, this.y);
}

class Token {
  final TokenType type;
  Position tokenPosition;
  TokenState tokenState;
  int positionInPath;
  final int id;

  Token(this.type, this.tokenPosition, this.tokenState, this.id, {this.positionInPath = 0});
}

class GameState with ChangeNotifier {
  final List<Token> gameTokens = [
    Token(TokenType.green, Position(2, 2), TokenState.initial, 0),
    Token(TokenType.green, Position(2, 3), TokenState.initial, 1),
    Token(TokenType.green, Position(3, 2), TokenState.initial, 2),
    Token(TokenType.green, Position(3, 3), TokenState.initial, 3),
    // Add similar initial positions for other colors
  ];

  List<Position> greenPath = [
    Position(6, 1), Position(6, 2), Position(6, 3), Position(6, 4),
    // Add the full path positions
  ];

  void moveToken(Token token, int steps) {
    Position destination;
    int pathPosition;
    if (token.tokenState == TokenState.home) return;
    if (token.tokenState == TokenState.initial && steps != 6) return;
    if (token.tokenState == TokenState.initial && steps == 6) {
      destination = greenPath[0]; // Change accordingly for different colors
      pathPosition = 0;
      token.tokenState = TokenState.normal;
      _updateBoardState(token, destination, pathPosition);
    } else {
      int step = token.positionInPath + steps;
      if (step >= greenPath.length) return;
      destination = greenPath[step];
      pathPosition = step;
      var cutToken = _updateBoardState(token, destination, pathPosition);
    }
    notifyListeners();
  }

  void _updateBoardState(Token token, Position destination, int pathPosition) {
    // Update token position and handle cut/kill logic
    token.tokenPosition = destination;
    token.positionInPath = pathPosition;
  }
}
