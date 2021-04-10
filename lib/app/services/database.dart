
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:plant_disease_detection/app/services/api_path.dart';

// abstract class Database{
//   void readJobs();
// }

// class FirestoreDatabase implements Database{
//   final String uid;
//   FirestoreDatabase({@required this.uid}):
//    assert(uid !=null);

// void readJobs(){
//   final path= APIPath.users(uid);
//   final reference =Firestore.instance.collection(path);
// final snapshots=reference.snapshots();
// snapshots.listen((snapshot) {
//   snapshot.documents.forEach((snapshot) =>print(snapshot.data));
//  });
// }
// }