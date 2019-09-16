import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:gopass_demo_v2/src/providers/push_notifications_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart' as loc;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:angles/angles.dart';
import 'package:wakelock/wakelock.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrincipalMap extends StatefulWidget{
  PrincipalMap({Key key}):super(key:key);

  @override
  PrincipalMapState createState()=> PrincipalMapState();
}

class PrincipalMapState extends State<PrincipalMap> {
  ///Display Variables*********************************************************************************************************************
  static String strDuration = "0";
  static String strDistance = "0";
  static String strStartAddresses;
  static String strEndAddress;
  static String _destiny;

  ///Control Booleans**********************************************************************************************************************
  static bool visibleConfirmButton = false;
  static bool mark = false;
  static bool style = true;
  static bool handlerRouting = false;
  static bool indicator = false;
  static bool _showMessageNoGPS = false;
  static bool dialogIsShow = false;
  static bool speak = true;

  ///Map Variables*************************************************************************************************************************
  static final CameraPosition _kGoogle = CameraPosition(target: LatLng(4.628455, -74.112012), zoom: 14.4746,);
  static Completer<GoogleMapController> _controller = Completer();
  final List<PatternItem> patterns = List();
  static GoogleMapController mapController;
  static List<LatLng> segment = List();
  final Set<Polyline> _polyline = {};
  final Set<Marker> _markers = {};
  static double _bearing = 0.0;
  LatLng southwest, northeast;
  static var _currentLocation;
  static int counter = 0;
  static var _response;
  bool continue1=false;
  static var location;
  double distance=0;
  double duration=0;
  int countMax=0;
  List speaks;


  ///Constants***************************************************************************************************************************
  static final String night = '[{"elementType": "geometry","stylers": [{"color": "#1d2c4d"}]},{"elementType": "labels.text.fill","stylers": [{"color": "#8ec3b9"}]},{"elementType": "labels.text.stroke","stylers": [{"color": "#1a3646"}]},{"featureType": "administrative.country","elementType": "geometry.stroke","stylers": [{"color": "#4b6878"}]},{"featureType": "administrative.land_parcel","elementType": "labels.text.fill","stylers": [{"color": "#64779e"}]},{"featureType": "administrative.province","elementType": "geometry.stroke","stylers": [{"color": "#4b6878"}]},{"featureType": "landscape.man_made","elementType": "geometry.stroke","stylers": [{"color": "#334e87"}]},{"featureType": "landscape.natural","elementType": "geometry","stylers": [{"color": "#023e58"}]},{"featureType": "poi","elementType": "geometry","stylers": [{"color": "#283d6a"}]},{"featureType": "poi","elementType": "labels.text.fill","stylers": [{"color": "#6f9ba5"}]},{"featureType": "poi","elementType": "labels.text.stroke","stylers": [{"color": "#1d2c4d"}]},{"featureType": "poi.park","elementType": "geometry.fill","stylers": [{"color": "#023e58"}]},{"featureType": "poi.park","elementType": "labels.text.fill","stylers": [{"color": "#3C7680"}]},{"featureType": "road","elementType": "geometry","stylers": [{"color": "#304a7d"}]},{"featureType": "road","elementType": "labels.text.fill","stylers": [{"color": "#98a5be"}]},{"featureType": "road","elementType": "labels.text.stroke","stylers": [{"color": "#1d2c4d"}]},{"featureType": "road.highway","elementType": "geometry","stylers": [{"color": "#2c6675"}]},{"featureType": "road.highway","elementType": "geometry.stroke","stylers": [{"color": "#255763"}]},{"featureType": "road.highway","elementType": "labels.text.fill","stylers": [{"color": "#b0d5ce"}]},{"featureType": "road.highway","elementType": "labels.text.stroke","stylers": [{"color": "#023e58"}]},{"featureType": "transit","elementType": "labels.text.fill","stylers": [{"color": "#98a5be"}]},{"featureType": "transit","elementType": "labels.text.stroke","stylers": [{"color": "#1d2c4d"}]},{"featureType": "transit.line","elementType": "geometry.fill","stylers": [{"color": "#283d6a"}]},{"featureType": "transit.station","elementType": "geometry","stylers": [{"color": "#3a4762"}]},{"featureType": "water","elementType": "geometry","stylers": [{"color": "#0e1626"}]},{"featureType": "water","elementType": "labels.text.fill","stylers": [{"color": "#4e6d70"}]}]';
  static final String day = '[{"elementType": "geometry","stylers": [{"color": "#ebe3cd"}]},{"elementType": "labels.text.fill","stylers": [{"color": "#523735"}]},{"elementType": "labels.text.stroke","stylers": [{"color": "#f5f1e6"}]},{"featureType": "administrative","elementType": "geometry.stroke","stylers": [{"color": "#c9b2a6"}]},{"featureType": "administrative.land_parcel","elementType": "geometry.stroke","stylers": [{"color": "#dcd2be"}]},{"featureType": "administrative.land_parcel","elementType": "labels.text.fill","stylers": [{"color": "#ae9e90"}]},{"featureType": "landscape.natural","elementType": "geometry","stylers": [{"color": "#dfd2ae"}]},{"featureType": "poi","elementType": "geometry","stylers": [{"color": "#dfd2ae"}]},{"featureType": "poi","elementType": "labels.text.fill","stylers": [{"color": "#93817c"}]},{"featureType": "poi.park","elementType": "geometry.fill","stylers": [{"color": "#a5b076"}]},{"featureType": "poi.park","elementType": "labels.text.fill","stylers": [{"color": "#447530"}]},{"featureType": "road","elementType": "geometry","stylers": [{"color": "#f5f1e6"}]},{"featureType": "road.arterial","elementType": "geometry","stylers": [{"color": "#fdfcf8"}]},{"featureType": "road.highway","elementType": "geometry","stylers": [{"color": "#f8c967"}]},{"featureType": "road.highway","elementType": "geometry.stroke","stylers": [{"color": "#e9bc62"}]},{"featureType": "road.highway.controlled_access","elementType": "geometry","stylers": [{"color": "#e98d58"}]},{"featureType": "road.highway.controlled_access","elementType": "geometry.stroke","stylers": [{"color": "#db8555"}]},{"featureType": "road.local","elementType": "labels.text.fill","stylers": [{"color": "#806b63"}]},{"featureType": "transit.line","elementType": "geometry","stylers": [{"color": "#dfd2ae"}]},{"featureType": "transit.line","elementType": "labels.text.fill","stylers": [{"color": "#8f7d77"}]},{"featureType": "transit.line","elementType": "labels.text.stroke","stylers": [{"color": "#ebe3cd"}]},{"featureType": "transit.station","elementType": "geometry","stylers": [{"color": "#dfd2ae"}]},{"featureType": "water","elementType": "geometry.fill","stylers": [{"color": "#b9d3c2"}]},{"featureType": "water","elementType": "labels.text.fill","stylers": [{"color": "#92998d"}]}]';

  ///Search Variables*********************************************************************************************************************
  Widget appBarTitle =Text("Gopass Demo", style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold));
  final TextEditingController _controllerText = new TextEditingController();
  Icon icon = new Icon(Icons.search, color: Colors.white);
  final searchScaffoldKey = GlobalKey<ScaffoldState>();
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  Uint8List markerIcon;
  Uint8List markerIconActual;
  Uint8List markerIconEnd;

  ///Region Build*************************************************************************************************************************
  @override Widget build(BuildContext context) {
    _setIcon();
    return Stack(
      alignment: Alignment(0.0, -1.0),
      children: <Widget>[
        GoogleMap(
          onCameraMoveStarted: (){
            setState(() {
              indicator=false;
            });
          },
          mapType: MapType.normal,
          initialCameraPosition: _kGoogle,
          myLocationButtonEnabled: false,
          myLocationEnabled: false,
          polylines: _polyline,
          markers: _markers,

          onCameraMove: (CameraPosition a){
            //print(a);
          },
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
            mapController.setMapStyle(day);
            _controller.complete(mapController);
            setState(() {

            });
          },
        ),
        AnimatedOpacity(
            opacity: _showMessageNoGPS ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child:  Container(
                decoration: BoxDecoration(color: Colors.amber,borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0),bottomLeft: Radius.circular(10.0))),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Sin señal GPS, Mostrando ubicacion aproximada",style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(3, 54, 71, 1)),textAlign: TextAlign.center,),
                )
            )
        ),
        _buildLateralButtons(),
        _buildFloatingAction()
      ],
    );
  }

  changeCamera(LatLng cl)async{
    try{
      GoogleMapController controller = await _controller.future;
      await controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          bearing: _bearing,
          target: LatLng(cl.latitude, cl.longitude),
          tilt: 59.440717697143555,
          zoom: 19.151926040649414
      ))).then((a){
        setState(() {
          indicator=true;
        });
      });
      print("Tuvo que haberlo hecho");
    }catch(e){

    }

  }

  changeCameraDefault()async{
    GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: _bearing,
        target: LatLng(segment.elementAt(0).latitude, segment.elementAt(0).longitude),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414
    ))).then((a){
      setState(() {
        indicator=true;
      });
    });
    print("Tuvo que haberlo hecho");
  }

  _buildLateralButtons(){
    if(handlerRouting){
      return Align(
        alignment: Alignment(0.95, 0.0),
        child:Opacity(
          opacity: handlerRouting?1.0:0.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipOval(
                child: Material(
                  color: Color.fromRGBO(3, 54, 71, 1),
                  child: InkWell(
                    child: SizedBox(width: 40,height: 40,child: Icon(Icons.info_outline,size: 20, color:  Colors.blue)),
                    onTap: () {
                      showInfo();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipOval(
                child: Material(
                  color: Color.fromRGBO(3, 54, 71, 1),
                  child: InkWell(
                    child: SizedBox(width: 40,height: 40,child: Icon(Icons.clear,size: 20, color:  Color.fromRGBO(255, 0, 20, 1))),
                    onTap: () {
                      cancelRoute();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }else{
      return Align(
        alignment: Alignment(-0.9, 0.9),
        child:Opacity(
          opacity: visibleConfirmButton?1.0:0.0,
          child: Container(
            //color: Colors.amber,
            decoration: BoxDecoration(color: Colors.white,border: Border.all(width: 1.0,color: Colors.blueGrey),borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text("Distancia: "+strDistance+"\nDuracion: "+strDuration,style: TextStyle(fontStyle: FontStyle.italic,fontSize:26,fontWeight: FontWeight.bold,color:Color.fromRGBO(3, 54, 71, 1) )),
            ),
          ),
        ),
      );
    }
  }

  _buildFloatingAction(){
    if(!handlerRouting){
      if(visibleConfirmButton){
        return Align(
          alignment: Alignment(0.9, 0.9),
          child: Container(
              height: 400,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ClipOval(
                    child: Material(
                      color: Color.fromRGBO(3, 54, 71, 1),
                      child: InkWell(
                        child: SizedBox(width: 56,height: 56,child: Icon(Icons.directions_run,size: 40,color: Color.fromRGBO(101, 232, 41, 1))),
                        onTap: () {
                          initRouting();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ClipOval(
                    child: Material(
                      color: Color.fromRGBO(3, 54, 71, 1),
                      child: InkWell(
                        child:  SizedBox(width: 56,height: 56,child: Icon(Icons.clear,size: 40, color: Color.fromRGBO(255, 0, 20, 1))),
                        onTap: () {
                          cancelRoute();
                        },
                      ),
                    ),
                  ),
                ],
              )
          ),
        );
      }else{
        return Container();
      }
    }else{

      return Align(
        alignment: Alignment(0.0, 0.9),
        child: Container(
          //color: Colors.red,
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ClipOval(
                  child: Material(
                    color: Color.fromRGBO(3, 54, 71, 1),
                    child: InkWell(
                      child: SizedBox(width: 56,height: 56,child: Icon(Icons.my_location,size: 40,color: Color.fromRGBO(101, 232, 41, 1))),
                      onTap: () {
                        changeCamera(LatLng(segment.elementAt(0).latitude, segment.elementAt(0).longitude));
                        setState(() {
                          indicator=true;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  //color: Colors.amber,
                  decoration: BoxDecoration(color: Colors.white,border: Border.all(width: 1.0,color: Colors.blueGrey),borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text("Distancia: "+(((distance/1000).round()<=1)?"0.5":(distance/1000).round().toString())+" km\nDuracion: "+(((duration/60).round()<=1)?"0.5":(duration/60).round().toString())+" min",style: TextStyle(fontStyle: FontStyle.italic,fontSize:18,fontWeight: FontWeight.bold,color:Color.fromRGBO(3, 54, 71, 1) )),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: Color.fromRGBO(3, 54, 71, 1),
                        child: InkWell(
                          child: SizedBox(width: 40,height: 40,child: Icon(Icons.map,size: 20,color: Color.fromRGBO(101, 232, 41, 1))),
                          onTap: () {
                            setGeneralRoute();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ClipOval(
                      child: Material(
                        color: Color.fromRGBO(3, 54, 71, 1),
                        child: InkWell(
                          child: SizedBox(width: 40,height: 40,child: Icon(speak?Icons.volume_up:Icons.volume_off,size: 20, color:  Color.fromRGBO(101, 232, 41, 1))),
                          onTap: () {
                            setState(() {
                              speak = !speak;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
        ),
      );
    }
  }

  ///Region Initialization****************************************************************************************************************
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initLocalization();
    final pushProvider = new PushNotificationProvider();
    pushProvider.initNotifications();
    pushProvider.messages.listen((argument){
      print("Argumento=====================================================================");
      print(argument);
      showNotify(argument);
    });
  }

  _initLocalization()async{
    location = new loc.Location();
    markerIconActual=await getBytesFromAsset('assets/punto_actual.png', 100);
    _currentLocation = await location.getLocation();
    print("obtuvo la localizacion --\n-\n---\n-\n--\n---\n--\n------\n-------\n-\n------\n--------\n---\n-------\n-----\n----\n----\n-\n----\n-----\n----\n----\n---\n-----\n---\n----\n--\n--\n-----\n----\n------\n------\n----\n------------------------------------645465ca6s4c6a54c6a54sc65a4s3s5a1sc16asc546a\n");

    try{
      _showMessageNoGPS=(_currentLocation.accuracy>10.0);
      _markers.clear();
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId("actualPosition"),
        //_lastMapPosition is any coordinate which should be your default
        //position when map opens up
        visible: true,
        flat: true,
        anchor: Offset(0, 0.5),
        position: LatLng(_currentLocation.latitude, _currentLocation.longitude),
        icon: BitmapDescriptor.fromBytes(markerIconActual),
      ));
    }catch(e){
      print("error1--\n-\n---\n-\n--\n---\n--\n------\n-------\n-\n------\n--------\n---\n-------\n-----\n----\n----\n-\n----\n-----\n----\n----\n---\n-----\n---\n----\n--\n--\n-----\n----\n------\n------\n----\n------------------------------------645465ca6s4c6a54c6a54sc65a4s3s5a1sc16asc546a\n"+e.toString());
    }

    location.onLocationChanged().listen((loc.LocationData currentLocation) {
      if(segment.length>1){
        if(countMax<3 && distanceCalculate(segment.first.latitude, segment.first.longitude, currentLocation.latitude, currentLocation.longitude)>0.1){
          countMax++;
          continue1=false;
        }else{
          continue1=true;
        }
      }else{
        continue1=true;
      }
      if(continue1){
        countMax=0;
        _showMessageNoGPS=(currentLocation.accuracy>10.0);
        moveMarker(LatLng(currentLocation.latitude, currentLocation.longitude));
        if(segment.length>1){
          polylineStocks(LatLng(currentLocation.latitude, currentLocation.longitude));
        }
        _currentLocation = currentLocation;
      }
    });
  }

  _setIcon()async {
    markerIcon = await getBytesFromAsset('assets/direccion.png', MediaQuery.of(context).size.width*0.25);
  }

  /// Region trigonometry and geography***************************************************************************************************
  checkExceed(double xa,double ya, double xb, double yb,double xc,double yc){
    var ab = distanceCalculate(ya, xa, yb, xb);
    var bc = distanceCalculate(yb, xb, yc, xc);
    var ca = distanceCalculate(yc, xc, ya, xa);
    var alpha = Angle.fromRadians(acos((pow(ab,2)+pow(ca,2)-pow(bc,2))/(2*ca*ab))).degrees;
    var beta = Angle.fromRadians(acos((pow(ab,2)+pow(bc,2)-pow(ca,2))/(2*bc*ab))).degrees;

    if(alpha<90){//It pass the last point of the polyline
      if(beta>=90){//And also exceeded the second
        return 1;
      }else{//But It does't exceed the second
        return 0;
      }
    }else{//It has not reached the point yet
      return -1;
    }
  }

  getPoint(double y1,double x1, double y2, double x2,double yp,double xp){
    var m = getPending(x1, y1, x2, y2);
    double x =0;
    double y = 0;
    if(m==false){
      x = x1;
      y= yp;
    }else if(m!=0){
      double mp = (-1/m);
      x= (yp-y1+(m*x1)-(mp*xp))/(m-mp);
      y = yp+(mp*(x-xp));
    }else{
      x = xp;
      y= y2;
    }
    return LatLng(y,x);
  }

  distanceCalculate(double lat1,double lng1,double lat2, double lng2){
    var degrees = Angle.fromRadians(acos((sin(Angle.fromDegrees(lat1).radians)*sin(Angle.fromDegrees(lat2).radians)) + (cos(Angle.fromDegrees(lat1).radians)*cos(Angle.fromDegrees(lat2).radians)*cos(Angle.fromDegrees(lng1-lng2).radians)))).degrees;
    return degrees*111.13384;
  }

  getAngle(double lat1,double lng1,double lat2, double lng2){
    var addAngle=0;
    var multiple=1;
    if(lat1<=lat2 && lng1<=lng2){//0°
      addAngle=0;
    }else if(lat1>=lat2 && lng1<=lng2){//90°
      multiple=-1;
      addAngle=180;
    }else if(lat1>=lat2 && lng1>=lng2){//180°
      addAngle=180;
    }else if(lat1<=lat2 && lng1>=lng2){//270°
      multiple=-1;
    }
    var c=distanceCalculate(lat1,lng1,lat1,lng2);
    var b=distanceCalculate(lat1,lng1,lat2,lng2);
    var angle = Angle.fromRadians(asin(c/b)).degrees;
    return (angle*multiple)+addAngle;
  }

  getPending(double x1,double y1, double x2, double y2){
    if((x2-x1)!=0){
      return (y2-y1)/(x2-x1);
    }else{
      return false;
    }
  }


  ///Region Routes and Points*************************************************************************************************************
  Future getRouteBetweenCoordinates(double originLat, double originLong, String destination)async {
    String url = "https://maps.googleapis.com/maps/api/directions/json?origin=" +
        originLat.toString() +
        "," +
        originLong.toString() +
        "&destination=" +
        destination +
        "&language=es&mode=driving&key=AIzaSyCEp63F9yM27Y93zRHac4XzFciUkqTWhzg";
    var response = await http.get(url);
    _response= response.body;
    speaks=json.decode(_response)['routes'][0]['legs'][0]['steps'].toList();
    return _response;
  }

  _getPolyline(double originLat, double originLong, String destiny)async {
    try{
      var result = await getRouteBetweenCoordinates( originLat,originLong,destiny);
      //List response = json.decode(result)['routes'][0]['legs'][0]['steps'].toList();
      if(json.decode(result)['status']=='OK'){
        var response = json.decode(result)['routes'][0]['overview_polyline']["points"];
        segment.clear();
        List<PointLatLng> result1 = PolylinePoints().decodePolyline(response);
        int count=0;
        result1.forEach((el){
          count++;
          if(count==2){
            //_lastMapPosition=LatLng(el.latitude, el.longitude);
          }
          segment.add(LatLng(el.latitude, el.longitude));
        });
        southwest = new LatLng(json.decode(result)['routes'][0]['bounds']["southwest"]["lat"], json.decode(result)['routes'][0]['bounds']["southwest"]["lng"]);
        northeast = new LatLng(json.decode(result)['routes'][0]['bounds']["northeast"]["lat"], json.decode(result)['routes'][0]['bounds']["northeast"]["lng"]);
        //setState(() {
        strDistance=json.decode(_response)['routes'][0]['legs'][0]['distance']['text'];
        strDuration=json.decode(_response)['routes'][0]['legs'][0]['duration']['text'];
        distance = double.parse(json.decode(_response)['routes'][0]['legs'][0]['distance']['value'].toString());
        duration=double.parse(json.decode(_response)['routes'][0]['legs'][0]['duration']['value'].toString());
        //});
        await _addPolyLine();
        return LatLngBounds(southwest: southwest,northeast:northeast);
      }else{
        return false;
      }
    }catch(e) {
      print("Error-\n----\n----\n-----\n-------\n--------\n---------\n----\n---\n----\n---\n------\n-----\n---\n-----\n---\n----\n----\n---\n----\n---\n----\n----\n---\n-\n------\n--\n------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n----"+e.toString());
      return false;
    }
  }

  Future<void> getRoute(String destiny) async {
    _destiny = destiny;
    GoogleMapController controller = await _controller.future;
    try {
      _currentLocation = await location.getLocation();
      var bounds = await _getPolyline(_currentLocation.latitude, _currentLocation.longitude,destiny);
      if(dialogIsShow){
        Navigator.pop(context);
      }
      if(bounds!=false){
        controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
      }else{
        showDialog(
            context: context,
            builder:(b){
              return SimpleDialog(
                  title: new Text("No se encontro ninguna ruta,\n Vuelve a intentarlo",textAlign: TextAlign.center),
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
      }
      handlerRouting=false;
    } catch (e) {
      print("error:->");
      print(e);
    }
    return 0;
  }

  polylineStocks(LatLng curL) async {
    int exceed = checkExceed(segment.elementAt(0).longitude, segment.elementAt(0).latitude, segment.elementAt(1).longitude, segment.elementAt(1).latitude, curL.longitude, curL.latitude);
    switch(exceed){
      case -1:
        if(distanceCalculate(segment.elementAt(0).latitude, segment.elementAt(0).longitude, curL.latitude, curL.longitude)>0.05){
          await _getPolyline(curL.latitude, curL.longitude, _destiny);
          print("Cambio la ruta");
          if(speak){
            speakWords(speaks[0]["html_instructions"]);
          }
          //speakRoute(curL);
          if(indicator){
            _bearing=getAngle(segment.elementAt(0).latitude, segment.elementAt(0).longitude, segment.elementAt(1).latitude, segment.elementAt(1).longitude);
            print("Debio cambiar la camara");
            changeCamera(segment.elementAt(0));
          }
          return 0;
        }
        break;
      case 0:
        LatLng point = getPoint(segment.elementAt(0).latitude, segment.elementAt(0).longitude, segment.elementAt(1).latitude, segment.elementAt(1).longitude, curL.latitude, curL.longitude);
        var distance = distanceCalculate(point.latitude, point.longitude, curL.latitude, curL.longitude);
        if(distance>0.05){
          await _getPolyline(curL.latitude, curL.longitude, _destiny);
          print("Cambio la ruta");
          if(speak){
            speakWords(speaks[0]["html_instructions"]);
          }
          //speakRoute(curL);
          if(indicator){
            _bearing=getAngle(segment.elementAt(0).latitude, segment.elementAt(0).longitude, segment.elementAt(1).latitude, segment.elementAt(1).longitude);
            print("Debio cambiar la camara");
            changeCamera(segment.elementAt(0));
          }
          return 0;
        }
        speakRoute(curL);
        setState(() {
          segment.removeAt(0);
          segment.insert(0, point);
          _polyline.clear();
          _polyline.add(Polyline(
              polylineId: PolylineId('line1'),
              visible: true,
              points: segment,
              endCap: Cap.roundCap,
              width:5,
              startCap: Cap.customCapFromBitmap(BitmapDescriptor.fromBytes(markerIcon)),
              color:  Color.fromRGBO(101, 232, 41, 0.9)
            //color: Color.fromRGBO(101, 232, 41, 0.7)
          ));
          if(indicator){
            _bearing=getAngle(segment.elementAt(0).latitude, segment.elementAt(0).longitude, segment.elementAt(1).latitude, segment.elementAt(1).longitude);
            changeCamera(segment.elementAt(0));
          }
        });

        break;
      case 1:
        if(distanceCalculate(segment.elementAt(1).latitude, segment.elementAt(1).longitude, curL.latitude, curL.longitude)>0.05) {
          await _getPolyline(curL.latitude, curL.longitude, _destiny);
          if(speak){
            speakWords(speaks[0]["html_instructions"]);
          }
        }else {
          setState(() {
            segment.removeAt(0);
            _polyline.clear();
            _polyline.add(Polyline(
                polylineId: PolylineId('line1'),
                visible: true,
                points: segment,
                endCap: Cap.roundCap,
                width: 5,
                startCap: Cap.customCapFromBitmap(
                    BitmapDescriptor.fromBytes(markerIcon)),
                color: Color.fromRGBO(101, 232, 41, 0.9)
              //color: Color.fromRGBO(101, 232, 41, 0.7)
            ));
          });
          speakRoute(curL);
        }
        if (indicator) {
          _bearing = getAngle(segment
              .elementAt(0)
              .latitude, segment
              .elementAt(0)
              .longitude, segment
              .elementAt(1)
              .latitude, segment
              .elementAt(1)
              .longitude);
          changeCamera(segment.elementAt(0));
        }
        break;
    }
    if(distanceCalculate(segment.first.latitude, segment.first.longitude, segment.last.latitude, segment.last.longitude)<=0.03){
      cancelRoute();
      if(speak){
        speakWords("¡Haz llegado a tu destino!");
      }
      showDialog(
          context: context,
          builder:(b){
            return SimpleDialog(
                backgroundColor: Color.fromRGBO(3, 54, 71, 1.0),
                title: new Text("Felicidades!",style: TextStyle(color: Colors.white),textAlign: TextAlign.center),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text("Haz llegado a tu destino. \nRecuerda que los datos del viaje fueron suministrado por los serviciosd de google maps.", textAlign: TextAlign.start, style: TextStyle(color: Colors.white),),
                          SizedBox(height: 20,),
                          RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(101, 232, 41, 1.0),
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: const Text(
                                  'Aceptar',
                                  style: TextStyle(fontSize: 20, color: Colors.black)
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ]
            );
          }
      );
    }
  }

  moveMarker(LatLng position) {
    try{
      Marker mark = _markers.firstWhere((p)=>p.markerId==MarkerId("actualPosition"),orElse: ()=>null);
      if(mark !=null){
        setState(() {
          _markers.remove(mark);
          _markers.add(Marker(
            // This marker id can be anything that uniquely identifies each marker.
            markerId: MarkerId( "actualPosition"),
            //_lastMapPosition is any coordinate which should be your default
            //position when map opens up
            visible: true,
            flat: true,
            anchor: Offset(0.5, 0.5),
            rotation: _bearing,
            position: LatLng(position.latitude, position.longitude),
            icon: BitmapDescriptor.fromBytes(markerIconActual),
          ));
          //_markers.add(mark.copyWith(positionParam:position));
        });
      }
    }catch(e){}
  }

  setGeneralRoute() async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngBounds(LatLngBounds(southwest: southwest, northeast: northeast), 50));
  }

  speakRoute(LatLng curL){
    try{
      int exceed = checkExceed(speaks[0]["start_location"]["lng"], speaks[0]["start_location"]["lat"], speaks[0]["end_location"]["lng"], speaks[0]["end_location"]["lat"], curL.longitude, curL.latitude);
      switch(exceed){
        case 0:
          if(distanceCalculate(segment.elementAt(0).latitude, segment.elementAt(0).longitude, speaks[0]["end_location"]["lat"], speaks[0]["end_location"]["lng"])<0.03){
            if(speak){
              speakWords(speaks[1]["html_instructions"]);
            }
            setState(() {
              try{
                distance=distance-speaks[0]["distance"]["value"];
                duration=duration-speaks[0]["duration"]["value"];
              }catch(e){}
              speaks.removeAt(0);
            });
          }
          break;
        case 1:
          speaks.removeAt(0);
          break;
      }
    }catch(e){}
  }

  _addPolyLine ()async {
    _polyline.clear();
    markerIcon = await getBytesFromAsset('assets/direccion.png', 100);
    markerIconEnd = await getBytesFromAsset('assets/punto_llegada.png', 100);
    //setState(() {
    _polyline.add(Polyline(
        polylineId: PolylineId('line1'),
        visible: true,
        points: segment,
        endCap: Cap.roundCap,
        width:5,
        startCap: Cap.customCapFromBitmap(BitmapDescriptor.fromBytes(markerIcon)),
        color:  Color.fromRGBO(101, 232, 41, 0.9)
      //color: Color.fromRGBO(101, 232, 41, 0.7)
    ));
    _markers.clear();
    mark=true;
    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId("actualPosition"),
      //_lastMapPosition is any coordinate which should be your default
      //position when map opens up
      visible: true,
      flat: true,
      anchor: Offset(0.5, 0.5),
      rotation: _bearing,
      position: LatLng(_currentLocation.latitude, _currentLocation.longitude),
      icon: BitmapDescriptor.fromBytes(markerIconActual),
    ));
    _markers.add(Marker(
      markerId: MarkerId("end_location"),
      visible: true,
      position: LatLng(segment.last.latitude, segment.last.longitude),
      icon: BitmapDescriptor.fromBytes(markerIconEnd),
    ));
    visibleConfirmButton = true;
    setState(() {

    });
    _handleSearchEnd();
    //});
    return 0;
  }

  initRouting() async{
    Wakelock.enable();
    GoogleMapController controller = await _controller.future;
    _bearing=getAngle(segment.elementAt(0).latitude, segment.elementAt(0).longitude, segment.elementAt(1).latitude, segment.elementAt(1).longitude);
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: _bearing,// Camera orientation 0.0 ° is to the north and 90.0 to the south.
        target: LatLng(segment.elementAt(0).latitude, segment.elementAt(0).longitude),//The geographical location to which the camera points
        tilt: 59.440717697143555, //Inclination, 0.0 indicates that the camera is directly oriented to the ground
        zoom: 19.151926040649414 //Camera zoom level
    ))).then((a){
      indicator=true;
    });
    speaks = json.decode(_response)['routes'][0]['legs'][0]['steps'].toList();
    speakWords(speaks[0]["html_instructions"]);
    //setState(() {
    visibleConfirmButton =false;
    handlerRouting = true;
    strStartAddresses=json.decode(_response)['routes'][0]['legs'][0]['start_address'];
    strEndAddress=json.decode(_response)['routes'][0]['legs'][0]['end_address'];
    //});
  }

  cancelRoute()async {
    Wakelock.disable();
    GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 0.0,
        target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
        tilt: 0.0,
        zoom: 15.0
    )));
    Marker mark = _markers.firstWhere((p)=>p.markerId==MarkerId("end_location"),orElse: ()=>null);
    if(mark!=null){
      _markers.remove(mark);
      setState(() {
        segment.clear();
        indicator=false;
        visibleConfirmButton=false;
        handlerRouting=false;
      });
    }
  }

  ///Region Auxiliary*********************************************************************************************************************
  Future<Uint8List> getBytesFromAsset(String path, double width) async {
    try{
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width.floor());
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
    }catch(e){

    }
    return null;
  }

  speakWords(String words)async{
    FlutterTts flutterTts = new FlutterTts();
    await flutterTts.setVolume(1.0);
    await flutterTts.setLanguage("es");
    return await flutterTts.speak(escapeUnicode(words));
  }

  escapeUnicode(String data) {
    return data.replaceAll(RegExp('<([^>]*)>'), "")
        .replaceAll(RegExp('\\u00C1'), "Á")
        .replaceAll(RegExp('\\u00E1'), "á")
        .replaceAll(RegExp('\\u00C9'), "É")
        .replaceAll(RegExp('\\u00E9'), "é")
        .replaceAll(RegExp('\\u00CD'), "Í")
        .replaceAll(RegExp('\\u00ED'), "í")
        .replaceAll(RegExp('\\u00D3'), "Ó")
        .replaceAll(RegExp('\\u00F3'), "ó")
        .replaceAll(RegExp('\\u00DA'), "Ú")
        .replaceAll(RegExp('\\u00FA'), "ú")
        .replaceAll(RegExp('\\u00DC'), "Ü")
        .replaceAll(RegExp('\\u00FC'), "ü")
        .replaceAll(RegExp('\\u00D1'), "Ñ")
        .replaceAll(RegExp('\\u00F1'), "ñ")
        .replaceAll(RegExp('Nte\\s'), " Norte ")
        .replaceAll(RegExp('Cra\\s'), " Carrera ")
        .replaceAll(RegExp('Av\\s'), " Avenida ")
        .replaceAll(RegExp('Cll\\s'), " Calle ")
        .replaceAll(RegExp('Cl\\s'), " Calle ")
        .replaceAll(RegExp('Cr\\s'), " Carrera ")
        .replaceAll(RegExp('Kr\\s'), " Carrera ")
        .replaceAll(RegExp('Tv\\s'), " Transversal ")
        .replaceAll(RegExp('Dg\\s'), " Diagonal ")
        .replaceAll(RegExp('Nte\\.'), " Norte ")
        .replaceAll(RegExp('Cra\\.'), " Carrera ")
        .replaceAll(RegExp('Av\\.'), " Avenida ")
        .replaceAll(RegExp('Cll\\.'), " Calle ")
        .replaceAll(RegExp('Cl\\.'), " Calle ")
        .replaceAll(RegExp('Cr\\.'), " Carrera ")
        .replaceAll(RegExp('Kr\\.'), " Carrera ")
        .replaceAll(RegExp('Tv\\.'), " Transversal ")
        .replaceAll(RegExp('Dg\\.'), " Diagonal ")
        .replaceAll(RegExp('/'), "");

  }

  _handleSearchEnd() {
    //setState(() {
    this.icon = new Icon(
      Icons.search,
      color: Colors.white,
    );
    _controllerText.clear();
    this.appBarTitle = new Text(
      "Demo Gopass",
      style: new TextStyle(color: Colors.white),
    );
    //_isSearching = false;
    //_controller.clear();
    // });
  }

  showMyDialog()async{
    dialogIsShow =true;
    await showDialog(
      context: context,
      builder:(b){
        return SimpleDialog(
            title: new Text("Buscando Ruta",textAlign: TextAlign.center),
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

  changeStile()async{
    GoogleMapController controller = await _controller.future;
    if(style){
      style =false;
      controller.setMapStyle(night);
    }else{
      style =true;
      controller.setMapStyle(day);
    }
  }

  showInfo(){
    String start= escapeUnicode(strStartAddresses);
    String end= escapeUnicode(strEndAddress);
    showDialog(
        context: context,
        builder:(b){
          return SimpleDialog(
              backgroundColor: Color.fromRGBO(3, 54, 71, 1.0),
              title: new Text("Informacion de la ruta",style: TextStyle(color: Colors.white),textAlign: TextAlign.center),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(escapeUnicode("Dirección origen: "+start+" \n\nDirección destino: "+end+"\n\n"+"Duracion aproximada: "+strDuration+"\nDistancia aproximada: "+strDistance), textAlign: TextAlign.start, style: TextStyle(color: Colors.white),),
                        SizedBox(height: 20,),
                        RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(101, 232, 41, 1.0),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: const Text(
                                'Aceptar',
                                style: TextStyle(fontSize: 20, color: Colors.black)
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]
          );
        }
    );
  }


  showNotify(String data)async {
    try{
      var dataJson = data!="nodata"?data.split("-"):[];
      if(dataJson[0].toString()=="2"){
        await showDialog(
            context: context,
            barrierDismissible: false,
            builder:(b){
              return SimpleDialog(
                  backgroundColor: Colors.white,
                  title: new Text("Alerta de consumo",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),textAlign: TextAlign.center),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(escapeUnicode("Has realizado un consumo de gasolina por \$"+dataJson[1]+" pesos" ), textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,color: Colors.black87),),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                FlatButton(
                                  shape: new RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.red, width: 1.0),
                                    borderRadius: new BorderRadius.circular(5.0),
                                  ),
                                  onPressed: () {
                                    sendResponseNotification(dataJson[2],"3");
                                    Navigator.pop(context);
                                  },
                                  color: Colors.red,
                                  child: Text(
                                    "Cancelar",
                                    style: TextStyle(
                                      color: Colors.black,//Color.fromRGBO(3, 54, 71, 0.7),
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  shape: new RoundedRectangleBorder(
                                    side: BorderSide(color: Color.fromRGBO(101, 232, 41, 1.0), width: 1.0),
                                    borderRadius: new BorderRadius.circular(5.0),
                                  ),
                                  onPressed: () {
                                    sendResponseNotification(dataJson[2],"5");
                                    Navigator.pop(context);
                                  },
                                  color: Color.fromRGBO(101, 232, 41, 1.0),
                                  child: Text(
                                    "Aceptar",
                                    style: TextStyle(
                                      color: Colors.black,//Color.fromRGBO(3, 54, 71, 0.7),
                                      fontSize: 18.0,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ]
              );
            }
        );
      }
    }catch(e){}

  }

  Future sendResponseNotification(idTrans,status)async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("===================Enviando Respuesta======================");
      String url = "http://192.168.250.105/gopass-api/gasolina/accept";
      var response = await http.post(url,body: {"uid":prefs.getString("uid"),"key":"Lg%\$sdg/d6\$GSdgsgRRYg3GE","idtrans":idTrans,"status":status});
      print("===================Response======================");
      var jsonRes = json.decode(response.body);
      print(jsonRes);
      if(jsonRes["return"] && jsonRes["code"]==100){

      }
    }catch(e){

    }
  }

}