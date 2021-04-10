import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:plant_disease_detection/app/screens/detectimage.dart';
import 'package:plant_disease_detection/app/screens/faq.dart';
import 'package:plant_disease_detection/app/screens/profile.dart';
import 'package:plant_disease_detection/app/screens/update_profile.dart';
import 'package:plant_disease_detection/app/services/auth.dart';
import 'package:plant_disease_detection/app/signin/default_page.dart';

class HomeScreen extends StatefulWidget {
  final AuthBase auth;
  final String title;
  HomeScreen({@required this.auth, String uid, this.title});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();

  Future<DocumentSnapshot> getUserInfo() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildHomeScreen(),
    );
  }

 Future<void> _signOut() async {
    try {
      await widget.auth.signOut();
        Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return DefaultPage(auth: Auth(),);
                                      }));
    } catch (e) {
      print(e.toString());
    }
  }

  Widget buildHomeScreen() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Home"),
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
                child: FutureBuilder(
          future: getUserInfo(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(children: [
                      Container(
                        color: Colors.lightGreen[100],
                        height: MediaQuery.of(this.context).size.height,
                        width: double.infinity,
                        child: ListView(children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  this.context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          new Profile(auth: Auth())));
                            },
                            child: UserAccountsDrawerHeader(
                              decoration: BoxDecoration(
                                color: Colors.red,
                              ),
                              accountEmail: null,
                              accountName: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      'Welcome ',
                                      style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellowAccent),
                                    ),
                                    Text(
                                      snapshot.data.data["fname"],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellowAccent),
                                    )
                                  ],
                                ),
                              ),
                              currentAccountPicture: CircleAvatar(
                                backgroundColor: Colors.green,
                                backgroundImage: AssetImage(
                                  'images/farm.png',
                                ),
                              ),
                            ),
                          ),
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
                              "Query",
                              style: TextStyle(color: Colors.black),
                            ),
                            leading: Icon(Icons.image),
                            onTap: () {
                              Navigator.push(
                                  this.context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          new Faq ()));
                            },
                          ),
                          ListTile(
                            dense: true,
                            title: Text(
                              "Profile",
                              style: TextStyle(color: Colors.black),
                            ),
                            leading: Icon(Icons.person),
                            onTap: () {
                              Navigator.push(
                                  this.context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          new Profile(auth: Auth())));
                            },
                          ),
                        ]),
                      ),
                    ]);
                  });
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Text("No data");
            }
            return CircularProgressIndicator();
          },
        ))),
        body: ListView(
          children: <Widget>[
            SizedBox(
                height: 250.0,
                width: 360.0,
                child: Carousel(
                  images: [
                    ExactAssetImage("images/cotton1.jpg"),
                    ExactAssetImage("images/cotton2.jpg"),
                    ExactAssetImage("images/cotton4.jpg"),
                    ExactAssetImage("images/cotton5.jpg"),
                  ],
                  dotSize: 4.0,
                  dotSpacing: 15.0,
                  dotColor: Colors.lightGreenAccent,
                  indicatorBgPadding: 5.0,
                  dotBgColor: Colors.red.withOpacity(0.5),
                  borderRadius: true,
                  moveIndicatorFromBottom: 180.0,
                  noRadiusForIndicator: true,
                )),
            SizedBox(height: 10),
            Text(
              "Cotton ",
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Description ",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: 'Cotton ',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        'is the collective name given to four species of plants in the genus Gossypium, Gossypium hirsutum, Gossypium barbadense, Gossypium arboreum and Gossypium herbaceum which are perennial shrubs in the family Malvaceae grown for the fluffy fiber which protects the seeds of the plant. G. hirsutum accounts for approximately 90% of world wide cotton production today',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ]),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Propagation ",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: 'Basic requirements ',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        'Cotton is best grown in desert conditions using irrigation. The seeds will germinate optimally at 34°C (93.2°F), while the seedlings requires a temperature between 24 and 29°C (75.2–84.2°F) to grow and develop properly. Cotton will grow on a variety of soils including sandy soil and heavy clay as long as it is water permeable and will grow optimally in a soil with a pH of 5.5–8.5. In addition cotton has a high tolerance for salt.  ',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Common Diseases  ",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(height: 10),
            Text(
              "Alternaria leaf spot ",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
                height: 250.0,
                width: 360.0,
                child: Carousel(
                  images: [
                    ExactAssetImage("images/disease1.jpg"),
                    ExactAssetImage("images/disease2.jpg"),
                    ExactAssetImage("images/disease3.jpg"),
                  ],
                  dotSize: 4.0,
                  dotSpacing: 15.0,
                  dotColor: Colors.lightGreenAccent,
                  indicatorBgPadding: 5.0,
                  dotBgColor: Colors.green.withOpacity(0.5),
                  borderRadius: true,
                  moveIndicatorFromBottom: 180.0,
                  noRadiusForIndicator: true,
                )),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Symptoms",
                style: TextStyle(
                  fontSize: 19.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Small, circular brown lesions on cotyledons and seedling leaves which expand and develop a concentric pattern; necrotic areas coalesce and often have a purple margin; centers of lesions may dry out and drop form the plant creating a shot-hole appearance on the leaves.",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Cause",
                style: TextStyle(
                  fontSize: 19.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Fungus",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Comments",
                style: TextStyle(
                  fontSize: 19.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Plants stressed by drought, nutrient deficiency and other pests are more susceptible to the disease; fungus spreads rapidly in dense canopies, especially during periods of warm, wet weather.",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Management",
                style: TextStyle(
                  fontSize: 19.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Plow crop residue into the soil to reduce inoculum levels; provide plants with adequate irrigation and nutrients, particularly potassium; applications of appropriate foliar fungicides may be required on susceptible cultivars.",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        backgroundColor: Color(0xFFB2002D),
        onPressed: () {
          Navigator.push(
              this.context,
              new MaterialPageRoute(
                  builder: (context) => new Tensorflow()));
        },
      ),
    );
  }
}
