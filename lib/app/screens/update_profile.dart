import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:plant_disease_detection/app/common_widget/CustomRaisedButton.dart';
import 'package:plant_disease_detection/app/screens/homescreen.dart';
import 'package:plant_disease_detection/app/screens/profile.dart';
import 'package:plant_disease_detection/app/services/auth.dart';

const PRIMARY = "primary";
const WHITE = "white";

const Map<String, Color> myColors = {
  PRIMARY: Color.fromRGBO(55, 115, 138, 1),
  WHITE: Colors.white,
};

class UpdateProfile extends StatefulWidget {
  final AuthBase auth;

  UpdateProfile({@required this.auth});
  @override
  _State createState() => _State();
}

class _State extends State<UpdateProfile> {
  final formKey = new GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String get _name => _nameController.text;
  String get _email => _emailController.text;
  String get _address => _addressController.text;
  
  TextEditingController controller = TextEditingController();
  void updateUserName() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .updateData({
      "fname": _name,
    }).then((result) => {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile(
                            auth: Auth(),
                          )),
                  (Route<dynamic> route) => false),
              _nameController.clear(),
            });
  }

  void updateUserAddress() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .updateData({"address": _address}).then((result) => {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile(
                            auth: Auth(),
                          )),
                  (Route<dynamic> route) => false),
              _nameController.clear(),
            });
  }

  void updateUserEmail() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .updateData({
      "email": _email,
    }).then((result) => {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile(
                            auth: Auth(),
                          )),
                  (Route<dynamic> route) => false),
              _nameController.clear(),
            });
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
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    colors: [
                      Colors.lightGreenAccent,
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
                          "Update Account",
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
                    Container(
                      child: FlatButton(
                        onPressed: updateUserName,
                        child: Text(
                          "Change User Name",
                          style: TextStyle(
                              fontSize: 19.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                      alignment: Alignment.bottomRight,
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      child: TextField(
                        controller: _addressController,
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
                    Container(
                      child: FlatButton(
                        onPressed: updateUserAddress,
                        child: Text(
                          "Change User Adress",
                          style: TextStyle(
                              fontSize: 19.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                      alignment: Alignment.bottomRight,
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      child: TextField(
                        controller: _emailController,
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
                    Container(
                      child: FlatButton(
                        onPressed: updateUserEmail,
                        child: Text(
                          "Change User Email",
                          style: TextStyle(
                              fontSize: 19.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                      alignment: Alignment.bottomRight,
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        height: 55.0,
                        child: CustomRaisedButton(
                            color: Color(0xFFB2002D),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '  Cancel',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            onPressed: () => {
                                  Navigator.push(
                                      this.context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new Profile(auth: Auth())))
                                }),
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
