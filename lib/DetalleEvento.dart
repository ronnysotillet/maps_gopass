import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'colferias.dart';

class EventDetail extends StatefulWidget{
  final String img;
  final String desc;
  final String date;
  final int index;
  final bool showQr;

  EventDetail(this.img,this.desc,this.date,this.index,this.showQr);

  @override
  EventDetailState createState() => EventDetailState();
}

class EventDetailState extends State<EventDetail>{
  @override
  Widget build(BuildContext context) {
    var asset = new AssetImage("assets/"+widget.img);



    final posterEvent= Container(
      height: 200,
      color: Color.fromRGBO(3, 54, 71, 1),
      padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
      child: Center(
        child: Card(
          elevation: 15.0,
          child: Hero(
            tag: widget.img,
            child: Image(image: asset),
          ),
        ),
      ),
    );
    final eventDescription = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(18.0), child: Text(widget.desc,style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold))),
          Center(
            child: Text(widget.date,style: TextStyle(fontSize: 12.0)),
          ),
          SizedBox(
            height: 30,
          ),
          _buildQr()
        ],
      )
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor:Color.fromRGBO(3, 54, 71, 1),
        centerTitle: true,
          title: Text("Detalles del evento"),
      ),
      backgroundColor: Colors.white ,
      body: ListView(
        children: <Widget>[
          posterEvent,
          eventDescription
        ],
      ),
      floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildButton()
    );
  }

  bool exist(){
    var aux = false;
    saved.forEach((el){
      if(el == widget.index){
        aux= true;
      }
    });
    return aux;
  }

  _buildQr(){
    if(widget.showQr){
      GlobalKey globalKey = new GlobalKey();
      return Column(
        children: <Widget>[
          Text("Redime tu Entrada con este codigo Qr",style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
          SizedBox(
            height: 15,
          ),
          Center(
            child: RepaintBoundary(
              key: globalKey,
              child: QrImage(
                data: widget.img,
                size: 300,
                backgroundColor: Colors.greenAccent,
                onError: (ex) {
                  print("[QR] ERROR - $ex");
                },
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
        ],
      );
    }else{
      return SizedBox(
        height: 50,
      );
    }
  }

  _buildButton() {

    if(exist()&&!widget.showQr){
      return FloatingActionButton.extended(
          onPressed: (){},
          backgroundColor: Colors.grey,
          label: Text("Comprado",style: TextStyle(fontSize: 18,color: Colors.black54)),
          icon: Icon(Icons.attach_money));
    }else if (!widget.showQr){
      return FloatingActionButton.extended(
          onPressed: (){
            setState(() {
              if(!exist()){
                counter++;
                saved.add(widget.index);
                //Navigator.pop(context);
                showDialog(context: context,builder: (b){
                  return _buildProgress();
                });
              }
            });
          },
          backgroundColor: Colors.green,
          label: Text("Comprar",style: TextStyle(fontSize: 26)),
          icon: Icon(Icons.attach_money));
    }else{
      return null;
    }
  }

  _buildProgress(){
    Timer(Duration(milliseconds: 3000),(){
      Navigator.pop(context);
      showDialog(context: context,builder: (b){
        return _buildDialog();
      });
    });
    return SimpleDialog(
      title: new Text("Procesando pago",textAlign: TextAlign.center),
      children: <Widget>[
        Center(
          child: new CircularProgressIndicator()
        ),
      ],
    );
  }

  _buildDialog(){
    GlobalKey globalKey = new GlobalKey();
    return SimpleDialog(
      title: new Text("Listo, Ya puedes redimir tu entrada!",textAlign: TextAlign.center),
      children: <Widget>[
        Center(
          child: RepaintBoundary(
            key: globalKey,
            child: QrImage(
              data: widget.img,
              size: 200,
              backgroundColor: Colors.greenAccent,
              onError: (ex) {
                print("[QR] ERROR - $ex");
              },
            ),
          ),
        ),
        RaisedButton(
          child: Text("Entendido",style: TextStyle(color: Colors.white),),
          onPressed: (){
            Navigator.pop(context);
          },
          color: Color.fromRGBO(3, 54, 71, 1),
        )
      ],
    );
  }

}

