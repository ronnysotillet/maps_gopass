import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PaymentMethod extends StatefulWidget{
  PaymentMethodState createState()=> PaymentMethodState();
}
List<dynamic> targets=[];
class PaymentMethodState extends State<PaymentMethod> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTargets();
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
          setState(() {
            targets=jsonRes["data"];
          });
      }else{

      }
    }catch(e){

    }
  }

  Future _deleteCreditCard(idPay)async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("===================Logueando======================");
      String url = "http://192.168.250.105/gopass-api/paymentmethod/cancel";
      var response = await http.post(url,body: {"uid":prefs.getString("uid"),"idpay":idPay});
      print("===================Response======================");
      var jsonRes = json.decode(response.body);
      print(jsonRes);
      if(jsonRes["return"] && jsonRes["code"]==100){
        _getTargets();
      }else{
        //no se pudo eliminar
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
          title: Text("Métodos de pago"),
          backgroundColor: Color.fromRGBO(3, 54, 71, 1)
      ),
      body: ListView(
          children: targets.map((element){
            String img="assets/ic_visa.png";
            if(element["tipCard"]=="Visa"){
              img="assets/ic_visa.png";
            }else if(element["tipCard"]=="Mastercard"){
              img="assets/ic_master.png";
            }else if(element["tipCard"]=="American Express"){
              img="assets/ic_express.png";
            }
            return Padding(
                padding: EdgeInsets.all(10),
                child:Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      //decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/fondo_cc.jpg")),borderRadius: BorderRadius.circular(5.0)/*gradient: LinearGradient(colors: [Color.fromRGBO(50, 50, 50, 1.0),Colors.black], begin: Alignment(-0.5, -0.9), end: Alignment.bottomLeft)*/),
                      child: Image(image: AssetImage("assets/fondo3_cc.png")),

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[ Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width*0.2,
                        height: 30,
                        child: Padding(padding: EdgeInsets.only(top: 0,right: 0),child: FlatButton(
                          shape: new RoundedRectangleBorder(
                            side: BorderSide(color:Colors.transparent, width: 1.0),
                            borderRadius: new BorderRadius.circular(50.0),
                          ),
                          onPressed: () {
                            //Navigator.of(context).pushReplacementNamed('/register');
                          },
                          color: Colors.transparent,
                          child:IconButton(icon: Icon(Icons.remove_circle,color: Colors.red,size: 32,), onPressed: (){
                            _deleteCreditCard(element["idpay"]);
                          }),
                        ),),
                      )],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40,bottom: 10,right: 10,left: 10),
                      child:Container(
                          child:Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image(image: AssetImage("assets/chip_cc.png"),height: 40,width: 40,alignment: Alignment.bottomRight,),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("****",style:TextStyle(fontSize: 22,color: Colors.white,fontFamily: 'RobotoMono')),
                                  Text("****",style:TextStyle(fontSize: 22,color: Colors.white,fontFamily: 'RobotoMono')),
                                  Text("****",style:TextStyle(fontSize: 22,color: Colors.white,fontFamily: 'RobotoMono')),
                                  Text(element["lastNumber"],style:TextStyle(fontSize: 22,color: Colors.white,fontFamily: 'RobotoMono')),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text("***",style:TextStyle(color: Colors.white,fontFamily: 'RobotoMono')),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text("VALID\nTHRU",style:TextStyle(fontSize: 8,color: Colors.white,fontFamily: 'RobotoMono')),
                                          Icon(Icons.arrow_right,color: Colors.white,),
                                          Text("**-****",style:TextStyle(fontSize: 22,color: Colors.white,fontFamily: 'RobotoMono'))
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children:[ Padding(padding: EdgeInsets.all(10),child: Image(image: AssetImage(img),width: 80,alignment: Alignment.bottomRight,),),]
                              )
                            ],
                          )
                      ),
                    ),
                  ],
                )
            );
          }).toList()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/addCreditCard');
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(3, 54, 71, 1.0),
      ),
    );
  }
}
