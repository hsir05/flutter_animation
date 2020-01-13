import 'package:flutter/material.dart';

class RadiusPage extends StatefulWidget {
  @override
  _RadiusPageState createState() => _RadiusPageState();
}

class _RadiusPageState extends State<RadiusPage> with SingleTickerProviderStateMixin{
   AnimationController controller;
  //圆角动画
  Animation<BorderRadius> radiusAnimation;
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

    radiusAnimation = BorderRadiusTween(begin: BorderRadius.circular(0),end: BorderRadius.circular(50)).animate(controller);
    controller.forward();
  }

  Widget _radius(){
    return Padding(
      padding: EdgeInsets.all(100.0),
      child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(borderRadius: radiusAnimation.value,color: Colors.redAccent),
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
        title: Text('圆角变化')
      ),
      body: ListView(
        children: <Widget>[
         _radius()
        ],
      )
    );
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}