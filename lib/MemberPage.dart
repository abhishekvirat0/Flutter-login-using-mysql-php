import 'package:flutter/material.dart';

class MemberPage extends StatelessWidget {

  MemberPage({this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome Member"),),
      body: Column(
        children: <Widget>[
          new Padding(padding: EdgeInsets.only(top: 40.0)),
          Center(child: Text('Hello $username', style: TextStyle(fontSize: 20.0),)),

          new Padding(padding: EdgeInsets.only(top: 40.0)),
//          Text('Hello $username', style: TextStyle(fontSize: 20.0),),

          RaisedButton(
            child: Text("LogOut"),
            onPressed: (){
              Navigator.pushReplacementNamed(context,'/MyHomePage');
            },
          ),
        ],
      ),
    );
  }
}