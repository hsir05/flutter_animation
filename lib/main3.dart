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

class MyHomePage extends StatefulWidget  {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> doubleAnimation;

  double _width = 50.0;
  double _height = 50.0;
  var _color = Colors.green;
  bool _visible = false;

  double _x = -30.0;
  double _y = -40.0;

  @override
  void initState() {
    super.initState();
    //创建AnimationController
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
      print('动画');

      setState(() {
        if (!_visible) {
          _width = 150.0;
          _height = 200.0;
          _color = Colors.purple;

          _x = 0;
          _y = 0;

          _visible = true;
        } else {
          _width = 50.0;
          _height = 50.0;
          _color = Colors.green;
          _visible = false;
          

          _x = -30.0;
          _y =  -40.0;
        }
        });
    
  }

  Widget _size(){
    return Center(
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
      );
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
        title: Text('flutter 动画')
      ),
      body: ListView(
        children: <Widget>[
          _size(),
          _animatedAlign(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animation,
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
