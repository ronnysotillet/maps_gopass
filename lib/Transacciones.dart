import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Transactions extends StatefulWidget{
  TransactionsState createState()=> TransactionsState();
}
List<dynamic> transacctions =[];
class TransactionsState extends State<Transactions> {




  Future _getVehicles()async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("===================Logueando======================");
      String url = "http://192.168.250.105/gopass-api/transaction/list";
      var response = await http.post(url,body: {"uid":prefs.getString("uid"),"token":prefs.getString("token_validator")});
      print("===================Response======================");
      var jsonRes = json.decode(response.body);
      print(jsonRes);
      if(jsonRes["return"] && jsonRes["code"]==100){
        setState(() {
          transacctions=jsonRes["data"];
        });
      }else{

      }
    }catch(e){

    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getVehicles();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("Historial de Transacciones"),
          backgroundColor: Color.fromRGBO(3, 54, 71, 1)
      ),
      body: ListView(
          children: <Widget>[
            Column(
              children: transacctions.map((element){
                IconData myIcon = Icons.local_gas_station;
                if(element["servicio"]=="Gasolina"){
                  myIcon = Icons.local_gas_station;
                }else if(element["servicio"]=="Peaje"){
                  myIcon = Icons.directions;
                }else if(element["servicio"]=="Parqueadero"){
                  myIcon = Icons.local_parking;
                }else{
                  myIcon = Icons.monetization_on;
                }
                return Padding(
                  padding: EdgeInsets.all(10),
                  child:Container(
                    decoration: BoxDecoration(color: Colors.grey[350],borderRadius: BorderRadius.circular(5.0)),
                    child: Padding(padding: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Container(decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),child: Padding(padding: EdgeInsets.all(10),child: Icon(myIcon,color: Colors.white,),)),
                        title: Text("\$"+element["valor"].toString(),style: TextStyle(fontSize: 22),),
                        subtitle: Text("Placa:"+element["placa"]+"\nFecha: "+element["fecha"],maxLines: 2,overflow: TextOverflow.ellipsis,),
                        onTap: (){

                        },
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child:Container(
                decoration: BoxDecoration(color: Colors.grey[350],borderRadius: BorderRadius.circular(5.0)),
                child: Padding(padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Container(decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),child: Padding(padding: EdgeInsets.all(10),child: Icon(Icons.local_gas_station,color: Colors.white,),)),
                    title: Text("\$3220.00",style: TextStyle(fontSize: 22),),
                    subtitle: Text("Placa: ABC 123\nFecha: 09-09-2019 15:12:09",maxLines: 2,overflow: TextOverflow.ellipsis,),
                    onTap: (){

                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child:Container(
                decoration: BoxDecoration(color: Colors.grey[350],borderRadius: BorderRadius.circular(5.0)),
                child: Padding(padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Container(decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),child: Padding(padding: EdgeInsets.all(10),child: Icon(Icons.local_parking,color: Colors.white,),)),
                    title: Text("\$7000.00",style: TextStyle(fontSize: 22),),
                    subtitle: Text("Placa: ABC 123\nFecha: 09-09-2019 15:12:09",maxLines: 2,overflow: TextOverflow.ellipsis,),
                    onTap: (){

                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child:Container(
                decoration: BoxDecoration(color: Colors.grey[350],borderRadius: BorderRadius.circular(5.0)),
                child: Padding(padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Container(decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(5)),child: Padding(padding: EdgeInsets.all(10),child: Icon(Icons.confirmation_number,color: Colors.white,),)),
                    title: Text("\$120000.00",style: TextStyle(fontSize: 22),),
                    subtitle: Text("Evento: Expo Libro \nFecha: 09-09-2019 15:12:09",maxLines: 2,overflow: TextOverflow.ellipsis,),
                    onTap: (){

                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child:Container(
                decoration: BoxDecoration(color: Colors.grey[350],borderRadius: BorderRadius.circular(5.0)),
                child: Padding(padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Container(decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(5)),child: Padding(padding: EdgeInsets.all(10),child: Icon(Icons.security,color: Colors.white,),)),
                    title: Text("\$20000.00",style: TextStyle(fontSize: 22),),
                    subtitle: Text("Soat para el vehiculo: ABC 123 \nFecha: 09-09-2019 15:12:09",maxLines: 2,overflow: TextOverflow.ellipsis,),
                    onTap: (){

                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child:Container(
                decoration: BoxDecoration(color: Colors.grey[350],borderRadius: BorderRadius.circular(5.0)),
                child: Padding(padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Container(decoration: BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.circular(5)),child: Padding(padding: EdgeInsets.all(10),child: Icon(Icons.directions,color: Colors.white,),)),
                    title: Text("\$120000.00",style: TextStyle(fontSize: 22),),
                    subtitle: Text("Peaje para Vehiculo: ABC 123 \nFecha: 09-09-2019 15:12:09",maxLines: 2,overflow: TextOverflow.ellipsis,),
                    onTap: (){

                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child:Container(
                decoration: BoxDecoration(color: Colors.grey[350],borderRadius: BorderRadius.circular(5.0)),
                child: Padding(padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Container(decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),child: Padding(padding: EdgeInsets.all(10),child: Icon(Icons.local_gas_station,color: Colors.white,),)),
                    title: Text("\$322000.00",style: TextStyle(fontSize: 22),),
                    subtitle: Text("Placa: ABC 123\nFecha: 09-09-2019 15:12:09",maxLines: 2,overflow: TextOverflow.ellipsis,),
                    onTap: (){
                      print("hola");
                    },
                  ),
                ),
              ),
            ),
          ]
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
        icon: Icon(Icons.filter_list),
        label: Text("Filtrar"),
        backgroundColor: Color.fromRGBO(3, 54, 71, 1.0),
      ),
    );
  }
}
