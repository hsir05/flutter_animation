import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluro/fluro.dart';
import './routers/application.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  Widget _listItem(title, path) {
    return ListTile(
      onTap: (){
        Application.router.navigateTo(context, path, transition: TransitionType.inFromRight);
      },
      leading: Icon(Icons.opacity),
      title: Text(title),
      trailing: Icon(Icons.keyboard_arrow_right),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: GestureDetector(
        onHorizontalDragEnd: (details){
          Navigator.pop(context);
        },
        child: Scaffold(
          appBar: AppBar(
            brightness: Brightness.dark,
            elevation: 0,
            backgroundColor: Colors.redAccent,
            title: Text('动画'), 
            centerTitle: true),
          body:ListView(
            children: <Widget>[
                _listItem('透明度', '/opacity')
            ],
          )
          ),
      )
    );
  }
}