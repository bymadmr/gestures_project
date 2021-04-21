import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tabsCount = 0;
  int doubleTabsCount = 0;
  int longPressCount = 0;
  double xPosition = 40;
  double yPosition = 60;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestures Project"),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            tabsCount++;
          });
        },
        onDoubleTap: () {
          setState(() {
            doubleTabsCount++;
          });
        },
        onLongPress: () {
          setState(() {
            longPressCount++;
          });
        },
        onVerticalDragUpdate: (DragUpdateDetails value) {
          setState(() {
            double deltay = value.delta.dy;
            yPosition += deltay;
          });
        },
        onHorizontalDragUpdate: (DragUpdateDetails values) {
          setState(() {
            double deltax = values.delta.dx;
            xPosition += deltax;
          });
        },
        child: Stack(
          children: [
            Positioned(
                left: xPosition,
                top: yPosition,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(color: Colors.cyan),
                ))
          ],
        ),
      ),
      bottomNavigationBar: Material(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
            "Tab : $tabsCount, DoubleTabs : $doubleTabsCount, LongPress : $longPressCount"),
      )),
    );
  }
}
