import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gopass_demo_v2/SplashScreen.dart';
import 'package:http/http.dart' as http;

class MyData extends StatefulWidget{
  MyDataState createState()=> MyDataState();
}
class MyDataState extends State<MyData> {
  TextEditingController docType = new TextEditingController();
  TextEditingController numberDocument = new TextEditingController();
  TextEditingController names = new TextEditingController();
  TextEditingController surnames = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();


  bool editing = false;
  bool dialogIsShow =false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
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
      body: ListView(children: <Widget>[
        Center(
          child:Stack(
            alignment: Alignment(0.0, 0.8),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(30),
                child: Image(image: AssetImage("assets/default_profile.png"),height: MediaQuery.of(context).size.height*0.3,),
              ),
              Align(
                  alignment: Alignment(0.3, 0.8),
                  child: ClipOval(
                    child: Material(
                      color: Color.fromRGBO(3, 54, 71, 1),
                      child: InkWell(
                        child: SizedBox(width: 40,height: 40,child: Icon(Icons.add,size: 20, color:  Colors.white)),
                        onTap: () {
                        },
                      ),
                    ),
                  ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30,right: 30),
          child: TextField(
              controller: docType,
              readOnly: true,
              onTap: (){
                showDocOptions(docType);
              },
              enabled: editing,
              style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
              cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
              decoration: InputDecoration(
                labelText: "Tipo de Documento",
                labelStyle: TextStyle(color: Colors.blueGrey[400],fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                prefixIcon: Icon(Icons.assignment_ind,color: Color.fromRGBO(3, 54, 71, 1.0),),
                suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.blueGrey,),
                counterStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
                //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
              )
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30,right: 30),
          child: TextField(
            enabled: editing,
            controller: numberDocument,
            style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
            cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Numero de Documento",
              labelStyle: TextStyle(color: Colors.blueGrey[400],fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
              focusColor: Color.fromRGBO(101, 232, 41, 0.5),
              prefixIcon: Icon(Icons.assignment_ind,color: Color.fromRGBO(3, 54, 71, 1.0),),
              counterStyle: TextStyle(color: Colors.white),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
              //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30,right: 30),
          child: TextField(
              enabled: editing,
            controller: names,
              style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
              cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: "Nombres",
                labelStyle: TextStyle(color: Colors.blueGrey[400],fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                prefixIcon: Icon(Icons.perm_identity,color: Color.fromRGBO(3, 54, 71, 1.0),),
                counterStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
                //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
              )
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30,right: 30),
          child: TextField(
              enabled: editing,
              controller: surnames,
              style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
              cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: "Apellidos",
                labelStyle: TextStyle(color: Colors.blueGrey[400],fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                prefixIcon: Icon(Icons.perm_identity,color: Color.fromRGBO(3, 54, 71, 1.0),),
                counterStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
                //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
              )
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30,right: 30),
          child: TextField(
              enabled: editing,
            controller: phoneNumber,
              style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
              cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Teléfono",
                labelStyle: TextStyle(color: Colors.blueGrey[400],fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                prefixIcon: Icon(Icons.phone_android,color: Color.fromRGBO(3, 54, 71, 1.0),),
                counterStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
                //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
              )
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30,right: 30),
          child: TextField(
              enabled: editing,
            controller: email,
              style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
              cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Correo Electrónico",
                labelStyle: TextStyle(color: Colors.blueGrey[400],fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                prefixIcon: Icon(Icons.email,color: Color.fromRGBO(3, 54, 71, 1.0),),
                counterStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
                //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
              )
          ),
        ),
        _buildButtonEditing()

      ],),
      floatingActionButton: _buildFloatingAction()
    );
  }

  _buildFloatingAction(){
    if(!editing){
      return FloatingActionButton(

        onPressed: (){
          setState(() {
            editing=true;
          });
        },
        child: Icon(Icons.edit),
        backgroundColor: Color.fromRGBO(3, 54, 71, 1.0),
      );
    }else{
      return Container();
    }
  }

  showDocOptions(TextEditingController tec)async{
    await showDialog(
      context: context,
      builder:(b){
        return SimpleDialog(
            children: <Widget>[
              Center(
                  child: Column(
                    children: docTypeGeneral.map((element){
                      return ListTile(
                        title: Text(element["tipo"],style: TextStyle(fontStyle: FontStyle.italic,fontSize: 22),),
                        onTap: (){
                          tec.value=TextEditingValue(text:element["tipo"]);
                          Navigator.pop(context);
                        },
                      );
                    }).toList()/*<Widget>[
                      ListTile(
                        title: Text("Cédula de Ciudadanía",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 22),),
                        onTap: (){
                          tec.value=TextEditingValue(text:"Cédula de Ciudadania");
                          Navigator.pop(context);
                        },
                      ),
                      Divider(color: Colors.blueGrey,),
                      ListTile(
                        title: Text("Cédula de Extrangería",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 22)),
                        onTap: (){
                          tec.value=TextEditingValue(text:"Cédula de Extrangería");
                          Navigator.pop(context);
                        },
                      ),
                      Divider(color: Colors.blueGrey,),
                      ListTile(
                        title: Text("Pasaporte",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 22)),
                        onTap: (){
                          tec.value=TextEditingValue(text:"Pasaporte",);
                          Navigator.pop(context);
                        },
                      ),
                    ],*/
                  )
              ),
            ]);
      },
    );
    // ignore: unrelated_type_equality_checks
  }

  _buildButtonEditing(){
    if(!editing){
      return SizedBox(height: 80,);
    }else{
      return Column(
        children: <Widget>[
          SizedBox(height: 10,),
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
                showMyDialog("Actualizando datos");
                editUser(docType.text,numberDocument.text,names.text,surnames.text,phoneNumber.text,email.text);
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
          SizedBox(height: 10,),
          Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Padding(padding: EdgeInsets.only(left: 30,right: 30),child: FlatButton(
              shape: new RoundedRectangleBorder(
                side: BorderSide(color: Colors.red, width: 1.0),
                borderRadius: new BorderRadius.circular(5.0),
              ),
              onPressed: () {
                setState(() {
                  editing=false;
                });
                setData();
              },
              color: Colors.red,
              child: Text(
                "Cancelar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),),
          ),
          SizedBox(height: 40,),

        ],
      );
    }
  }

  setData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    names.text=prefs.getString("nombres");
    surnames.text=prefs.getString("apellidos");
    email.text=prefs.getString("correo");
    phoneNumber.text=prefs.getString("telefono");
    numberDocument.text=prefs.getString("documento");
    docTypeGeneral.forEach((element){
      if(element["id"]==prefs.getString("tipoDoc")){
        docType.text=element["tipo"];
      }
    });
    setState(() {});

  }
  Future editUser(docType,nid,names,surnames,phoneNumber,email)async {
    try{
      String idDoc="0";
      docTypeGeneral.forEach((element){
        if(element["tipo"]==docType){
          idDoc=element["id"];
        }
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = "http://192.168.250.105/gopass-api/client/edit";
      var response = await http.post(url,body: {"uid":prefs.getString("uid"),"tipoDocumento":idDoc.toString(),"numeroIdentificacion":nid,"nombres":names,"apellidos":surnames,"telefonoMovil":phoneNumber,"correo":email,"token":prefs.getString("token_validator"??"")});
      print("===================Response======================");
      var jsonRes = json.decode(response.body);
      print(jsonRes);
      if(jsonRes["return"] && jsonRes["code"]==100){
        prefs.setString("uid", jsonRes["data"]["uid"]);
        prefs.setString("nombres", jsonRes["data"]["nombres"]);
        prefs.setString("apellidos", jsonRes["data"]["apellidos"]);
        prefs.setString("correo", jsonRes["data"]["correo"]);
        prefs.setString("telefono", jsonRes["data"]["telefono"]);
        prefs.setString("fechaRegistro", jsonRes["data"]["fechaRegistro"]);
        prefs.setString("token_validator", jsonRes["data"]["token"]);
        prefs.setString("documento", jsonRes["data"]["documento"]);
        prefs.setString("tipoDoc", jsonRes["data"]["tipoDoc"]);
        setState(() {
          editing=false;
        });
      }
    }catch(e){
      print(e);
    }
    if(dialogIsShow){
      Navigator.pop(context);
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
