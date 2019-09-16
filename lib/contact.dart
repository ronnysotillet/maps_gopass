import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' ;

class Contact extends StatefulWidget{
  ContactState createState()=> ContactState();
}
class ContactState extends State<Contact> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text("Contáctenos"),
            backgroundColor: Color.fromRGBO(3, 54, 71, 1)
        ),
        body: ListView(
          //alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            children: <Widget>[ Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 30,),child: Image(image: AssetImage("assets/ic_logocontact.png"),height: MediaQuery.of(context).size.height*0.3,),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.only(left: 30,right: 30),
                      child: Card(
                        color: Colors.grey[350],
                        child: ListTile(
                          onTap: (){
                            launch("tel:3116623665");
                          },
                          leading: Icon(Icons.phone,size: 40,color: Color.fromRGBO(3, 54, 71, 1),),
                          title: Text("Teléfono",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Color.fromRGBO(3, 54, 71, 1)),),
                          subtitle: Text("(311) 662 - 3665",style: TextStyle(fontStyle: FontStyle.italic)),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: EdgeInsets.only(left: 30,right: 30),
                      child: Card(
                        color: Colors.grey[350],
                        child: ListTile(
                          onTap: (){

                          },
                          leading: Icon(Icons.email,size: 40,color: Color.fromRGBO(3, 54, 71, 1)),
                          title: Text("E-mail",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Color.fromRGBO(3, 54, 71, 1)),),
                          subtitle: Text("info@gopass.com",style: TextStyle(fontStyle: FontStyle.italic),),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: EdgeInsets.only(left: 30,right: 30),
                      child: Card(
                        color: Colors.grey[350],
                        child: ListTile(
                          leading: Icon(Icons.web,size: 40,color: Color.fromRGBO(3, 54, 71, 1)),
                          title: Text("Página Web",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Color.fromRGBO(3, 54, 71, 1)),),
                          subtitle: Text("www.gopass.com.co",style: TextStyle(fontStyle: FontStyle.italic)),
                          onTap: (){

                          }
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            ])
    );
  }
}