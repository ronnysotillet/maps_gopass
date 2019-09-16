import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gopass_demo_v2/SplashScreen.dart';
import 'package:gopass_demo_v2/MetodoPago.dart';

class AddCreditCard extends StatefulWidget{
  AddCreditCardState createState()=> AddCreditCardState();
}
class AddCreditCardState extends State<AddCreditCard> {


  bool checkValueTitular = true;
  bool showCvv = false;
  bool dialogIsShow =false;

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
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("Registrar Método de Pago"),
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
      ],),
    );
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
        await _getTargets();
        if(dialogIsShow){
          Navigator.pop(context);
        }
        Navigator.pop(context);
      }
    }catch(e){
      print(e);
    }
  }


  Future _getTargets()async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("===================Logueando======================");
      String url = "http://192.168.250.105/gopass-api/paymentmethod/list";
      var response = await http.post(url,body: {"uid":prefs.getString("uid")});
      print("===================Response======================");
      var jsonRes = json.decode(response.body);
      print(jsonRes);
      if(jsonRes["return"] && jsonRes["code"]==100){
        targets=jsonRes["data"];
        return 0;
      }else{

      }
    }catch(e){

    }
    return 0;
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



}





class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskedTextInputFormatter({
    @required this.mask,
    @required this.separator,
  }) {
    assert(mask != null);
    assert (separator != null);
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    if (newValue.text.length > 0) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length &&
            mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text: '${oldValue.text}$separator${newValue.text.substring(
                newValue.text.length - 1)}',
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

