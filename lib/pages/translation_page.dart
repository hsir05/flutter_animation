import 'package:flutter/material.dart';

class TranslationPage extends StatefulWidget {
  @override
  _TranslationPageState createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> with SingleTickerProviderStateMixin{
  bool _visible = false;
  double _x = -30.0;
  double _y = -40.0;
  AnimationController controller;
  Animation<double> doubleAnimation;

  @override
  void initState() {
    super.initState();

     controller = new AnimationController(vsync: this, duration: Duration(milliseconds: 2000));
    
    doubleAnimation = new Tween<double>(begin: 0.0, end: 200.0).animate(controller)
      ..addListener(() {
      setState(() {});
    })
    ..addStatusListener((AnimationStatus status) {
      //执行完成后反向执行
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
      //反向执行完成，正向执行
        controller.forward();
      }
    });
    controller.forward();
  }

  void _animation() {
      setState(() {
        if (!_visible) {
           _x = 0;
          _y = 0;
          _visible = true;
        } else {
           _x = -30.0;
          _y =  -40.0;
          _visible = false;
        }
        });
  }

   Widget _animatedAlign() {
    return Container(
      width: 600.0,
      height: 400.0,
      color: Colors.black12,
      child: AnimatedAlign(
        // xy坐标 是决定组件再父容器中的位置。 修改坐标即可完成组件平移
          alignment: Alignment(_x, _y),
          duration: Duration(seconds: 5),
          child: Container(
            width: 50.0,
            height: 50.0,
            color: Colors.black45,
          ),
        ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         brightness: Brightness.dark,
          elevation: 0,
          backgroundColor: Colors.redAccent,
        title: Text('平移变化动画')
      ),
      body: ListView(
        children: <Widget>[
           _animatedAlign(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animation,
        backgroundColor: Colors.redAccent,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}