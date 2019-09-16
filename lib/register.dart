import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:gopass_demo_v2/src/providers/push_notifications_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'package:gopass_demo_v2/SplashScreen.dart';


class Register extends StatefulWidget{
  RegisterState createState()=> RegisterState();
}
class RegisterState extends State<Register> {
  PageController pc = new PageController();

  TextEditingController docTargetType = new TextEditingController();


  String title = "Reistrar Datos Personales";
  bool checkValueProperty = true;
  bool checkValueTitular = true;
  int progressValue = 0;
  bool showCvv = false;
  bool dialogIsShow =false;

  //Controllers firs form
  TextEditingController docType = new TextEditingController();
  TextEditingController numberDocument = new TextEditingController();
  TextEditingController names = new TextEditingController();
  TextEditingController surnames = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();
  //Validators first form
  bool validatorDocType=true;
  bool validatorNumberDocument=true;
  bool validatorNames=true;
  bool validatorSurnames=true;
  bool validatorPhoneNumber=true;
  bool validatorEmail=true;
  bool validatorPassword=true;
  bool validatorConfirmPassword=true;

  //Controllers second form
  TextEditingController carType = new TextEditingController();
  TextEditingController plate = new TextEditingController();
  TextEditingController tag = new TextEditingController();
  TextEditingController propertyCar = new TextEditingController();
  //Validators second form
  bool validatorCarType=true;
  bool validatorPlate=true;
  bool validatorTag=true;
  bool validatorPropertyCar=true;

  //Controllers third form
  TextEditingController targetNumber = new TextEditingController();
  TextEditingController dateCard = new TextEditingController();
  TextEditingController cvv = new TextEditingController();
  TextEditingController docType2 = new TextEditingController();
  TextEditingController numberDocument2 = new TextEditingController();
  TextEditingController names2 = new TextEditingController();
  TextEditingController surnames2 = new TextEditingController();
  TextEditingController phoneNumber2 = new TextEditingController();
  TextEditingController email2 = new TextEditingController();
  TextEditingController typeCard = new TextEditingController();
  //Validators third form
  bool validatorDocType2=true;
  bool validatorNumberDocument2=true;
  bool validatorNames2=true;
  bool validatorSurnames2=true;
  bool validatorPhoneNumber2=true;
  bool validatorEmail2=true;
  bool validatorTargetNumber=true;
  bool validatorDateCard=true;
  bool validatorCVV=true;
  bool validatorTypeCard=true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final pushProvider = new PushNotificationProvider();
    pushProvider.getToken();
    setEmail();
  }

  setEmail()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email.text=prefs.getString("temporal_email")??"";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(title),
          backgroundColor: Color.fromRGBO(3, 54, 71, 1.0),
        ),
        body: Stack(
          children: <Widget>[
            PageView(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: pc,
              children: <Widget>[
                _buildFirst(),
                _buildSecond(),
                _buildThird()
              ],
            ),
            Align(
              alignment: Alignment(0, 1),
              child:Padding(padding: EdgeInsets.only(bottom: 10,left: 10,right: 10),child: FAProgressBar(
                currentValue: progressValue,
                animatedDuration: Duration(seconds: 1),
                size: 20,
                backgroundColor: Color.fromRGBO(3, 54, 71, 0.3),
                maxValue: 99,
                borderRadius: 5,
                changeColorValue: 60,
                changeProgressColor: Color.fromRGBO(101, 232, 71, 1.0),
                progressColor: Color.fromRGBO(3, 54, 71, 1.0),
              ),),
            )
          ],

        ),

    );
  }



  _buildFirst(){
    return  Scaffold(
        //backgroundColor: Colors.amber[50],
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
                  child: FloatingActionButton(onPressed: null,backgroundColor: Color.fromRGBO(3, 54, 71, 1.0), child: Icon(Icons.add,color: Colors.white,),mini: true,)
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
                style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
                cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
                decoration: InputDecoration(
                  labelText: "Tipo de Documento",
                  labelStyle: TextStyle(color: validatorDocType?Colors.blueGrey[400]:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                  focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                  prefixIcon: Icon(Icons.assignment_ind,color: validatorDocType?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
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
                controller:numberDocument,
                style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
                cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Numero de Documento",
                  labelStyle: TextStyle(color:  validatorNumberDocument?Colors.blueGrey[400]:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                  focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                  prefixIcon: Icon(Icons.assignment_ind,color: validatorNumberDocument?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
                  counterStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
                  //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30,right: 30),
            child: TextField(
              controller: names,
                style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
                cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: "Nombres",
                  labelStyle: TextStyle(color:validatorNames?Colors.blueGrey[400]:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                  focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                  prefixIcon: Icon(Icons.perm_identity,color: validatorNames?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
                  counterStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
                  //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30,right: 30),
            child: TextField(
              controller: surnames,
                style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
                cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: "Apellidos",
                  labelStyle: TextStyle(color: validatorSurnames?Colors.blueGrey[400]:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                  focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                  prefixIcon: Icon(Icons.perm_identity,color: validatorSurnames?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
                  counterStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
                  //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30,right: 30),
            child: TextField(
              controller: phoneNumber,
                style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
                cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Teléfono",
                  labelStyle: TextStyle(color: validatorPhoneNumber?Colors.blueGrey[400]:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                  focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                  prefixIcon: Icon(Icons.phone_android,color: validatorPhoneNumber?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
                  counterStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
                  //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30,right: 30),
            child: TextField(
              controller: email,
                style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
                cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Correo Electrónico",
                  labelStyle: TextStyle(color: validatorEmail?Colors.blueGrey[400]:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                  focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                  prefixIcon: Icon(Icons.email,color: validatorEmail?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
                  counterStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
                  //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30,right: 30),
            child: TextField(
              controller: password,
                obscureText: true,
                style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
                cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  labelStyle: TextStyle(color: validatorPassword?Colors.blueGrey[400]:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                  focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                  prefixIcon: Icon(Icons.enhanced_encryption,color: validatorPassword?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
                  counterStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
                  //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30,right: 30),
            child: TextField(
              controller: confirmPassword,
                obscureText: true,
                style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
                cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
                decoration: InputDecoration(
                  labelText: "Confirmar Contraseña",
                  labelStyle: TextStyle(color: validatorConfirmPassword?Colors.blueGrey[400]:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                  focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                  prefixIcon: Icon(Icons.lock,color: validatorConfirmPassword?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
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
                showMyDialog("Registrando usuario");
                validateInputs();
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
          SizedBox(height: 40,),

        ],)
      );//Center(child: RaisedButton(onPressed: (){pc.nextPage(duration: new Duration(milliseconds: 500),curve: Curves.decelerate);},child: Text("Ir al 2"),));
  }

  _buildSecond(){
    return  Scaffold(
      //backgroundColor: Colors.amber[50],
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

  _buildThird(){
    return  Scaffold(
      //backgroundColor: Colors.amber[50],
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
                        value: checkValueTitular,
                        activeColor: Color.fromRGBO(101, 232, 41, 1.0),
                        checkColor: Color.fromRGBO(3, 54, 71, 1.0),
                        onChanged: (bl){
                          setState(() {
                            checkValueTitular = !checkValueTitular;
                          });
                        }
                    ),
                    Text("Soy el titular de la tarjeta",style: TextStyle(color:Color.fromRGBO(3, 54, 71, 1.0),fontWeight:FontWeight.bold ) ,overflow: TextOverflow.fade)
                  ],
                ),
                _buildTit()
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30,right: 30),
            child: TextField(
              controller: targetNumber,
              style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
              cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
              keyboardType: TextInputType.number,
              inputFormatters: [
                MaskedTextInputFormatter(
                  mask: 'xxxx-xxxx-xxxx-xxxx',
                  separator: '-',
                ),
              ],
              decoration: InputDecoration(
                labelText: "Numero de la tarjeta",
                labelStyle: TextStyle(color: validatorTargetNumber?Colors.blueGrey[400]:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                prefixIcon: Icon(Icons.credit_card,color: validatorTargetNumber?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
                counterStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
                //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30,right: 30),
            child: TextField(
                controller: typeCard,
                readOnly: true,
                onTap: (){
                  showCreditCards();
                },
                style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
                cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
                decoration: InputDecoration(
                  labelText: "Franquicia",
                  labelStyle: TextStyle(color: validatorTypeCard?Colors.blueGrey[400]:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                  focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                  prefixIcon: Icon(Icons.credit_card,color: validatorTypeCard?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
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
                controller: dateCard,
                style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
                readOnly: true,
                onTap: (){
                  DatePicker.showDatePicker(context,dateFormat: "MMMM-yyyy",locale: DateTimePickerLocale.es,onConfirm: (time,a){
                    String mont = time.month.toString();
                    dateCard.value=TextEditingValue(text:((mont.length==1)?"0"+mont:mont)+"-"+time.year.toString());
                  });
                },
                cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
                decoration: InputDecoration(
                  labelText: "Fecha de Caducidad",
                  labelStyle: TextStyle(color: validatorDateCard?Colors.blueGrey[400]:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                  focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                  prefixIcon: Icon(Icons.calendar_today,color: validatorDateCard?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
                  counterStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
                  //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30,right: 30),
            child: TextField(
              controller: cvv,
                style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
                cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
                obscureText: !showCvv,
                keyboardType: TextInputType.number,
                maxLength: 3,
                decoration: InputDecoration(
                  labelText: "CVV",
                  labelStyle: TextStyle(color: validatorCVV?Colors.blueGrey[400]:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                  focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                  prefixIcon: Icon(Icons.lock,color: validatorCVV?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
                  counterStyle: TextStyle(color: Colors.white),
                  suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye,color: Colors.blueGrey,), onPressed: (){setState(() {
                    showCvv= !showCvv;
                  });}),
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
                //pc.nextPage(duration: new Duration(milliseconds: 500),curve: Curves.decelerate);
                showMyDialog("Registrando Método de pago");
                validateThird();
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

  _buildTit(){
    if(checkValueTitular){
      return Container();
    }else{
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 30,right: 30),
            child: TextField(
                controller: docType2,
                readOnly: true,
                onTap: (){
                  showDocOptions(docType2);
                },
                style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
                cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
                decoration: InputDecoration(
                  labelText: "Tipo de Documento",
                  labelStyle: TextStyle(color: validatorDocType2?Colors.blueGrey[400]:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                  focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                  prefixIcon: Icon(Icons.assignment_ind,color: validatorDocType2?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
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
              controller: numberDocument2,
              style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
              cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Numero de Documento",
                labelStyle: TextStyle(color: validatorNumberDocument2?Colors.blueGrey[400]:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                prefixIcon: Icon(Icons.assignment_ind,color: validatorNumberDocument2?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
                counterStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
                //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30,right: 30),
            child: TextField(
              controller: names2,
                style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
                cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: "Nombres",
                  labelStyle: TextStyle(color: validatorNames2?Colors.blueGrey[400]:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                  focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                  prefixIcon: Icon(Icons.perm_identity,color: validatorNames2?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
                  counterStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
                  //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30,right: 30),
            child: TextField(
              controller: surnames2,
                style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
                cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: "Apellidos",
                  labelStyle: TextStyle(color: validatorSurnames2?Colors.blueGrey[400]:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                  focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                  prefixIcon: Icon(Icons.perm_identity,color: validatorSurnames2?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
                  counterStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
                  //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30,left: 30,right: 30),
            child: TextField(
              controller: email2,
                style: TextStyle(color: Color.fromRGBO(3, 54, 71, 1.0),fontSize: 18.0,fontStyle: FontStyle.italic),
                cursorColor: Color.fromRGBO(101, 232, 41, 1.0),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Correo Electrónico",
                  labelStyle: TextStyle(color: validatorEmail2?Colors.blueGrey[400]:Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                  focusColor: Color.fromRGBO(101, 232, 41, 0.5),
                  prefixIcon: Icon(Icons.email,color: validatorEmail2?Color.fromRGBO(3, 54, 71, 1.0):Colors.red,),
                  counterStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0))),
                  //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                )
            ),
          )
        ],
      );
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
                    }).toList() /*<Widget>[
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
                    ]*/
                  )
              ),
            ]);
      },
    );
    // ignore: unrelated_type_equality_checks
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

  showCreditCards()async{
    await showDialog(
      context: context,
      builder:(b){
        return SimpleDialog(
            children: <Widget>[
              Center(
                  child: Column(
                      children: <Widget>[
                      ListTile(
                        title: Text("Visa",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 22),),
                        onTap: (){
                          typeCard.value=TextEditingValue(text:"Visa");
                          Navigator.pop(context);
                        },
                      ),
                      Divider(color: Colors.blueGrey,),
                      ListTile(
                          title: Text("Mastercard",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 22),),
                          onTap: (){
                            typeCard.value=TextEditingValue(text:"Mastercard");
                            Navigator.pop(context);
                          },
                        ),
                        Divider(color: Colors.blueGrey,),
                        ListTile(
                          title: Text("American Express",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 22),),
                          onTap: (){
                            typeCard.value=TextEditingValue(text:"American Express");
                            Navigator.pop(context);
                          },
                        ),
                        Divider(color: Colors.blueGrey,),
                    ],
                  )
              ),
            ]);
      },
    );
    // ignore: unrelated_type_equality_checks
  }

  resetValidatorsFirsForm(){
   validatorDocType=true;
   validatorNumberDocument=true;
   validatorNames=true;
   validatorSurnames=true;
   validatorPhoneNumber=true;
   validatorEmail=true;
   validatorPassword=true;
   validatorConfirmPassword=true;
  }

  resetValidatorsSecondForm(){
    validatorCarType=true;
    validatorPlate=true;
    validatorTag=true;
    validatorPropertyCar=true;
  }

  validateInputs(){
    int countErrors=0;
    resetValidatorsFirsForm();
    if(docType.text==""){
      countErrors++;
      validatorDocType=false;
    }
    if(numberDocument.text==""){
      countErrors++;
      validatorNumberDocument=false;
    }
    if(names.text==""){
      countErrors++;
      validatorNames=false;
    }
    if(surnames.text==""){
      countErrors++;
      validatorSurnames=false;
    }
    if(phoneNumber.text==""){
      countErrors++;
      validatorPhoneNumber=false;
    }
    if(email.text==""){
      countErrors++;
      validatorEmail=false;
    }
    if(password.text==""){
      countErrors++;
      validatorPassword=false;
    }
    if(confirmPassword.text==""){
      countErrors++;
      validatorConfirmPassword=false;
    }
    if(password.text!=confirmPassword.text){
      countErrors++;
      validatorPassword=false;
      validatorConfirmPassword=false;
    }
    setState(() {});
    if(countErrors==0){
      var bytes = utf8.encode(password.text); // data being hashed
      var criptoPass = sha1.convert(bytes);
      registerUser(docType.text,numberDocument.text,names.text,surnames.text,phoneNumber.text,email.text,criptoPass);
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
  resetValidatorsThirdForm(){
    validatorDocType2=true;
    validatorNumberDocument2=true;
    validatorNames2=true;
    validatorSurnames2=true;
    validatorPhoneNumber2=true;
    validatorEmail2=true;
    validatorTargetNumber=true;
    validatorDateCard=true;
    validatorCVV=true;
    validatorTypeCard=true;
  }

  validateThird()async{
    int countErrors=0;
    resetValidatorsThirdForm();
    if(targetNumber.text==""){
      countErrors++;
      validatorTargetNumber=false;
    }
    if(dateCard.text==""){
      countErrors++;
      validatorDateCard=false;
    }
    if(cvv.text==""){
      countErrors++;
      validatorCVV=false;
    }
    if(typeCard.text==""){
      countErrors++;
      validatorTypeCard=false;
    }

    var docType;
    var numberDoc;
    var email;
    var names;
    var surnames;
    if(!checkValueTitular){
      if(docType2.text==""){
        countErrors++;
        validatorDocType2=false;
      }else{
        docType=docType2.text;
      }
      if(numberDocument2.text==""){
        countErrors++;
        validatorNumberDocument2=false;
      }else{
        numberDoc=numberDocument2.text;
      }
      if(email2.text==""){
        countErrors++;
        validatorEmail2=false;
      }else{
        email=email2.text;
      }
      if(names2.text==""){
        countErrors++;
        validatorNames2=false;
      }else{
        names=names2.text;
      }
      if(surnames2.text==""){
        countErrors++;
        validatorSurnames2=false;
      }else{
        surnames=surnames2.text;
      }
    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      docType=prefs.getString("tipoDoc");
      numberDoc=prefs.getString("documento");
      email=prefs.getString("correo");
      names=prefs.getString("nombres");
      surnames=prefs.getString("apellidos");
    }
    setState(() {});
    if(countErrors==0){
      registerTarget(typeCard.text,targetNumber.text,dateCard.text,cvv.text,docType,numberDoc,email,names,surnames);
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

  Future registerUser(docType,nid,names,surnames,phoneNumber,email,password)async {
    try{
      String idDoc="0";
      docTypeGeneral.forEach((element){
        if(element["tipo"]==docType){
          idDoc=element["id"];
        }
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = "http://192.168.250.105/gopass-api/client/registre";
      print(prefs.getString("token_push"));
      var response = await http.post(url,body: {"tipoDocumento":idDoc.toString(),"numeroIdentificacion":nid,"nombres":names,"apellidos":surnames,"telefonoMovil":phoneNumber,"correo":email,"password":password.toString(),"key":"Lg%\$sdg/d6\$GSdgsgRRYg3GE","tokenPush":prefs.getString("token_push")??""});
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
        pc.nextPage(duration: new Duration(seconds: 1),curve: Curves.decelerate);
        setState(() {
          title="Registrar Vehículo";
          progressValue=33;
        });
        if(dialogIsShow){
          Navigator.pop(context);
        }
      }
    }catch(e){
      print(e);
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
        pc.nextPage(duration: new Duration(seconds: 1),curve: Curves.decelerate);
        setState(() {
          title="Registrar Vehículo";
          progressValue=66;
        });
        if(dialogIsShow){
          Navigator.pop(context);
        }
      }else{
        if(dialogIsShow){
          Navigator.pop(context);
        }
      }
    }catch(e){
      print(e);
    }
  }

  Future registerTarget(typeCard,numberTarget,dateCard,cvv,typeDoc,numberDoc,email,names,surnames)async {
    try{
      String idDoc=typeDoc??"1";
      docTypeGeneral.forEach((element){
        if(element["tipo"]==typeDoc){
          idDoc=element["id"];
        }
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = "http://192.168.250.105/gopass-api/paymentmethod/addCard";
      print({"uid":prefs.getString("uid"),"tipCard":typeCard,"tipDoc":idDoc.toString(),"name":names,"lastname":surnames,"numberDoc":numberDoc,"email":email,"dateCard":dateCard,"numberCard":numberTarget,"cvv":cvv});
      var response = await http.post(url,body: {"uid":prefs.getString("uid"),"tipCard":typeCard,"tipDoc":idDoc.toString(),"name":names,"lastname":surnames,"numberDoc":numberDoc,"email":email,"dateCard":dateCard,"numberCard":numberTarget,"cvv":cvv});
      print("===================Response======================");
      var jsonRes = json.decode(response.body);
      print(response.body);
      if(jsonRes["return"] && jsonRes["code"]==100){
        setState(() {
          title="Registrar Vehículo";
          progressValue=99;
        });
        if(dialogIsShow){
          Navigator.pop(context);
        }
        new Timer(const Duration(seconds: 2),()async{
          Navigator.of(context).pushReplacementNamed('/home');
        });
      }
    }catch(e){
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


class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskedTextInputFormatter({
    @required this.mask,
    @required this.separator,
  }) { assert(mask != null); assert (separator != null); }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text.length > 0) {
      if(newValue.text.length > oldValue.text.length) {
        if(newValue.text.length > mask.length) return oldValue;
        if(newValue.text.length < mask.length && mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text: '${oldValue.text}$separator${newValue.text.substring(newValue.text.length-1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }




}
