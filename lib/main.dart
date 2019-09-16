import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gopass_demo_v2/register.dart';
import 'Csoon.dart';
import 'MetodoPago.dart';
import 'MisDatos.dart';
import 'MisVehiculos.dart';
import 'SplashScreen.dart';
import 'Transacciones.dart';
import 'addCreditCard.dart';
import 'addVehicle.dart';
import 'colferias.dart';
import 'contact.dart';
import 'login.dart';
import 'maps.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gopass Demo',
      //home: MyHomePage(),
      initialRoute: '/',
      routes: {
        '/':(context)=>Splash(),
        '/login':(context)=>Login(),
        '/home':(context)=>MyHomePage(),
        '/csoon':(context)=>ComicSoon(),
        '/colferias':(context)=>CF(),
        '/register':(context)=>Register(),
        '/contact':(context)=>Contact(),
        '/myVehicles':(context)=>MyVehicles(),
        '/paymentMethod':(context)=>PaymentMethod(),
        '/transactions':(context)=>Transactions(),
        '/myData':(context)=>MyData(),
        '/addVehicle':(context)=>AddVehicles(),
        '/addCreditCard':(context)=>AddCreditCard(),
      },
    );
  }

}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  Widget appBarTitle =Text("Gopass Demo", style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold));
  static GlobalKey<PrincipalMapState> mapGlobalKey = new GlobalKey<PrincipalMapState>();
  final TextEditingController _controllerText = new TextEditingController();
  Icon icon = new Icon(Icons.search, color: Colors.white);
  String name="",surname="",email="";
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _buildData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              onDetailsPressed: (){
                Navigator.pop(this.context);
                Navigator.pushNamed(context, '/myData');
              },
              accountName: Text(name+" "+surname),
              accountEmail: Text(email),
              decoration: BoxDecoration(color: Color.fromRGBO(3, 54, 71, 1)),
              currentAccountPicture: CircleAvatar(
                backgroundColor:  Colors.white,
                child: Image(image: AssetImage("assets/default_profile.png")),
                foregroundColor: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:20.0),
              child: Text("Vehiculos",style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              title: Text('Mis Vehiculos'),
              leading: Icon(Icons.directions_car),
              onTap: () {
                //_onSelectItem(1);
                Navigator.pop(this.context);
                Navigator.pushNamed(context, '/myVehicles');

              },
            ),
            Divider(
              color: Colors.blueGrey,
            ),
            Padding(
              padding: EdgeInsets.only(left:20.0),
              child: Text("Metodos de pago",style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              title: Text('Metodo de pago'),
              leading: Icon(Icons.credit_card),
              onTap: () {
                //goToTheLake();
                Navigator.pop(this.context);
                Navigator.pushNamed(context, '/paymentMethod');
              },
            ),
            ListTile(
              title: Text('Transacciones'),
              leading: Icon(Icons.account_balance),
              onTap: () {
                //_onSelectItem(3);
                Navigator.pop(this.context);
                Navigator.pushNamed(context, '/transactions');
              },
            ),
            Divider(
              color: Colors.blueGrey,
            ),
            Padding(
              padding: EdgeInsets.only(left:20.0),
              child: Text("Contacto",style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
            ListTile(
                title: Text('Contáctenos'),
                leading: Icon(Icons.phone),
                onTap: () {
                  Navigator.pop(this.context);
                  Navigator.pushNamed(context, '/contact');
                }
            ),
            Divider(
              color: Colors.blueGrey,
            ),
            Padding(
              padding: EdgeInsets.only(left:20.0),
              child: Text("Demostraciones",style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              title: Text('Corferias'),
              leading: Icon(Icons.mood),
              onTap: () {
                Navigator.pop(this.context);
                Navigator.pushNamed(context, '/colferias');
              },
            ),
            Divider(
              color: Colors.blueGrey,
            ),
            ListTile(
              title: Text('Salir'),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.pop(this.context);
                closeSession();
              },
            ),
          ],
        ),
      ),
      appBar: _buildAppBar(context),
      body: PrincipalMap(key:mapGlobalKey),
    );
  }

  _buildData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("nombres");
    surname=prefs.getString("apellidos");
    email=prefs.getString("correo");
    setState(() {});
  }

  _buildAppBar(BuildContext context) {
    return new AppBar(
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(
            icon: icon,
            onPressed: () {
              setState(() {
                if (this.icon.icon == Icons.search) {
                  this.icon = new Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  this.appBarTitle = new TextField(
                    onSubmitted: (address)async {
                      mapGlobalKey.currentState.showMyDialog();
                      await mapGlobalKey.currentState.getRoute(address);
                      setState(() {
                        _controllerText.clear();
                        //handlerRouting=false;
                        _handleSearchEnd();
                      });
                    },
                    controller: _controllerText,
                    autofocus: true,
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                        hintText: "Buscar...",
                        hintStyle: new TextStyle(color: Colors.white)),
                  );
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
          IconButton(
              icon: Icon(Icons.wb_sunny),
              onPressed: (){
                mapGlobalKey.currentState.changeStile();
              })
        ],

        backgroundColor: Color.fromRGBO(3, 54, 71, 1));
  }

  _handleSearchEnd() {
    setState(() {
      this.icon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      _controllerText.clear();
      this.appBarTitle = new Text(
        "Demo Gopass",
        style: new TextStyle(color: Colors.white),
      );
    });
  }

  closeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("uid","");
    prefs.setString("nombres", "");
    prefs.setString("apellidos", "");
    prefs.setString("correo", "");
    prefs.setString("telefono", "");
    prefs.setString("fechaRegistro", "");
    prefs.setString("token_validator", "");
    Navigator.of(context).pushReplacementNamed('/login');
  }
}


class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  SlideRightRoute({this.widget})
      : super(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return new SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      }
  );
}