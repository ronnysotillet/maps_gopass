import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

List<dynamic> vehicles=[];

class MyVehicles extends StatefulWidget{
  MyVehiclesState createState()=> MyVehiclesState();
}
class MyVehiclesState extends State<MyVehicles> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getVehicles();
  }


  Future _getVehicles()async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("===================Logueando======================");
      String url = "http://192.168.250.105/gopass-api/vehiculo/list";
      var response = await http.post(url,body: {"uid":prefs.getString("uid"),"token":prefs.getString("token_validator")});
      print("===================Response======================");
      var jsonRes = json.decode(response.body);
      print(jsonRes);
      if(jsonRes["return"] && jsonRes["code"]==100){
        setState(() {
          vehicles=jsonRes["data"];
        });
      }else{

      }
    }catch(e){

    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text("Mis Vehículos"),
            backgroundColor: Color.fromRGBO(3, 54, 71, 1)
        ),
        body: ListView(
          children: vehicles.map((element){
            String img= "assets/carro.png";
            if(element["tipo"]=="AUTOMOVIL"){
              img= "assets/carro.png";
            }else if(element["tipo"]=="CAMIONETA"){
              img= "assets/camioneta.png";
            }else if(element["tipo"]=="MOTO"){
              img= "assets/moto.png";
            }else if(element["tipo"]=="CAMION"){
              img= "assets/camion.png";
            }
            return Padding(
              padding: EdgeInsets.all(10),
              child:Container(
                decoration: BoxDecoration(color: Colors.grey[350],borderRadius: BorderRadius.circular(5.0)),
                child: Padding(padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image(image: AssetImage(img)),
                    title: Text(element["tipo"],style: TextStyle(fontSize: 22),),
                    subtitle: Text(element["placa"]+"\nTag:"+element["tag"],maxLines: 2,overflow: TextOverflow.ellipsis,),
                  ),
                ),
              ),
            );
          }).toList()
        ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, '/addVehicle');
          },
          child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(3, 54, 71, 1.0),
          ),
    );
  }
}
