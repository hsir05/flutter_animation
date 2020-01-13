import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'index_page.dart';
import './routers/routes.dart';
import './routers/application.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final router = Router();
    Routes.configureRoutes(router);
    Application.router=router;

     return MaterialApp(
            title:'flutter 动画',
            // debugShowCheckedModeBanner: false,
            onGenerateRoute: Application.router.generator,
            home: IndexPage()
        );
  }
}