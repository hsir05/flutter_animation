import 'package:flutter/material.dart';

class SizePage extends StatefulWidget {
  @override
  _SizePageState createState() => _SizePageState();
}

class _SizePageState extends State<SizePage> with SingleTickerProviderStateMixin{
  bool _visible = false;
  double _width = 50.0;
  double _height = 50.0;
  var _color = Colors.redAccent;
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

  Widget _size(){
    return AnimatedContainer(
        // 定义动画需要多长时间
        duration: Duration(seconds:1),
        // 提供一个可选的曲线，使动画感觉更流畅。
        curve: Curves.fastOutSlowIn,
        //长度宽度使用变量  实现组件缩放动画
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          //颜色 圆角度使用变量
          color: _color,
        ),
      );
  }

  void _animation() {
      setState(() {
        if (!_visible) {
          _width = 150.0;
          _height = 200.0;
          _visible = true;
          _color = Colors.blueAccent;
        } else {
            _width = 50.0;
          _height = 50.0;
          _color = Colors.redAccent;
          _visible = false;
        }
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         brightness: Brightness.dark,
          elevation: 0,
          backgroundColor: Colors.redAccent,
        title: Text('位移变化动画')
      ),
      body: ListView(
        children: <Widget>[
           _size(),
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