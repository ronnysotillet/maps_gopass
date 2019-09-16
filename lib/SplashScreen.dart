import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

List<dynamic> carTypeGeneral;
List<dynamic> docTypeGeneral;

class Splash extends StatefulWidget{
  SplashState createState()=> SplashState();
}
class SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    new Timer(const Duration(seconds: 3),()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token =prefs.getString("token_validator")??"";
      print("========================TOKEN_VALIDATOR==============================");
      print(token);
      if(token!=""){
        Navigator.of(context).pushReplacementNamed('/home');
      }else{
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });

    getCarType();
    getDocType();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/ic_logocontact.png"),height: MediaQuery.of(context).size.height*0.3,),
              SizedBox(height: 10,),
              CircularProgressIndicator(backgroundColor: Colors.white, valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(101, 232, 41, 1.0)),),
              SizedBox(height: 10,),
              Text("Comprobando sesion")
            ],
          ),
        ),
    );
  }


  getDocType()async {
    try{
      String url = "http://192.168.250.105/gopass-api/tipo/documento";
      var response = await http.post(url);
      print("===================Response======================");
      var jsonRes = json.decode(response.body);
      print(jsonRes);
      if(jsonRes["return"]){
        docTypeGeneral = jsonRes["data"];
      }
    }catch(e){
      print(e);
    }
  }

  getCarType()async {
    try{
      String url = "http://192.168.250.105/gopass-api/tipo/vehiculo";
      var response = await http.post(url);
      print("===================Response======================");
      var jsonRes = json.decode(response.body);
      print(jsonRes);
      if(jsonRes["return"]){
        carTypeGeneral=jsonRes["data"];
      }
    }catch(e){
      print(e);
    }
  }
}