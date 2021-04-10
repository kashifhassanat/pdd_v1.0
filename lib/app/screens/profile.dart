import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:plant_disease_detection/app/common_widget/CustomRaisedButton.dart';
import 'package:plant_disease_detection/app/screens/detectimage.dart';
import 'package:plant_disease_detection/app/screens/faq.dart';
import 'package:plant_disease_detection/app/screens/homescreen.dart';
import 'package:plant_disease_detection/app/screens/login.dart';
import 'package:plant_disease_detection/app/screens/update_profile.dart';
import 'package:plant_disease_detection/app/services/auth.dart';
import 'package:plant_disease_detection/app/signin/default_page.dart';

const PRIMARY = "primary";
const WHITE = "white";

const Map<String, Color> myColors = {
  PRIMARY: Color.fromRGBO(55, 115, 138, 1),
  WHITE: Colors.white,
};

class Profile extends StatefulWidget {
  final AuthBase auth;
  Profile({@required this.auth, String uid, String title});
  @override
  _State createState() => _State();
}

class _State extends State<Profile> {
  final formKey = new GlobalKey();
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();

  Future<DocumentSnapshot> getUserInfo() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .get();
  }

  Future<void> _signOut() async {
    try {
      await widget.auth.signOut();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return DefaultPage(
          auth: Auth(),
        );
      }));
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Profile",
        ),
        leading: IconButton(
          onPressed: () {
            if (_drawerscaffoldkey.currentState.isDrawerOpen) {
              Navigator.pop(this.context);
            } else {
              _drawerscaffoldkey.currentState.openDrawer();
            }
          },
          icon: Icon(Icons.menu),
        ),
        actions: [
          FlatButton(
            onPressed: _signOut,
            child: Text(
              "Log Out",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: Scaffold(
        key: _drawerscaffoldkey,
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.lightGreen[100],
              height: MediaQuery.of(this.context).size.height,
              width: double.infinity,
              child: ListView(children: <Widget>[
                ListTile(
                  title: Text(
                    "Home",
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(Icons.home),
                  onTap: () {
                    Navigator.push(
                        this.context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                new HomeScreen(auth: Auth())));
                  },
                ),
                ListTile(
                  dense: true,
                  title: Text(
                    "Image",
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(Icons.image),
                  onTap: () {
                    Navigator.push(
                        this.context,
                        new MaterialPageRoute(
                            builder: (context) => new Tensorflow()));
                  },
                ),
                ListTile(
                  dense: true,
                  title: Text(
                    "Profiles",
                    style: TextStyle(color: Colors.black,
                    fontFamily: 'Roboto'),
                  ),
                  leading: Icon(Icons.person),
                  onTap: () {
                    Navigator.push(
                        this.context,
                        new MaterialPageRoute(
                            builder: (context) => new Profile(auth: Auth())));
                  },
                ),
              ]),
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/bgimg.jpg'), fit: BoxFit.fill)),
          child: ListView(
            /// crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
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
              FutureBuilder(
                future: getUserInfo(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
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
                                        child: Text(
                                          "Profile Details",
                                          style: TextStyle(
                                              fontSize: 32.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        alignment: Alignment.topCenter,
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Container(
                                        child: Text(
                                          "User Name",
                                          style: TextStyle(
                                              fontSize: 19.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        alignment: Alignment.bottomLeft,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Container(
                                          child: ButtonTheme(
                                        minWidth: 500.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          onPressed: () {},
                                          color: Colors.grey,
                                          child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                snapshot.data.data["fname"],
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16.0))),
                                        ),
                                      )),
                                      SizedBox(
                                        height: 12.0,
                                      ),
                                      Container(
                                        child: Text(
                                          "Land Address",
                                          style: TextStyle(
                                              fontSize: 19.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        alignment: Alignment.bottomLeft,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Container(
                                          child: ButtonTheme(
                                        minWidth: 500.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          onPressed: () {},
                                          color: Colors.grey,
                                          child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                snapshot.data.data["address"],
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16.0))),
                                        ),
                                      )),
                                      SizedBox(
                                        height: 12.0,
                                      ),
                                      Container(
                                        child: Text(
                                          "Email",
                                          style: TextStyle(
                                              fontSize: 19.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        alignment: Alignment.bottomLeft,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Container(
                                          child: ButtonTheme(
                                        minWidth: 500.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          onPressed: () {},
                                          color: Colors.grey,
                                          child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                snapshot.data.data["email"],
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16.0))),
                                        ),
                                      )),
                                      SizedBox(
                                        height: 12.0,
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 70.0),
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        '  Update Profile',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 19.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  onPressed: () => {
                                                        Navigator.push(
                                                            this.context,
                                                            new MaterialPageRoute(
                                                                builder: (context) =>
                                                                    new UpdateProfile(
                                                                        auth:
                                                                            Auth())))
                                                      }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return Text("No data");
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
