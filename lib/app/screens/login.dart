import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:plant_disease_detection/app/common_widget/CustomRaisedButton.dart';
import 'package:plant_disease_detection/app/screens/homescreen.dart';
import 'package:plant_disease_detection/app/services/auth.dart';







const PRIMARY="primary";
const WHITE="white";

const Map<String,Color>myColors={
  PRIMARY:Color.fromRGBO(55, 115, 138, 1),
  WHITE:Colors.white,
};

class Login extends StatefulWidget {final AuthBase auth;

Login({@required this.auth}) ;
  @override
  _State createState() => _State();
}

class _State extends State<Login> {final formKey = new GlobalKey();
 final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  void _submit() async {
    try {
       {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      }
     Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HomeScreen(
                                                       auth: Auth(), 
                                                    )),
                                            (Route<dynamic> route) => false );
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/main.png'), fit: BoxFit.fill)),
        child: ListView(
          /// crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    height: 140.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: new AssetImage('images/pddlogo.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.6),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.0),
                      topLeft: Radius.circular(50.0))),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(children: <Widget>[
                    Container(
                      child: Container(
                        child: Text(
                          "Log In",
                          style: TextStyle(
                              fontSize: 32.0, fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                      ),
                      // padding: EdgeInsets.all(10.0),
                      // child: TextField(
                      //   obscureText: true,
                      //   decoration: InputDecoration(
                      //     hintText: 'Password',
                      //     hintStyle: TextStyle(color: Colors.grey),
                      //   ),
                      // ),
                    ),
                  
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      child: TextField(controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "Email Adress",
                          hintText: "Enter your email",
                          // hoverColor: Colors.black,
                          fillColor: Colors.white, filled: true,
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            // borderSide: BorderSide(color: Colors.grey),
                          ),
                        ), autocorrect: false,
                        keyboardType:TextInputType.emailAddress,
                        
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      child: TextField(controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Enter your password",
                          // hoverColor: Colors.black,
                          fillColor: Colors.white, filled: true,
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ), 
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            // borderSide: BorderSide(color: Colors.grey),
                          ),
                        ), autocorrect: false,
                       
                        obscureText: true,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 260.0),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                         
                          SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            height: 55.0,
                            child: CustomRaisedButton(
                                color: Color(0xFFB2002D),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '  Log In',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                onPressed:_submit),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}