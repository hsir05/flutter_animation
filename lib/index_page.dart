import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluro/fluro.dart';
import './routers/application.dart';


class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  Widget _listItem(title, icon, path) {
    return ListTile(
      onTap: (){
        Application.router.navigateTo(context, path, transition: TransitionType.inFromRight);
      },
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.keyboard_arrow_right),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            brightness: Brightness.dark,
            elevation: 0,
            backgroundColor: Colors.redAccent,
            title: Text('动画'), 
            centerTitle: true),
          body:ListView(
            children: <Widget>[
                _listItem('透明度', Icons.opacity, '/opacity'),
                _listItem('圆角变化', Icons.remove_circle,  '/radius'),
                _listItem('大小变化', Icons.remove_circle,  '/size'),
                _listItem('平移变化', Icons.remove_circle,  '/translation'),
                _listItem('Curves', Icons.remove_circle,  '/curves'),
                _listItem('4d', Icons.remove_circle,  '/fourD'),
            ],
          )
          );
  }
}