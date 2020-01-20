import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routes{
  static String root='/';
  static String opacity = '/opacity';
  static String radius = '/radius';
  static String size = '/size';
  static String translation = '/translation';
  static String curves = '/curves';
  static String threeD = '/threeD';
  static String card = '/card';
  static String six = '/six';

  static void configureRoutes(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params ){
        print('错误---------->路由未找到');
      }
    );
    
    router.define(root, handler: homeHandler);
    router.define(opacity, handler: opacityHandler);
    router.define(radius, handler: radiusHandler);
    router.define(size, handler: sizeHandler);
    router.define(translation, handler: translationPageHandle);
    router.define(curves, handler: curvesPageHandle);
    router.define(threeD, handler: threeDPageHandle);
    router.define(card, handler: cardPageHandle);
    router.define(six, handler: sixPageHandle);
  }
}
