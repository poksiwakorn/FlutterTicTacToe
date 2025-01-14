import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  bool oTurn = true;
  int gridSize = 3;
  late List<String> displayXO;
  late List<String> displayWinner;
  String result = '';
  int oScore = 0;
  int xScore = 0;
  int filledCount = 0;
  bool winnerFound = false;

  @override
  void initState() {
    super.initState();
    displayXO = List.generate(gridSize * gridSize, (index) => ''); 
    displayWinner = List.generate(gridSize, (index) => '');
  }

  void displayXOClear(){
    setState(() {
      for (int i=0;i<displayXO.length;i++){
        displayXO[i] = '';
      }
      result = '';
      filledCount = 0;
      winnerFound = false;
    });
    print("displayXOClear");
  }

  void updateScore(String winner, List<String> winnerGrids){
    displayWinner = winnerGrids;
    if (winner == 'O'){
      oScore += 1;
    }else{
      xScore += 1;
    }
    winnerFound = true;
  }

  void checkForWinner(){
    print(displayXO);
    // Row win
    for (int i=0; i<gridSize;i++){
      int rowStart = i*gridSize;
      List<String> rowCheck = displayXO.sublist(rowStart, rowStart+gridSize);
      bool allO = rowCheck.every((e) => e == 'O');
      if (allO){
        result = "Player O wins";
        updateScore('O', rowCheck);
        break;
      }
      bool allX = rowCheck.every((e) => e == 'X');
      if (allX){
        result = "Player X wins";
        updateScore('X', rowCheck);
        break;
      }
    }
    // Col win
    for (int i=0; i<gridSize;i++){
      List<String> checkCol = List.generate(gridSize, (index) => '');
      // print(checkCol);
      for (int j=0;j<gridSize;j++){
        // print([i, j]);
        int idx = i + (j*gridSize);
        // print(displayXO[idx]);
        checkCol[j] = displayXO[idx];
      }
      bool allX = checkCol.sublist(0, gridSize).every((e) => e == 'X');
      if (allX){
        result = "Player X wins";
        updateScore('X', checkCol);
        break;
      }
      bool allO = checkCol.sublist(0, gridSize).every((e) => e == 'O');
      if (allO){
        result = "Player O wins";
        updateScore('O', checkCol);
        break;
      }
    }
    // Diagonal win
    // Left Diagonal
    if (!winnerFound){
      List<String> checkDiagonal = List.generate(gridSize, (index) => '');
      for (int i=0; i<gridSize;i++){
        int idx = i*gridSize+i;
        print(idx);
        checkDiagonal[i] = displayXO[idx];
      }
      bool allX = checkDiagonal.sublist(0, gridSize).every((e) => e == 'X');
      if (allX){
        result = "Player X wins";
        updateScore('X', checkDiagonal);
        return;
      }
      bool allO = checkDiagonal.sublist(0, gridSize).every((e) => e == 'O');
      if (allO){
        result = "Player O wins";
        updateScore('O', checkDiagonal);
        return;
      }
    }
    // Right Diagonal
    if (!winnerFound){
      List<String> checkDiagonal = List.generate(gridSize, (index) => '');
      for (int i=0; i<gridSize;i++){
        int idx = i*gridSize+gridSize-i-1;
        print(idx);
        checkDiagonal[i] = displayXO[idx];
      }
      bool allX = checkDiagonal.sublist(0, gridSize).every((e) => e == 'X');
      if (allX){
        result = "Player X wins";
        updateScore('X', checkDiagonal);
        return;
      }
      bool allO = checkDiagonal.sublist(0, gridSize).every((e) => e == 'O');
      if (allO){
        result = "Player O wins";
        updateScore('O', checkDiagonal);
        return;
      }
    }
    if (!winnerFound && filledCount == gridSize*gridSize){
      result = "Tie";
      return;
    }
  }

  void gridTap(int index){
    // print(oTurn);
    if (displayXO[index] == ''){
      setState(() {
        if (oTurn){
          displayXO[index] = 'O';
        }else{
          displayXO[index] = 'X';
        }
        filledCount += 1;
        oTurn = !oTurn;
        checkForWinner();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    // double width = size.width;
    // double height = size.height;

    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(height: 50),
                    Text("Player O",
                      style: GoogleFonts.rubikDirt(
                        textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)
                      ),
                    ),
                    Text(oScore.toString(),
                      style: GoogleFonts.rubikDirt(
                        textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 50),
                    Text("Player X",
                      style: GoogleFonts.rubikDirt(
                        textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)
                      ),
                    ),
                    Text(xScore.toString(),
                      style: GoogleFonts.rubikDirt(
                        textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)
                      ),
                    ),
                  ],
                )
              ],
            )
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: gridSize*gridSize,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridSize
              ), 
              itemBuilder: (BuildContext context, int index){
                return GestureDetector(
                  onTap: (){
                    gridTap(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 5,
                        color: Colors.redAccent
                      ),
                      color: Colors.greenAccent
                    ),
                    child: Center(
                      child: Text(
                        displayXO[index],
                        style: GoogleFonts.rubikDirt(
                          textStyle: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.redAccent)
                        ),
                      ),
                    )
                  ),
                );
              }
            )
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  result,
                  style: GoogleFonts.rubikDirt(
                    textStyle: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)
                  ),
                ),
                FilledButton(
                  onPressed: displayXOClear, 
                  child: Text(
                    "reset",
                    style: GoogleFonts.rubikDirt(
                      textStyle: TextStyle(fontSize: 20, color: Colors.white)
                    ),
                  ),
                )
              ]
            )
          )
        ],
      )
    );
  }
}

