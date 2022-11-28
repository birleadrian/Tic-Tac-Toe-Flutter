import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToe());
}

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tic-Tac-Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String currentSymbol = 'X';
  List<String> symbolsOnMap = new List.filled(9, '');
  bool isGameFinished = false;
  String wonMessage = '';

  void restart() {
    setState(() {
      currentSymbol = 'X';
      symbolsOnMap = new List.filled(9, '');
      isGameFinished = false;
      wonMessage = '';
    });
  }

  bool checkIfEmpty(index) {
    return symbolsOnMap[index] == '';
  }

  void checkIfWon() {
    setState(() {
      int j = 0;
      // Validation for lines
      for (int i = 0; i < 3; i++) {
        if (symbolsOnMap[i + j] == symbolsOnMap[i + j + 1] &&
            symbolsOnMap[i + j] == symbolsOnMap[i + j + 2] &&
            !checkIfEmpty(i + j)) {
          print('intra');
          isGameFinished = true;
          wonMessage = 'Player $currentSymbol won!';
          return;
        }
        j += 2;
      }

      // Validation for columns
      for (int i = 0; i < 3; i++) {
        if (symbolsOnMap[i] == symbolsOnMap[i + 3] && symbolsOnMap[i] == symbolsOnMap[i + 6] && !checkIfEmpty(i)) {
          print(2);
          isGameFinished = true;
          wonMessage = 'Player $currentSymbol won!';
          return;
        }
      }

      // Validation for diagonals
      if (symbolsOnMap[0] == symbolsOnMap[4] &&
          symbolsOnMap[0] == symbolsOnMap[8] &&
          !checkIfEmpty(0) &&
          !checkIfEmpty(4) &&
          !checkIfEmpty(8)) {
        print(3);
        isGameFinished = true;
        wonMessage = 'Player $currentSymbol won!';
        return;
      }

      if (symbolsOnMap[2] == symbolsOnMap[4] &&
          symbolsOnMap[2] == symbolsOnMap[6] &&
          !checkIfEmpty(2) &&
          !checkIfEmpty(4) &&
          !checkIfEmpty(6)) {
        print(4);
        isGameFinished = true;
        wonMessage = 'Player $currentSymbol won!';
        return;
      }
    });
  }

  void tapped(index) {
    setState(() {
      if (symbolsOnMap[index] != '') {
        return;
      }
      symbolsOnMap[index] = currentSymbol;
      checkIfWon();
      if (currentSymbol == 'X') {
        currentSymbol = 'O';
      } else {
        currentSymbol = 'X';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(wonMessage),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        isGameFinished ? print('Game is finished') : tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: symbolsOnMap[index] == ''
                                ? Colors.white
                                : (symbolsOnMap[index] == 'X' ? Colors.lightBlue : Colors.greenAccent)),
                        child: Center(
                          child: Text(
                            symbolsOnMap[index],
                            style: TextStyle(
                              fontSize: 40,
                              color: symbolsOnMap[index] == 'X' ? Colors.yellow : Colors.deepOrangeAccent,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: restart,
        tooltip: 'Restart game',
        child: const Icon(Icons.restart_alt),
      ),
    );
  }
}
