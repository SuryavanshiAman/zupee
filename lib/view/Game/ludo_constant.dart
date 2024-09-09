import 'package:flutter/material.dart';

enum LudoPlayerType {
  blue,
  red,
  green,
  yellow,

}

enum LudoGameState { throwDice, pickPawn, moving, finish}

///Ludo colors constant class
class LudoColor {
  static const Color blue = Color(0xFF4a5fd);
  static const Color red = Color(0xffd94646);
  static const Color green = Color(0xFF1aaa30);
  static const Color yellow = Color(0xffeac550);

}

///Ludo path constant class which contains all the path of the pawns
class LudoPath {
  ///Calculate the path for player to move the pawn with specific step
  static double stepBox(double boardSize, double step) {
    double boxRaw = (boardSize / 15);
    double stepSize = boxRaw * step;
    return stepSize;
  }

  ///Safe path that is the path where the pawns can move without getting killed
  static const List<List<double>> safeArea = [
    [1, 2],
    [12, 6],
    [8, 12],
    [2, 8],
    /////////
    [8, 1],
    [13, 8],
    [6, 13],
    [1, 6],
    [4, 4], // Additional safe spot
    [9, 9], // Additional safe spot
    [11, 11], // Additional safe spot
    [7, 7],
  ];
  static const List<List<double>> greenHomePath = [
    [2.6, 1.3],
    [1.3, 2.3],
    [3.7, 2.3],
    [2.6, 3.5],

    // [1.5, 1.5],
    // [1.5, 3.5],
    // [3.5, 1.5],
    // [3.5, 3.5],
  ];
  static const List<List<double>> yellowHomePath = [
    // [11.5, 1],
    // [10.3, 2.3],
    // [12.5, 2.3],
    // [11.5, 3.5],

    [11.5, 1.1],
    [10.3, 2.3],
    [12.7, 2.3],
    [11.5, 3.5],




  ];
  static const List<List<double>> blueHomePath = [
    [11.5, 10.3],
    [10.3, 11.4],
    [12.7, 11.4],
    [11.5, 12.6],

    // [10.5, 10.5],
    // [10.5, 12.5],
    // [12.5, 10.5],
    // [12.5, 12.5],
  ];
  static const List<List<double>> redHomePath = [

    [2.6, 10.3],
    [1.4, 11.4],
    [3.7, 11.4],
    [2.6, 12.6],
    // [1.9,2],
    // [3,4],
    // [6,5],
    // [7,8],

    // [1.5, 10.5],
    // [1.5, 12.5],
    // [3.5, 10.5],
    // [3.5, 12.5],
  ];




  static const List<List<double>> greenPath = [
    ////////BLUE TOP
    [13, 8],
    [12, 8],
    [11, 8],
    [10, 8],
    [9, 8],
    ////////BLUE LEFT
    [8, 9],
    [8, 10],
    [8, 11],
    [8, 12],
    [8, 13],
    [8, 14],
    ////////BLUE TO RED
    [7, 14],
    ////////RED RIGHT
    [6, 14],
    [6, 13],
    [6, 12],
    [6, 11],
    [6, 10],
    [6, 9],
    ////////RED TOP
    [5, 8],
    [4, 8],
    [3, 8],
    [2, 8],
    [1, 8],
    [0, 8],
    ////////RED TO GREEN
    [0, 7],
    ////////GREEN BOTOM
    [0, 6],
    [1, 6],
    [2, 6],
    [3, 6],
    [4, 6],
    [5, 6],
    ////////GREEN RIGHT
    [6, 5],
    [6, 4],
    [6, 3],
    [6, 2],
    [6, 1],
    [6, 0],
    ////////GREEN TO YELLOW
    [7, 0],
    ////////YELLOW LEFT
    [8, 0],
    [8, 1],
    [8, 2],
    [8, 3],
    [8, 4],
    [8, 5],
    ////////YELLOW BOTTOM
    [9, 6],
    [10, 6],
    [11, 6],
    [12, 6],
    [13, 6],
    [14, 6],
    ////////YELLOW TO BLUE WINNER PATH
    [14, 7],
    ////////BLUE WINNER TOP
    [13, 7],
    [12, 7],
    [11, 7],
    [10, 7],
    [9, 7],
    [8, 7],
  ];
  static const List<List<double>> yellowPath = [
    ////////RED RIGHT
    [6, 13],
    [6, 12],
    [6, 11],
    [6, 10],
    [6, 9],
    ////////RED TOP
    [5, 8],
    [4, 8],
    [3, 8],
    [2, 8],
    [1, 8],
    [0, 8],
    ////////RED TO GREEN
    [0, 7],
    ////////GREEN BOTOM
    [0, 6],
    [1, 6],
    [2, 6],
    [3, 6],
    [4, 6],
    [5, 6],
    ////////GREEN RIGHT
    [6, 5],
    [6, 4],
    [6, 3],
    [6, 2],
    [6, 1],
    [6, 0],
    ////////GREEN TO YELLOW
    [7, 0],
    ////////YELLOW LEFT
    [8, 0],
    [8, 1],
    [8, 2],
    [8, 3],
    [8, 4],
    [8, 5],
    ////////YELLOW BOTTOM
    [9, 6],
    [10, 6],
    [11, 6],
    [12, 6],
    [13, 6],
    [14, 6],
    ////////YELLOW TO BLUE
    [14, 7],
    ////////BLUE TOP
    [14, 8],
    [13, 8],
    [12, 8],
    [11, 8],
    [10, 8],
    [9, 8],
    ////////BLUE LEFT
    [8, 9],
    [8, 10],
    [8, 11],
    [8, 12],
    [8, 13],
    [8, 14],
    ////////BLUE TO RED WINNER PATH
    [7, 14],
    ////////RED WINNER PATH
    [7, 13],
    [7, 12],
    [7, 11],
    [7, 10],
    [7, 9],
    [7, 8],

  ];
  static const List<List<double>> bluePath = [
    ////////Green BOTTOM
    [1, 6],
    [2, 6],
    [3, 6],
    [4, 6],
    [5, 6],
    ////////Green RIGHT
    [6, 5],
    [6, 4],
    [6, 3],
    [6, 2],
    [6, 1],
    [6, 0],
    ////////GREEN TO YELLOW
    [7, 0],
    ////////YELLOW LEFT
    [8, 0],
    [8, 1],
    [8, 2],
    [8, 3],
    [8, 4],
    [8, 5],
    ////////YELLOW BOTTOM
    [9, 6],
    [10, 6],
    [11, 6],
    [12, 6],
    [13, 6],
    [14, 6],
    ////////YELLOW TO BLUE
    [14, 7],
    ////////BLUE TOP
    [14, 8],
    [13, 8],
    [12, 8],
    [11, 8],
    [10, 8],
    [9, 8],
    ////////BLUE LEFT
    [8, 9],
    [8, 10],
    [8, 11],
    [8, 12],
    [8, 13],
    [8, 14],
    ////////BLUE TO RED
    [7, 14],
    ////////RED RIGHT
    [6, 14],
    [6, 13],
    [6, 12],
    [6, 11],
    [6, 10],
    [6, 9],
    ////////RED TOP
    [5, 8],
    [4, 8],
    [3, 8],
    [2, 8],
    [1, 8],
    [0, 8],
    ////////RED TO GREEN WINNER PATH
    [0, 7],
    ////////GREEN WIN PATH
    [1, 7],
    [2, 7],
    [3, 7],
    [4, 7],
    [5, 7],
    [6, 7],

  ];
  static const List<List<double>> redPath = [
    ////////YELLOW LEFT
    [8, 1],
    [8, 2],
    [8, 3],
    [8, 4],
    [8, 5],
    ////////YELLOW BOTTOM
    [9, 6],
    [10, 6],
    [11, 6],
    [12, 6],
    [13, 6],
    [14, 6],
    ////////YELLOW TO BLUE
    [14, 7],
    ////////BLUE TOP
    [14, 8],
    [13, 8],
    [12, 8],
    [11, 8],
    [10, 8],
    [9, 8],
    ////////BLUE LEFT
    [8, 9],
    [8, 10],
    [8, 11],
    [8, 12],
    [8, 13],
    [8, 14],
    ////////BLUE TO RED
    [7, 14],
    ////////RED RIGHT
    [6, 14],
    [6, 13],
    [6, 12],
    [6, 11],
    [6, 10],
    [6, 9],
    ////////RED TOP
    [5, 8],
    [4, 8],
    [3, 8],
    [2, 8],
    [1, 8],
    [0, 8],
    ////////RED TO GREEN
    [0, 7],
    ////////GREEN BOTOM
    [0, 6],
    [1, 6],
    [2, 6],
    [3, 6],
    [4, 6],
    [5, 6],
    ////////GREEN RIGHT
    [6, 5],
    [6, 4],
    [6, 3],
    [6, 2],
    [6, 1],
    [6, 0],
    ////////GREEN TO YELLOW WINNER PATH
    [7, 0],
    ////////YELLOW WINNER PATH
    [7, 1],
    [7, 2],
    [7, 3],
    [7, 4],
    [7, 5],
    [7, 6],
  ];
}