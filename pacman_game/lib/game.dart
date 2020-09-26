import 'package:flutter/material.dart';

import 'constants/constants.dart';

class MainSceneView extends StatefulWidget {
  @override
  _MainSceneViewState createState() => _MainSceneViewState();
}

class _MainSceneViewState extends State<MainSceneView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            margin: EdgeInsets.only(top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 10, top: 16, bottom: 4),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 25),
                        child: Text('Score', style: titleStyle),
                      ),
                      Text('0', style: titleStyle),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
