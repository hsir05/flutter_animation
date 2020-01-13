import 'package:flutter/material.dart';

class OpacityPage extends StatefulWidget {
  @override
  _OpacityPageState createState() => _OpacityPageState();
}

class _OpacityPageState extends State<OpacityPage> with SingleTickerProviderStateMixin{
  bool _visible = false;

  @override
  void initState() {
    super.initState();
  }

  void _animation() {
      setState(() {
        if (!_visible) {
          _visible = true;
        } else {
          _visible = false;
        }
        });
  }

  Widget _opacity(){
    return AnimatedOpacity(
      duration: Duration(seconds: 1), 
      opacity: _visible ? 1.0 : 0.0,
      child: Container(
        width: 100.0,
        height: 100.0,
        color: Colors.redAccent,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         brightness: Brightness.dark,
          elevation: 0,
          backgroundColor: Colors.redAccent,
        title: Text('透明度变化动画')
      ),
      body: ListView(
        children: <Widget>[
          _opacity(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animation,
        backgroundColor: Colors.redAccent,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}