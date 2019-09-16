import 'package:flutter/material.dart';
import 'DetalleEvento.dart';
import 'colferias.dart';


class MyEventList extends StatefulWidget{

  @override
  MyEventListState createState() => MyEventListState();
}

class MyEventListState extends State<MyEventList>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor:Color.fromRGBO(3, 54, 71, 1),
          centerTitle: true,
          title: Text("Mis eventos"),
        ),
        backgroundColor: Colors.white ,
        body: ListView(
          children: saved.map((i){
            var asset = new AssetImage("assets/"+eventsInfo.elementAt(i).elementAt(0));
            return Builder(
              builder: (BuildContext context){
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: Image(image: asset),
                      title: Text(eventsInfo.elementAt(i).elementAt(1),overflow: TextOverflow.ellipsis,),
                      subtitle: Text(eventsInfo.elementAt(i).elementAt(2)),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context)=>EventDetail(eventsInfo.elementAt(i).elementAt(0),eventsInfo.elementAt(i).elementAt(1),eventsInfo.elementAt(i).elementAt(2),i,true)
                            )
                        );
                      },
                    ),
                    Divider(
                      color: Colors.blueGrey,
                    )
                  ],
                );
              },
            );
          }).toList()
        ),
    );
  }
}

