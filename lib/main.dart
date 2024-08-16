import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToeHomePage(),
    );
  }
}

class TicTacToeHomePage extends StatefulWidget {
  @override
  _TicTacToeHomePageState createState() => _TicTacToeHomePageState();
}

class _TicTacToeHomePageState extends State<TicTacToeHomePage> {
  List<List<String>> _board = [];
  String _currentPlayer = 'X';
  String _winner = '';

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    _board = List.generate(3, (_) => List.generate(3, (_) => ''));
    _currentPlayer = 'X';
    _winner = '';
  }

  void _resetGame() {
    setState(() {
      _initializeGame();
    });
  }

  void _makeMove(int row, int col) {
    if (_board[row][col].isEmpty && _winner.isEmpty) {
      setState(() {
        _board[row][col] = _currentPlayer;
        if (_checkWinner(row, col)) {
          _winner = _currentPlayer;
        } else {
          _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  bool _checkWinner(int row, int col) {
    // Check the row
    if (_board[row].every((cell) => cell == _currentPlayer)) {
      return true;
    }
    // Check the column
    if (_board.every((row) => row[col] == _currentPlayer)) {
      return true;
    }
    // Check diagonals
    if (row == col && _board.every((row) => row[_board.indexOf(row)] == _currentPlayer)) {
      return true;
    }
    if (row + col == 2 && _board.every((row) => row[2 - _board.indexOf(row)] == _currentPlayer)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildBoard(),
          if (_winner.isNotEmpty) ...[
            Text(
              'Player $_winner wins!',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
          ],
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _resetGame,
            child: Text('New Game'),
          ),
        ],
      ),
    );
  }

  Widget _buildBoard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (col) {
            return _buildCell(row, col);
          }),
        );
      }),
    );
  }

  Widget _buildCell(int row, int col) {
    return GestureDetector(
      onTap: () => _makeMove(row, col),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Center(
          child: Text(
            _board[row][col],
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
