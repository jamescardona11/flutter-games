import 'package:flutter/material.dart';
import 'snake/snake_view.dart';
import 'tictactoe/tictactoe_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Center(child: Text('GAMES')),
        ),
        body: _NavigatorIntern(),
      ),
    );
  }
}

class _NavigatorIntern extends StatelessWidget {
  final Map<String, Widget> screens = {
    'TicTacToe': TicTacToeView(),
    'Snake': SnakeView(),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: ListView(
        children: convertMapToList(context, screens),
      ),
    );
  }
}

List<Widget> convertMapToList(BuildContext context, screens) {
  List<Widget> listItems = [];
  screens.forEach(
    (key, value) => listItems.add(
      Card(
        child: ListTile(
          title: Text(
            key,
            style: TextStyle(),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => value));
          },
        ),
      ),
    ),
  );

  return listItems;
}
