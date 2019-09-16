import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget{
  LoginState createState()=> LoginState();
}
class LoginState extends State<Login> {

  TextEditingController controllerEmail= TextEditingController();
  TextEditingController controllerPass= TextEditingController();

  bool validateEmail= true;
  bool validatePass=true;

  bool pass=false;
  bool showPass= false;
  bool dialogIsShow =false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  validateSession() async{
    Navigator.of(context).pushReplacementNamed('/home');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token =prefs.getString("token_validator")??"";
    print("========================TOKEN_VALIDATOR==============================");
    print(token);
    if(token!=""){

    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        //resizeToAvoidBottomInset: true,
        backgroundColor: Color.fromRGBO(59, 26, 49, 1.0),
        body:Stack(
          alignment: Alignment.center,
          overflow: Overflow.clip,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/background_login.png"),
                  fit: BoxFit.cover
                )
              ),
            ),
            Center(
              child: ListView(
                //alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  children: <Widget>[ Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 30,bottom: 30),child: Image(image: AssetImage("assets/gopass1.png"),height: MediaQuery.of(context).size.height*0.3,),),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(height: 40),
                          Text("Iniciar sesión / Registrarse",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.start,),
                          SizedBox(height: 10,),
                          Padding(
                            padding: EdgeInsets.only(left: 30,right: 30),
                            child: _buildTextField(),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: Padding(padding: EdgeInsets.only(left: 30,right: 30),child: FlatButton(
                              shape: new RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white, width: 1.0),
                                borderRadius: new BorderRadius.circular(5.0),
                              ),
                              onPressed: () {
                                setState(() {
                                  validateEmail=true;
                                  validateEmail=true;
                                });
                                if(!pass){
                                  if(controllerEmail.text!=""){
                                    showMyDialog("Comprobando Email");
                                    existUser(controllerEmail.text);
                                  }else{
                                    showDialog(
                                        context: context,
                                        builder:(b){
                                          return SimpleDialog(
                                              title: new Text("El campo no puede estar vacio",textAlign: TextAlign.center),
                                              children: <Widget>[
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
                                    setState(() {
                                      validateEmail=false;
                                    });
                                  }

                                }else{
                                  if(controllerPass.text!=""){
                                    var bytes = utf8.encode(controllerPass.text); // data being hashed
                                    var criptoPass = sha1.convert(bytes);
                                    showMyDialog("Iniciando sesión");
                                    goLogin(criptoPass);
                                  }else{
                                    showDialog(
                                        context: context,
                                        builder:(b){
                                          return SimpleDialog(
                                              title: new Text("El campo no puede estar vacio",textAlign: TextAlign.center),
                                              children: <Widget>[
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
                                    setState(() {
                                      validatePass=false;
                                    });
                                  }
                                }

                                //Navigator.of(context).pushReplacementNamed('/register');
                              },
                              color: Colors.white70,
                              child: Text(
                                "Continuar",
                                style: TextStyle(
                                  color: Colors.black54,//Color.fromRGBO(3, 54, 71, 0.7),
                                  fontSize: 18.0,
                                ),
                              ),
                            ),),
                          ),
                          _buildButtonGoBack(),
                          Container(
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: Padding(padding: EdgeInsets.only(left: 30,right: 30),child: FlatButton(
                              onPressed: () {},
                              color: Colors.transparent,
                              child: Text(
                                "¿Olvidaste tu contraseña?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),),
                          )
                        ],
                      )
                    ],
                  ),
                  ]),
            )
          ],
        )
    );
  }

  _buildButtonGoBack(){
    if(!pass){
      return SizedBox(height: 5,);
    }else{
      return Column(
        children: <Widget>[
          SizedBox(height: 5,),
          Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: Padding(padding: EdgeInsets.only(left: 30,right: 30),child: FlatButton(
              shape: new RoundedRectangleBorder(
                side: BorderSide(color: Colors.white, width: 1.0),
                borderRadius: new BorderRadius.circular(5.0),
              ),
              onPressed: () {
                pass=false;
                controllerPass.text="";
                setState(() {

                });
                //Navigator.of(context).pushReplacementNamed('/register');
              },
              color: Colors.white70,
              child: Text(
                "Volver",
                style: TextStyle(
                  color: Colors.black54,//Color.fromRGBO(3, 54, 71, 0.7),
                  fontSize: 18.0,
                ),
              ),
            ),),
          ),
          SizedBox(height: 5,)
        ],
      );
    }

  }

  _buildTextField(){
    if(!pass){
      return TextField(
          controller: controllerEmail,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: "Correo Electronico",
              hintStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 0.5), width: 1.0)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: validateEmail?Colors.white:Colors.red, width: 1.0)),
              focusColor: Color.fromRGBO(101, 232, 41, 0.5),
              prefixIcon: Icon(Icons.email,color: validateEmail?Colors.white:Colors.red,),
              counterStyle: TextStyle(color: Colors.white),
              fillColor: Colors.white30,
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
          )
      );
    }else{
      return TextField(
          controller: controllerPass,
          style: TextStyle(color: Colors.white),
          obscureText: !showPass,
          decoration: InputDecoration(
              hintText: "Contraseña",
              hintStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 0.5), width: 1.0)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: validatePass?Colors.white:Colors.red, width: 1.0)),
              focusColor: Color.fromRGBO(101, 232, 41, 0.5),
              suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye, color: validatePass?Colors.white:Colors.red,), onPressed: (){
                setState(() {
                  showPass= !showPass;
                });
              }),
              prefixIcon: Icon(Icons.lock,color: Colors.white,),
              counterStyle: TextStyle(color: Colors.white),
              fillColor: Colors.white30,
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
          )
      );
    }
  }




  Future existUser(email)async {
     try{
       SharedPreferences prefs = await SharedPreferences.getInstance();
      print("===================ExsistUser======================");
      String url = "http://192.168.250.105/gopass-api/client/search";
      var response = await http.post(url,body: {"email":email});
      print("===================Response======================");
      var jsonRes = json.decode(response.body);
      print(jsonRes);

      if(jsonRes["return"]){
        print("Solicitar Password");
        prefs.setString("uid", jsonRes["data"]["uid"]);
        setState(() {
          pass=true;
        });
        if(dialogIsShow){
          Navigator.pop(context);
        }
      }else{
        if(jsonRes["code"]==102){
          prefs.setString("temporal_email", email);
          if(dialogIsShow){
            Navigator.pop(context);
          }
          Navigator.pushNamed(context, '/register');
          print("Ir a registro");
        }else{
          if(dialogIsShow){
            Navigator.pop(context);
          }
          print("has error");
        }
      }
    }catch(e){
       if(dialogIsShow){
         Navigator.pop(context);
       }
    }

  }

  Future goLogin(pass)async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("===================Logueando======================");
      String url = "http://192.168.250.105/gopass-api/client/login";
      var response = await http.post(url,body: {"password":pass.toString(),"uid":prefs.getString("uid")});
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
        if(dialogIsShow){
          Navigator.pop(context);
        }
        Navigator.of(context).pushReplacementNamed('/home');
      }else{
        setState(() {
          validatePass=false;
        });
        if(dialogIsShow){
          Navigator.pop(context);
        }
      }
    }catch(e){
      if(dialogIsShow){
        Navigator.pop(context);
      }
      print(e);
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
