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

class CreateLogin extends StatefulWidget {final AuthBase auth;

CreateLogin({@required this.auth}) ;
  @override
  _State createState() => _State();
}

class _State extends State<CreateLogin> {final formKey = new GlobalKey();
  final TextEditingController  _nameController= TextEditingController();
final   TextEditingController _emailController = TextEditingController();
 final  TextEditingController _passwordController = TextEditingController();
 final  TextEditingController _addressController = TextEditingController();
String get _name => _nameController.text;
String get _email => _emailController.text;
String get _password => _passwordController.text;
String get _address => _addressController.text;
 bool checkboxValue = false;
  String valuechoose;
TextEditingController controller = TextEditingController();
void _submit()async{
  try{ 
    await widget.auth.createUserWithEmailAndPassword(_email, _password,).then((currentUser) => Firestore.instance.collection("users")
    .document(currentUser.uid).setData(
      {"uid": currentUser.uid,
                                    "fname": _name,
                                    "password":_password ,
                                    "email": _email,
                                    "address":_address})  
                                    .then((result) => {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HomeScreen(
                                                       auth: Auth(), 
                                                    )),
                                            (Route<dynamic> route) => false),
                                       _nameController.clear(),
                                        _passwordController.clear(),
                                        _emailController.clear(),
                                     
                                        _addressController.clear()
                                      }));
    
     

  } 
  catch (e){
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
                          "Create Account",
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
                      height: 15.0,
                    ),
                    Container(
                      child: TextField(
                       controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          hintText: "Enter your name",
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
                        ),
                       
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      child: TextField( controller: _addressController,
                        decoration: InputDecoration(
                          labelText: "Land Address",
                          hintText: "Enter your land address",
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
                        ),
                       
                      ),
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
                        ),
                        
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
                        ),
                     
                        obscureText: true,
                      ),
                    ),
                    Container(
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
                                      '  CREATE ACCOUNT',
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