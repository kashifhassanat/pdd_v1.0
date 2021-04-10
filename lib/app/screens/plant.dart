import 'package:flutter/material.dart';

class PlantDiseaseViewScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(left: 10.0, right: 7,),
          alignment: Alignment.center,
          color: Colors.white10,
          child: FractionallySizedBox(
            heightFactor: 1.0,
              widthFactor: 1.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                    image: AssetImage('images/main.png'),
                        fit: BoxFit.fill),
                  ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('images/logo.png'),
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Plant Name:',
                        textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                    child: Text(
                      'Peanut',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    )
                )
              ],

            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Description:',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                    child: Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    )
                )
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Disease:',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                    child: Text(
                      'Lorem Ipsum',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    )
                )
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Pesticides:',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                    child: Text(
                      'Ipsum',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    )
                )
              ],
            ),
          ],
        )
      )
    )
    )
    );
  }
}