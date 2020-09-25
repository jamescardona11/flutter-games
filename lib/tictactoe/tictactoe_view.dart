import 'package:flutter/material.dart';

class TicTacToeView extends StatefulWidget {
  @override
  _TicTacToeViewState createState() => _TicTacToeViewState();
}

class _TicTacToeViewState extends State<TicTacToeView> {
  List<String> displayEx0h = ['', '', '', '', '', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: GridView.builder(
        itemCount: 9,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _onTapped(index),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey[700])),
              child: Center(
                child: Text(
                  displayEx0h[index],
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onTapped(int index) {
    setState(() {
      displayEx0h[index] = displayEx0h[index].isEmpty ? 'O' : 'X';
    });
  }
}
