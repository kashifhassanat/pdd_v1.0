import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_disease_detection/app/common_widget/CustomRaisedButton.dart';
import 'package:plant_disease_detection/app/floatingbutton/speed_dialchild.dart';
import 'package:plant_disease_detection/app/floatingbutton/speeddial.dart';
import 'package:plant_disease_detection/app/screens/homescreen.dart';
import 'package:plant_disease_detection/app/screens/profile.dart';
import 'package:plant_disease_detection/app/services/auth.dart';
import 'package:tflite/tflite.dart';

class Tensorflow extends StatefulWidget {
  @override
  _TensorflowState createState() => _TensorflowState();
}

class _TensorflowState extends State<Tensorflow> {
  List _outputs;
  File _image;
  bool _loading = false;
  

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "model/model.tflite",
    labels: "model/model_labels.txt",
      numThreads: 1,
    );
  }

   Future classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
         imageMean: 0.0, 
        imageStd: 255.0, 
        numResults: 2, 
         threshold: 0.2, 
         asynch: true
        );
    setState(() {
      _loading = false;
      _outputs = output;

    });
  }
  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }



Future getImagefromGallery() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
 

  Future getImagefromcamera() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
  
  }
var text="diseased cotton leaf";

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildHomeScreen(),
    );
  }

Widget buildHomeScreen() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Image"),
        centerTitle: true,
      ),
      body: Center(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
               
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300.0,
                  child: Center(
                    child: _image == null
                        ? Text("Pick the image by tapping on the lower menu button", style: TextStyle(fontSize: 18))
                        : Image.file(_image), 
                  ),
                  
                ), 
                SizedBox(
                  height: 30.0,
                ), Container(
child: _image == null ? Container() : _outputs != null ? 
                  Text
                  (_outputs[0]["label"],
                  style: TextStyle
                  (color: Colors.black,fontSize: 20),
                  )  : Container(child: Text("")),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 150.0,
                    width: 80.0,
                    child: SingleChildScrollView(
                      child: CustomRaisedButton(
                        color: Color(0xFFB2002D),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              color: Colors.white,
                            ),
                            Text(
                              '  Detect Image',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        onPressed: ()=>classifyImage(_image)
                       
                      ),
                      ),    
                                        
                    ),
                    
                  ),
                  
                
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(color: Colors.white, size: 25),
        curve: Curves.bounceInOut,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Toggle',
        heroTag: 'toggele-hero-tag',
        backgroundColor: Color(0xFFB2002D),
        foregroundColor: Colors.white,
        overlayOpacity: 0.7,
        elevation: 10.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(
                Icons.camera,
                size: 24,
              ),
              backgroundColor: Colors.redAccent,
              label: 'Camera',
              labelStyle: TextStyle(
                fontSize: 18.0,
              ),
              onTap: () => getImagefromcamera()),
          SpeedDialChild(
              child: Icon(
                Icons.image,
                size: 24,
              ),
              backgroundColor: Colors.blueAccent,
              label: 'Gallary',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => getImagefromGallery()),
        ],
      ),
    );
  }



}