import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_disease_detection/app/common_widget/CustomRaisedButton.dart';
import 'package:plant_disease_detection/app/services/auth.dart';
import 'homescreen.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
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
                height: MediaQuery.of(context).size.width *
                    MediaQuery.of(context).devicePixelRatio,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0.7),
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
                            text: 'Disease Report ',
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
                      SizedBox(height: 12),
                      SizedBox(
                          height: 140.0,
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
                      SizedBox(height: 4),
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
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("Pesticides ",
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        height: 300,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                                width: 250.0,
                                child: Card(
                                  child: Wrap(
                                    children: [
                                      FittedBox(
                                        child: Image.asset(
                                          'images/cotton2.jpg',
                                          fit: BoxFit.fill,
                                          width: 300.0,
                                          height: 250.0,
                                        ),
                                      ),
                                      ListTile(
                                        title: Text("Kashif"),
                                        subtitle: Text("shahhhhh"),
                                      )
                                    ],
                                  ),
                                )),
                            Container(
                                width: 260.0,
                                child: Card(
                                  child: Wrap(
                                    children: [
                                      Image.asset(
                                        'images/cotton4.jpg',
                                        fit: BoxFit.fill,
                                        width: 300.0,
                                        height: 200.0,
                                      ),
                                      ListTile(
                                        title: Text("Kashif"),
                                        subtitle: Text("shahhhhh"),
                                      )
                                    ],
                                  ),
                                )),
                            Container(
                                width: 260.0,
                                child: Card(
                                  child: Wrap(
                                    children: [
                                      Image.asset(
                                        'images/cotton5.jpg',
                                        fit: BoxFit.fill,
                                        width: 300.0,
                                        height: 200.0,
                                      ),
                                      ListTile(
                                        title: Text("Kashif"),
                                        subtitle: Text("shahhhhh"),
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
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
