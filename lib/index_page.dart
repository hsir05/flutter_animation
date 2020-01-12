import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  Widget _listItem(title) {
    return ListTile(
      leading: Icon(Icons.cake),
      title: Text(title),
      trailing: Icon(Icons.arrow),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _listItem('动画')
      ],
    );
  }
}