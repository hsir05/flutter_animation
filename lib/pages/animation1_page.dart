import 'package:flutter/material.dart';

class Anmation1 extends StatefulWidget {
  @override
  _Anmation1State createState() => _Anmation1State();
}

class _Anmation1State extends State<Anmation1> with SingleTickerProviderStateMixin{
  bool _visible = false;
  AnimationController controller;
  Animation<double> doubleAnimation;

    @override
  void initState() {
    super.initState();
    //创建AnimationController
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
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
    //启动动画
    controller.forward();
  }

  void _animation() {
      print('动画');

      setState(() {
        if (!_visible) {
          _visible = true;
        } else {
          _visible = false;
        }
        });
    
  }

  Widget _opacity(){
    return AnimatedOpacity(
      duration: Duration(seconds: 1), 
      opacity: _visible ? 1.0 : 0.0,
      child: Container(
        width: 100.0,
        height: 100.0,
        color: Colors.blue,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter 动画')
      ),
      body: ListView(
        children: <Widget>[
          _opacity(),
        
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animation,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      
    );
  }
}