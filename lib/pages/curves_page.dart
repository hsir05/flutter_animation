import 'package:flutter/material.dart';

class CurvesPage extends StatefulWidget {
  @override
  _CurvesPageState createState() => _CurvesPageState();
}

class _CurvesPageState extends State<CurvesPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _doubleAnim;
  AnimationController _animationController;

  void myListener(status) {
    if (status == AnimationStatus.completed) {
      _animationController.removeStatusListener(myListener);
      _animationController.reset();
      _doubleAnim = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn));
      _animationController.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _doubleAnim = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn))
      ..addStatusListener(myListener);
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
       appBar: AppBar(
         brightness: Brightness.dark,
          elevation: 0,
          backgroundColor: Colors.redAccent,
        title: Text('Cure')
      ),
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget child) {
            return Transform(
              transform: Matrix4.translationValues(
                  _doubleAnim.value * _screenWidth, 0.0, 0.0),
              child: Center(
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  child: FlutterLogo(),
                ),
              ),
            );
          }),
    );
  }
}