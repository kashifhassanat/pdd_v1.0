
import 'package:flutter/material.dart';
import 'package:plant_disease_detection/app/screens/homescreen.dart';
import 'package:plant_disease_detection/app/screens/profile.dart';
import 'package:plant_disease_detection/app/services/auth.dart';
import 'package:plant_disease_detection/app/signin/default_page.dart';

class Landingpage extends StatelessWidget {
  final AuthBase auth;

  Landingpage({@required this.auth});


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: auth.onAuthstateChanged,
      builder: (context, snapshot){
if(snapshot.connectionState == ConnectionState.active){
User user= snapshot.data;

  if(user==null){
      
       return DefaultPage(
         auth: auth,
   
      
    );
    }
    return Profile(
      auth: auth, 
   
      
    );
}
else{
  return Scaffold(
    body:Center(
      child :CircularProgressIndicator(),
    ),
  );
}

    });
  
   
  }
}