import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class PushNotificationProvider {

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _messageStreamController = StreamController<String>.broadcast();

  Stream<String> get messages => _messageStreamController.stream;


  initNotifications() async{

    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure(
      onMessage: (info) async{
        print(info["data"]);
        print("=========== ON Message============");
        String argument ='no-data';
        argument = info['data']['tipo']+"-"+ info['data']['valor_transaccion']+"-"+info['data']['id_transaccion'] ?? 'nodata';
        _messageStreamController.sink.add(argument);
        print("HOLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
      },
      onLaunch: (info) async{
        print(info["data"]);
        print("=========== ON Message============");
        String argument ='no-data';
        argument = info['data']['tipo']+"-"+ info['data']['valor_transaccion']+"-"+info['data']['id_transaccion'] ?? 'nodata';
        _messageStreamController.sink.add(argument);
        print("HOLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
      },
      onResume: (info) async{
        print(info["data"]);
        print("=========== ON Message============");
        String argument ='no-data';
        argument = info['data']['tipo']+"-"+ info['data']['valor_transaccion']+"-"+info['data']['id_transaccion'] ?? 'nodata';
        _messageStreamController.sink.add(argument);
        print("HOLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
      }
    );
    getToken();


  }

  getToken()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await _firebaseMessaging.getToken();
    print("===================TOKEN PUSH FIREBASE===================");
    print(token);
    prefs.setString("token_push", token);
    try{
      if(prefs.getString("uid")!=""){
        sendResponseNotification(token);
      }
    }catch(e){}
  }

  Future sendResponseNotification(token)async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("===================Enviando Respuesta======================");
      String url = "http://192.168.250.105/gopass-api/client/tokenPush";
      var response = await http.post(url,body: {"uid":prefs.getString("uid")??"","tokenPush":token});
      print("===================Response======================");
      var jsonRes = json.decode(response.body);
      print(jsonRes);
      if(jsonRes["return"] && jsonRes["code"]==100){

      }
    }catch(e){

    }
  }
  dispose(){
    _messageStreamController.close();
  }



}
