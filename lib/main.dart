import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'AdminPage.dart';
import 'MemberPage.dart';

void main() => runApp(new MyApp());

String username='';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      theme: buildTheme(),
      debugShowCheckedModeBanner: false,
      title: 'Login Localhost',
      home: new MyHomePage(),
      routes: <String,WidgetBuilder>{
        '/AdminPage': (BuildContext context)=> new AdminPage(username: username,),
        '/MemberPage': (BuildContext context)=> new MemberPage(username: username,),
        '/MyHomePage': (BuildContext context)=> new MyHomePage(),
      },
    );
  }

  ThemeData buildTheme() {
    final ThemeData base = ThemeData();
    return base.copyWith(
      hintColor: Colors.purple,
      primaryColor: Colors.yellow,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.blue,
        ),
        labelStyle: TextStyle(
          color: Colors.green,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController user=new TextEditingController();
  TextEditingController pass=new TextEditingController();

  String msg='';


  Future<List> _login() async {
    final response = await http.post("http://192.168.43.172/flutter_login/login.php", body: {
      "username": user.text,
      "password": pass.text,
    });

    var datauser = json.decode(response.body);

    if(datauser.length==0){
      setState(() {
        msg="Login Fail";
      });
    }else{
      if(datauser[0]['level']=='admin'){
        Navigator.pushReplacementNamed(context, '/AdminPage');
      }else if(datauser[0]['level']=='member'){
        Navigator.pushReplacementNamed(context, '/MemberPage');
      }

      setState(() {
        username= datauser[0]['username'];
      });

    }

    return datauser;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text("Login"),),

      body: Container(
        decoration: new BoxDecoration(color: Colors.black),
//        margin: EdgeInsets.all(30),
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(


            children: <Widget>[
//
//              new InkWell(
//                  onTap: () {},
//                  child: new Theme(
//                      data: new ThemeData(
//                          primaryColor: Colors.yellow,
//                          primaryColorDark: Colors.red,
//                          hintColor: Colors.yellow
//
//                      ),
//
//                      child: new TextField(
//                        decoration: new InputDecoration(
//
//                            border: new OutlineInputBorder(),
//                            hintText: 'Tell us about yourself',
//                            helperText: 'Keep it short, this is just a demo.',
//                            labelText: 'Life story',
//                            prefixIcon: const Icon(Icons.person, color: Colors.green,),
//                            prefixText: ' ',
//                            suffixText: 'USD',
//                            suffixStyle: const TextStyle(color: Colors.green)),
//                      )
//                  )
//              ),



              new Padding(padding: EdgeInsets.only(top: 30.0)),

              new Text('Login Here', style: new TextStyle(
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 2.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
//                      Shadow(
//                        offset: Offset(10.0, 10.0),
//                        blurRadius: 2.0,
//                        color: Color.fromARGB(125, 0, 0, 255),
//                      ),
                    ],
                  color: hexToColor("#F2A03D"), fontSize: 25.0),),

              new Padding(padding: EdgeInsets.only(top: 50.0)),


              new TextFormField(

                controller: user,
                decoration: new InputDecoration(


                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.red)
                  ),


                  labelText: "Username",
                  prefixIcon: const Icon(Icons.person, color: Colors.green,),
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                  //fillColor: Colors.green
                ),

                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.white,
                ),
              ),


              Padding(
                padding: EdgeInsets.all(30.0),
//                child: Text('Hello World!'),
              ),

              new TextFormField(
                controller: pass,
                obscureText: true,
                decoration: new InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.red)
                  ),
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.remove_red_eye , color: Colors.green,),
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                  //fillColor: Colors.green
                ),

                style: new TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.white,
                ),
              ),

              Padding(
                padding: EdgeInsets.all(8.0),
//                child: Text('Hello World!'),
              ),

              RaisedButton(

                child: Text("Login"),

//                color: Colors.transparent,
                textColor: Colors.white,
                color: Colors.red,
//                padding: const EdgeInsets.all(10.0),
                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                onPressed: (){
                  _login();
                },
              ),

              Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.red),)


            ],
          ),
        ),
      ),
    );
  }


    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

}