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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int tabsCount = 0;
  int doubleTabsCount = 0;
  int longPressCount = 0;
  double xPosition = 0;
  double yPosition = 0;
  double boxSize = 0;
  double fullBoxSize = 150;

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    //when the application is first opened
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), //How long will it take?
        vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animation.addListener(() {
      setState(() {
        boxSize = fullBoxSize * animation.value;
      });
      centerBox(context);
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (xPosition == 0) {
    //   centerBox(context);
    // }
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
                  width: boxSize,
                  height: boxSize,
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

  void centerBox(BuildContext context) {
    xPosition = MediaQuery.of(context).size.width / 2 - boxSize / 2;
    yPosition = MediaQuery.of(context).size.height / 2 - boxSize / 2 - 30;
    setState(() {
      this.xPosition = xPosition;
      this.yPosition = yPosition;
    });
  }
}
