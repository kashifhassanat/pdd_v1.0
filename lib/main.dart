import 'package:flutter/material.dart';
import 'package:plant_disease_detection/app/screens/faq.dart';
import 'package:plant_disease_detection/app/screens/homescreen.dart';
import 'package:plant_disease_detection/app/screens/report.dart';
import 'package:plant_disease_detection/app/services/auth_provider.dart';
import 'package:plant_disease_detection/app/signin/default_page.dart';
import 'app/screens/detectimage.dart';
import 'app/services/auth.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    WidgetsApp.debugAllowBannerOverride=false; 
    return AuthProvider(
      auth: Auth(),
          child: MaterialApp(
  home: Report(),
      ),
    );
}
} 