# flutter 动画

## 1 概述

flutter 动画分为`Tween Animation 补间动画 `和 `Physics-based Animation 基于物理动画`

+ 在补间动画中，定义了开始点和结束点、时间线以及定义转换时间和速度的曲线，然后由框架自动计算如何从开始点过渡到结束点。
+ 在基于物理的动画(遵循物理学定律)中，运动被模拟为与真实世界的行为相似，可以模拟弹簧、阻尼、重力等物理效果。例如，当你掷球时，它在何处落     地，取决于抛球速度有多快、球有多重、距离地面有多远。类似地，将连接在弹簧上的球落下（并弹起）与连接到绳子上的球放下的方式也是不同

## 2 Animation

**Animation类有四种状态**

1. dismissed：动画初始状态
2. forward：动画从头到尾播放状态
3. reverse：动画从尾到头播放状态
4. completed：动画完成状态

Animation类是Flutter动画中核心的抽象类，它包含动画的当前值和状态两个属性。定义了动画的一系列监听回调

+ 值监听：addListener、removeListener
+ 状态监听：addStatusListener、removeStatusListener

## 3 动画控制AnimationController

+ AnimationController是一个特殊的Animation对象，在屏幕刷新的每一帧，就会生成一个新的值，默认情况下，AnimationController在给定的时间段内会线性的生成从0.0到1.0的数字

+ 属于Animation类型

+ 具有控制动画的方法，例如，.forward()方法可以启动动画
当创建一个AnimationController时，需要传递一个vsync参数，存在vsync时会防止屏幕外动画（动画的UI不在当前屏幕时）消耗不必要的资源。

+ 通过将SingleTickerProviderStateMixin添加到类定义中，可以将stateful对象作为vsync的值。如果要使用自定义的State对象作为vsync时，请包含TickerProviderStateMixin。

+ 特别注意：在不使用时需要调用dispose方法，否则会造成资源泄露

## 4 Curve

定义了时间和数值的抽象类。Flutter封装定义了一系列的插值器，如linear、decelerate、ease、bounce、cubic等。当然Flutter提供的不满足需求的话，也可以自定义插值器

## 5 Tween

线性估值器。Flutter还封装定义了不同类型的估值器：

1. ReverseTween
2. ColorTween
3. SizeTween
4. RectTween
5. IntTween
6. StepTween
7. ConstantTween

