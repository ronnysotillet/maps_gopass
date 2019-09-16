import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gopass_demo_v2/SplashScreen.dart';
import 'package:gopass_demo_v2/MisVehiculos.dart';

class AddVehicles extends StatefulWidget{
  AddVehiclesState createState()=> AddVehiclesState();
}
class AddVehiclesState extends State<AddVehicles> {
  TextEditingController carType = new TextEditingController();
  TextEditingController plate = new TextEditingController();
  TextEditingController tag = new TextEditingController();
  TextEditingController propertyCar = new TextEditingController();
  bool dialogIsShow =false;
  //Validators second form
  bool validatorCarType=true;
  bool validatorPlate=true;
  bool validatorTag=true;
  bool validatorPropertyCar=true;
  bool checkValueProperty = true;



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("Registrar Vehículo"),
          backgroundColor: Color.fromRGBO(3, 54, 71, 1)
      ),
      body: ListView(children: <Widget>[
        Card(
          color: Colors.grey[350],//Color.fromRGBO(3, 54,71, 0.3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                      value: checkValueProperty,
                      activeColor: Color.fromRGBO(101, 232, 41, 1.0),
                      checkColor: Color.fromRGBO(3, 54, 71, 1.0),
                      onChanged: (bl){
                        setState(() {
                          checkValueProperty = !checkValueProperty;
                        });
                      }
                  ),
                  Text("Soy el propietario del vehiculo",style: TextStyle(color:Color.fromRGBO(3, 54, 71, 1.0),fontWeight:FontWeight.bold ) ,overflow: TextOverflow.fade)
                ],
              ),
              _buildProp()
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30,right: 30),
          child: TextField(
              controller: carType,
              readOnly: true,
              onTap: (){
                showCarOptions();
              },
              style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
              cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
              decoration: InputDecoration(
                labelText: "Tipo de Vehiculo",
                labelStyle: TextStyle(color: validatorCarType?Colors.blueGrey[400]:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                prefixIcon: Icon(Icons.directions_car,color: validatorCarType?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
                suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.blueGrey,),
                counterStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
                //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
              )
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 0,left: 30,right: 30),
          child: TextField(
            controller: plate,
            style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
            cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
            textCapitalization: TextCapitalization.characters,
            //maxLength: 6,
            decoration: InputDecoration(
              labelText: "Placa del Vehiculo",
              labelStyle: TextStyle(color: validatorPlate?Colors.blueGrey[400]:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
              focusColor: Color.fromRGBO(101, 232, 41, 0.5),
              prefixIcon: Icon(Icons.aspect_ratio,color: validatorPlate?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
              counterStyle: TextStyle(color: Colors.white),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
              //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0,left: 30,right: 30),
          child: TextField(
              controller: tag,
              style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
              cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
              decoration: InputDecoration(
                labelText: "Tag",
                labelStyle: TextStyle(color: validatorTag?Colors.blueGrey[400]:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                prefixIcon: Icon(Icons.local_offer,color: validatorTag?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
                counterStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
                //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
              )
          ),
        ),
        SizedBox(height: 20,),
        Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Padding(padding: EdgeInsets.only(left: 30,right: 30),child: FlatButton(
            shape: new RoundedRectangleBorder(
              side: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0), width: 1.0),
              borderRadius: new BorderRadius.circular(5.0),
            ),
            onPressed: () {
              showMyDialog("Registrando vehiculo");
              validateSecond();
              //Navigator.of(context).pushReplacementNamed('/register');
            },
            color: Color.fromRGBO(101, 232, 41, 0.8),
            child: Text(
              "Continuar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),),
        ),
        SizedBox(height: 20,)
      ],)
    );
  }

  resetValidatorsSecondForm(){
    validatorCarType=true;
    validatorPlate=true;
    validatorTag=true;
    validatorPropertyCar=true;
  }

  validateSecond()async{
    int countErrors=0;
    resetValidatorsSecondForm();
    if(carType.text==""){
      countErrors++;
      validatorCarType=false;
    }
    if(plate.text==""){
      countErrors++;
      validatorPlate=false;
    }
    if(tag.text==""){
      countErrors++;
      validatorTag=false;
    }
    var document;
    if(!checkValueProperty){
      if(propertyCar.text==""){
        countErrors++;
        validatorPropertyCar=false;
      }else{
        document=propertyCar.text;
      }
    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      document=prefs.getString("documento");
    }
    setState(() {});
    if(countErrors==0){
      registerCar(carType.text,plate.text,tag.text,document);
    }else{
      if(dialogIsShow){
        Navigator.pop(context);
      }
      showDialog(
          context: context,
          builder:(b){
            return SimpleDialog(
                title: new Text("Ha ocurrido un problema",textAlign: TextAlign.center),
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(20),
                    child: Text("Verifica los campos resaltados en rojo y vuelve a intentarlo"),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(3, 54, 71, 1.0),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: const Text(
                            'Aceptar',
                            style: TextStyle(fontSize: 20)
                        ),
                      ),
                    ),
                  ),
                ]
            );
          }
      );
    }
  }

  Future registerCar(carType,plate,tag,document)async {
    try{
      String idTypeCar="0";
      carTypeGeneral.forEach((element){
        if(element["tipo"]==carType){
          idTypeCar=element["id"];
        }
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = "http://192.168.250.105/gopass-api/vehiculo/registre";
      var response = await http.post(url,body: {"documento":document,"uid":prefs.getString("uid"),"tipo":idTypeCar.toString(),"placa":plate,"tag":tag,"token":prefs.getString("token_validator")??""});
      print("===================Response======================");
      print(response.body);
      var jsonRes = json.decode(response.body);
      if(jsonRes["return"] && jsonRes["code"]==100){
        await _getVehicles();
        if(dialogIsShow){
          Navigator.pop(context);
        }
        Navigator.pop(context);
      }else{
        if(dialogIsShow){
          Navigator.pop(context);
        }
      }
    }catch(e){
      print(e);
    }
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
          vehicles=jsonRes["data"];
          return 0;
      }else{

      }
    }catch(e){

    }
    return 0;
  }


  showCarOptions()async{
    await showDialog(
      context: context,
      builder:(b){
        return SimpleDialog(
            children: <Widget>[
              Center(
                  child: Column(
                      children: carTypeGeneral.map((element){
                        return ListTile(
                          title: Text(element["tipo"],style: TextStyle(fontStyle: FontStyle.italic,fontSize: 22),),
                          onTap: (){
                            carType.value=TextEditingValue(text:element["tipo"]);
                            Navigator.pop(context);
                          },
                        );
                      }).toList()/*<Widget>[
                      ListTile(
                        title: Text("Automóvil",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 22),),
                        onTap: (){
                          carType.value=TextEditingValue(text:"Automóvil");
                          Navigator.pop(context);
                        },
                      ),
                      Divider(color: Colors.blueGrey,),
                      ListTile(
                        title: Text("Camioneta",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 22)),
                        onTap: (){
                          carType.value=TextEditingValue(text:"Camioneta");
                          Navigator.pop(context);
                        },
                      ),
                      Divider(color: Colors.blueGrey,),
                      ListTile(
                        title: Text("Moto",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 22)),
                        onTap: (){
                          carType.value=TextEditingValue(text:"Moto",);
                          Navigator.pop(context);
                        },
                      ),
                      Divider(color: Colors.blueGrey,),
                      ListTile(
                        title: Text("Camión",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 22)),
                        onTap: (){
                          carType.value=TextEditingValue(text:"Camión",);
                          Navigator.pop(context);
                        },
                      ),
                      Divider(color: Colors.blueGrey,),
                      ListTile(
                        title: Text("Bus",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 22)),
                        onTap: (){
                          carType.value=TextEditingValue(text:"Bus",);
                          Navigator.pop(context);
                        },
                      ),
                      Divider(color: Colors.blueGrey,),
                      ListTile(
                        title: Text("Microbus",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 22)),
                        onTap: (){
                          carType.value=TextEditingValue(text:"Microbus",);
                          Navigator.pop(context);
                        },
                      ),
                      Divider(color: Colors.blueGrey,),
                      ListTile(
                        title: Text("Carga o Mixto",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 22)),
                        onTap: (){
                          carType.value=TextEditingValue(text:"Carga o Mixto",);
                          Navigator.pop(context);
                        },
                      ),
                      Divider(color: Colors.blueGrey,),
                      ListTile(
                        title: Text("Campero",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 22)),
                        onTap: (){
                          carType.value=TextEditingValue(text:"Campero",);
                          Navigator.pop(context);
                        },
                      ),
                      Divider(color: Colors.blueGrey,),
                      ListTile(
                        title: Text("Tractocamión",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 22)),
                        onTap: (){
                          carType.value=TextEditingValue(text:"Tractocamión",);
                          Navigator.pop(context);
                        },
                      ),
                      Divider(color: Colors.blueGrey,),
                      ListTile(
                        title: Text("Motocarro",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 22)),
                        onTap: (){
                          carType.value=TextEditingValue(text:"Motocarro",);
                          Navigator.pop(context);
                        },
                      )
                    ],*/
                  )
              ),
            ]);
      },
    );
    // ignore: unrelated_type_equality_checks
  }

  _buildProp(){
    if(checkValueProperty){
      return Container();
    }else{
      return Padding(
        padding: EdgeInsets.only(bottom: 30,left: 30,right: 30),
        child: TextField(
          controller: propertyCar,
          style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
          cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: "Numero de Documento del Propietario",
              labelStyle: TextStyle(color: validatorPropertyCar?Colors.blueGrey[400]:Colors.red, fontSize:12,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
              focusColor: Color.fromRGBO(101, 232, 41, 0.5),
              prefixIcon: Icon(Icons.assignment_ind,color: validatorPropertyCar?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
              counterStyle: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(3, 54, 71, 1.0)))
            //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
          ),
        ),
      );
    }
  }


  showMyDialog(String msg)async{
    dialogIsShow =true;
    await showDialog(
      context: context,
      builder:(b){
        return SimpleDialog(
            title: new Text(msg,textAlign: TextAlign.center),
            children: <Widget>[
              Center(
                  child: new CircularProgressIndicator()
              ),
            ]);
      },
      barrierDismissible: false,
    );
    // ignore: unrelated_type_equality_checks
    dialogIsShow =false;
  }
}


