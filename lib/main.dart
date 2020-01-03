import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _width = 100.0;
  double _height = 100.0;
  var _color = Colors.green;

  void _animation() {
   print('动画');
   setState(() {
     _width = 200.0;
     _height = 300.0;
     _color = Colors.purple;
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter 动画')
      ),
      body:Center(
        child: AnimatedContainer(
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
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animation,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
