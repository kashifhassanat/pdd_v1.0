import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_disease_detection/app/common_widget/CustomRaisedButton.dart';
import 'package:plant_disease_detection/app/services/auth.dart';

import 'homescreen.dart';

class Faq extends StatefulWidget {
 
  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  TextEditingController submitquery;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String name;
  String query;
  String email;
void _submit()async{
  try{   var firebaseUser = await FirebaseAuth.instance.currentUser();
    await Firestore.instance.collection("users")
    .document(firebaseUser.uid ).collection("query").add
    (
      {"Query": {
                                    
                               
                                'query': query,}})  
                                    .then((result) => {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HomeScreen(
                                                       auth: Auth(), 
                                                    )),
                                            (Route<dynamic> route) => false),
                                   
                                      });
    
     

  } 
  catch (e){
print(e.toString());
  }
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/bgimg.jpg'), fit: BoxFit.fill)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Expanded(
              child: Container(
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
                      // Container(
                      //   child: Container(
                      //     child: Text(
                      //       user.displayName,
                      //       style: TextStyle(
                      //           fontSize: 32.0, fontWeight: FontWeight.bold),
                      //     ),
                      //     alignment: Alignment.topLeft,
                      //   ),
                      // ),
                      RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: 'Welcome ',
                            style: TextStyle(
                              fontSize: 26.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            
                            style: TextStyle(
                              fontSize: 26.0,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(
                              text: 'Feel free to',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                    text: ' ask anything',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/faq.png'),
                              fit: BoxFit.contain),
                        ),
                        width: 500,
                        height: 200,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Form(
                        child: TextFormField(
                          controller: submitquery,
                          key: formkey,
                          autovalidate: true,
                          decoration: InputDecoration(
                            labelText: "Your Query",
                            hintText: "Enter your query",
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
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Required";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              query = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        height: 55.0,
                        child: CustomRaisedButton(
                            color: Color(0xFFB2002D),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Submit Query',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            onPressed: 
                            _submit
                            
                            ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
