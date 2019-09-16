import 'package:flutter/material.dart';

class ComicSoon extends StatefulWidget{
  ComicSoonState createState()=> ComicSoonState();
}
class ComicSoonState extends State<ComicSoon> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          title: Text("Proximamente"),
        ),
        body: Center(child: Text("Estamos trabajando en esto"))
    );
  }
}