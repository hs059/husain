


import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _menuKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final button = new PopupMenuButton(icon: Icon(Icons.category,color: Colors.white,),
        key: _menuKey,
        itemBuilder: (_) => <PopupMenuItem<String>>[
          new PopupMenuItem<String>(
              child: const Text('Doge'), value: 'Doge'),
          new PopupMenuItem<String>(
              child: const Text('Lion'), value: 'Lion'),
        ],
        onSelected: (_) {});

    final tile =
    new ListTile(title: new Text('Doge or lion?'), trailing: button, onTap: () {
      // This is a hack because _PopupMenuButtonState is private.
      dynamic state = _menuKey.currentState;
      state.showButtonMenu();
    });
    return new Scaffold(
      body: new Center(
        child: tile,
      ),
    );
  }
}