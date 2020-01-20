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
                _listItem('圆角变化', Icons.check_circle_outline,  '/radius'),
                _listItem('大小变化', Icons.format_size,  '/size'),
                _listItem('平移变化', Icons.track_changes,  '/translation'),
                _listItem('Curves', Icons.traffic,  '/curves'),
                _listItem('3d', Icons.view_list,  '/threeD'),
                _listItem('card翻转', Icons.card_travel,  '/card'),
                _listItem('six', Icons.card_travel,  '/six'),
            ],
          )
          );
  }
}