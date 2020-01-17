# flutter 动画

## 1. 概述

flutter 动画分为`Tween Animation 补间动画 `和 `Physics-based Animation 基于物理动画`

+ 在补间动画中，定义了开始点和结束点、时间线以及定义转换时间和速度的曲线，然后由框架自动计算如何从开始点过渡到结束点。
+ 在基于物理的动画(遵循物理学定律)中，运动被模拟为与真实世界的行为相似，可以模拟弹簧、阻尼、重力等物理效果。例如，当你掷球时，它在何处落     地，取决于抛球速度有多快、球有多重、距离地面有多远。类似地，将连接在弹簧上的球落下（并弹起）与连接到绳子上的球放下的方式也是不同

## 2. Animation

**Animation类有四种状态**

1. dismissed：动画初始状态
2. forward：动画从头到尾播放状态
3. reverse：动画从尾到头播放状态
4. completed：动画完成状态

Animation类是Flutter动画中核心的抽象类，它包含动画的当前值和状态两个属性。定义了动画的一系列监听回调

+ 值监听：addListener、removeListener
+ 状态监听：addStatusListener、removeStatusListener

## 3. 动画控制AnimationController

+ AnimationController是一个特殊的Animation对象，在屏幕刷新的每一帧，就会生成一个新的值，默认情况下，AnimationController在给定的时间段内会线性的生成从0.0到1.0的数字

+ 属于Animation类型

+ 具有控制动画的方法，例如，.forward()方法可以启动动画
当创建一个AnimationController时，需要传递一个vsync参数，存在vsync时会防止屏幕外动画（动画的UI不在当前屏幕时）消耗不必要的资源。

+ 通过将SingleTickerProviderStateMixin添加到类定义中，可以将stateful对象作为vsync的值。如果要使用自定义的State对象作为vsync时，请包含TickerProviderStateMixin。

+ 特别注意：在不使用时需要调用dispose方法，否则会造成资源泄露

## 4. Curve

定义了时间和数值的抽象类。Flutter封装定义了一系列的插值器，如linear、decelerate、ease、bounce、cubic等。当然Flutter提供的不满足需求的话，也可以自定义插值器

## 5. Tween

线性估值器。Flutter还封装定义了不同类型的估值器：

1. ReverseTween
2. ColorTween
3. SizeTween
4. RectTween
5. IntTween
6. StepTween
7. ConstantTween

## 6. 示例

### 6.1 示例1-ColorTween使用

实现背景颜色的渐变效果

```flutter
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<Color> _doubleAnim;
  AnimationController _animationController;

  //四种状态
  //1 dismissed 初始状态
  //2 forward 从头到尾播放状态
  //3 reverse 从尾到头播放状态
  //4 completed 完成状态
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))..forward();
    _doubleAnim = ColorTween(begin: Colors.red, end: Colors.white)
        .animate(_animationController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _animationController.forward();
            }
          });
//    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200.0,
          height: 200.0,
          color: _doubleAnim.value,
          child: FlutterLogo(),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: null),
    );
  }
}
```

### 6.2. 示例2-自定义AnimatedWidget

实现旋转和放大缩小效果

```flutter
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> _doubleAnim;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..forward();
    _doubleAnim = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyLogo(
          animation: _doubleAnim,
        ),
      ),
    );
  }
}

class MyLogo extends AnimatedWidget {
  final Tween<double> _rotateAnim = Tween<double>(begin: 0.0, end: 20.0);
  final Tween<double> _scaleAnim = Tween<double>(begin: 1.0, end: 10.0);
//  final Tween<Color> _colorAnim = Tween<Color>(begin: Colors.white, end: Colors.red);

  MyLogo({Key key, @required Animation animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Transform.scale(
      scale: _scaleAnim.evaluate(animation),
      child: Transform.rotate(
        angle: _rotateAnim.evaluate(animation),
        child: Container(
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
```

### 6.3. 示例3-Curves使用

```flutter
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
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
```

### 6.4. 示例4-3D效果

```
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(_offset.dy * 0.01)
            ..rotateY(_offset.dx * 0.01),
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _offset += details.delta;//更新offset（point）
              });
            },
            onDoubleTap: () {
              setState(() {
                _offset = Offset.zero;
              });
            },
            child: Container(
              width: 200.0,
              height: 200.0,
              color: Color(0xffff0000),
            ),
          ),
        ),
      ),
    );
  }
}
```

### 6.5. 示例5-卡片翻转效果

```
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;
  bool reversed = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: -pi / 2),
        weight: 0.5,
      ),
      TweenSequenceItem(
        tween: Tween(begin: pi / 2, end: 0.0),
        weight: 0.5,
      ),
    ]).animate(_animationController);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  _doAnim() {
    reversed ? _animationController.reverse() : _animationController.forward();
    reversed = !reversed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(_animation.value),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: _doAnim,
                  child: IndexedStack(
                    children: <Widget>[
                      CardOne(),
                      CardTwo(),
                    ],
                    alignment: Alignment.center,
                    index: _animationController.value < 0.5 ? 0 : 1,//0~1
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class CardOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffff0000),
      child: Container(
        width: 200.0,
        height: 200.0,
        child: Text(
          '点我看密码',
          style: TextStyle(color: Color(0xffffffff), fontSize: 30.0),
        ),
      ),
    );
  }
}

class CardTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff0000ff),
      child: Container(
        width: 200.0,
        height: 200.0,
        child: Text(
          '123456',
          style: TextStyle(color: Color(0xffffffff), fontSize: 30.0),
        ),
      ),
    );
  }
}
```

### 6.6. 示例6

```
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Tween<double> _tween;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..repeat();
    _tween = Tween<double>(begin: 0.0, end: 1.0);
  }

  Animation get animOne => _tween.animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            0.0,
            0.125,
            curve: Curves.linear,
          ),
        ),
      );

  Animation get animTwo => _tween.animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            0.125,
            0.25,
            curve: Curves.linear,
          ),
        ),
      );

  Animation get animThree => _tween.animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            0.25,
            0.375,
            curve: Curves.linear,
          ),
        ),
      );

  Animation get animFour => _tween.animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            0.375,
            0.5,
            curve: Curves.linear,
          ),
        ),
      );

  Animation get animFive => _tween.animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            0.5,
            0.625,
            curve: Curves.linear,
          ),
        ),
      );

  Animation get animSix => _tween.animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            0.625,
            0.75,
            curve: Curves.linear,
          ),
        ),
      );

  Animation get animSeven => _tween.animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            0.75,
            0.875,
            curve: Curves.linear,
          ),
        ),
      );

  Animation get animEight => _tween.animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            0.875,
            1.0,
            curve: Curves.linear,
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new AnimatedBrick(
              animations: [animOne, animTwo],
              controller: _animationController,
              marginLeft: 0.0,
              alignment: Alignment.centerLeft,
              isClockWise: true,
            ),
            new AnimatedBrick(
              animations: [animThree, animEight],
              controller: _animationController,
              marginLeft: 0.0,
              isClockWise: false,
            ),
            new AnimatedBrick(
              animations: [animFour, animSeven],
              controller: _animationController,
              marginLeft: 30.0,
              isClockWise: true,
            ),
            new AnimatedBrick(
              animations: [animFive, animSix],
              controller: _animationController,
              marginLeft: 30.0,
              isClockWise: false,
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedBrick extends AnimatedWidget {
  final AnimationController controller;
  final List<Animation> animations;
  final double marginLeft;
  final Alignment alignment;
  final bool isClockWise;

  AnimatedBrick({
    Key key,
    this.controller,
    this.animations,
    this.marginLeft,
    this.alignment = Alignment.centerRight,
    this.isClockWise,
  }) : super(key: key, listenable: controller);

  Matrix4 clockWise(animation) =>
      Matrix4.rotationZ(animation.value * pi * 2.0 * 0.5);

  Matrix4 antiClockWise(animation) =>
      Matrix4.rotationZ(-(animation.value * pi * 2.0 * 0.5));

  @override
  Widget build(BuildContext context) {
    var firstTransformation =
        isClockWise ? clockWise(animations[0]) : antiClockWise(animations[0]);
    var secondTransformation =
        isClockWise ? clockWise(animations[1]) : antiClockWise(animations[1]);

    return Transform(
        alignment: alignment,
        transform: firstTransformation,
        child: Transform(
            alignment: alignment,
            transform: secondTransformation,
            child: BrickWidget(marginLeft: marginLeft)));
  }
}

class BrickWidget extends StatelessWidget {
  final double marginLeft;

  const BrickWidget({
    Key key,
    this.marginLeft = 15.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: marginLeft),
      width: 40.0,
      height: 10.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Color(0xffff0000),
      ),
    );
  }
}
```
