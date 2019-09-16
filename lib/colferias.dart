import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'DetalleEvento.dart';
import 'listaMisEventos.dart';

class CF extends StatefulWidget{
  CFState createState()=> CFState();
}

var eventsInfo = {
["Nextcar.png"," http://www.nextcar.com.co","Del 01 al 04 agosto 2019"],
["GranSalonInmobiliario.png","El  XIV Gran Salón Inmobiliario – Feria Internacional tiene como objetivo presentar durante 4 días, la más completa oferta de proyectos de inversión en activos inmobiliarios nuevos y usados, de tipo residencial, oficinas, hoteles, comerciales e industriales nacionales e internacionales. Ofrece en un solo lugar toda la oferta de valor y servicios complementarios, dinamizando la oferta y demanda del sector inmobiliario generando contactos efectivos y realización de negocios a corto y mediano plazo en un contexto donde el inversionista tiene la posibilidad de realizar negocios seguros y confiables.","Del 08 al 11 agosto 2019"],
["fedeopto.png","La cita académica, científica, educativa, gremial, comercial y de negocios más importante de la optometría de América Latina, el 17º Congreso Internacional de Optometría, 30º Congreso Nacional de Optometría y 12º Salón de la Óptica “Bogotá en la Mira de la Optometría Mundial” organizada por El Colegio Federación Colombiana de Optómetras - FEDOPTO. Contará con más de 3000 asistentes, más de 60 expositores, más de 100 marcas nacionales e internacionales, representando el mercado latinoamericano y mundial de la óptica y la optometría, en un área de más de 6000 mts2 de demostración de innovadores productos y un programa académico de conferencias altamente calificadas y especializadas.","Del 08 al 10 agosto 2019"],
["silverexpo.png","Es el Primer espacio comercial y vivencial en Bogotá, donde se exhibirán bajo un mismo lugar, productos y servicios orientados a la población de Adulto Mayor, con el fin de promover el bienestar y diversión de esta población. Es la oportunidad de ofrecer todo lo que despierta interés en este grupo objetivo, con la posibilidad de socializar con otros pares de su entorno, familiares y amigos.","Del 09 al 11 agosto 2019"],
["ifls.png","El International Footwear and Leather Show - IFLS y la Exhibición Internacional del Cuero e Insumos, maquinaria y tecnología - EICI, son la mayor plataforma de negocios de Colombia y la Región Andina donde fabricantes, compradores, diseñadores y proveedores de insumos se dan cita con la innovación, las tendencias y la moda para el sector.","Del 13 al 15 agosto 2019"],
["smartcity.png","El Instituto fue creado con el objetivo de promover e implementar el desarrollo de ciudades sostenibles y resilientes en América Latina, a través de importantes empresas y líderes internacionales que comparten sus experiencias en una gran muestra comercial, conferencias y foros con temas relacionados a proyectos Smart City. En Bogotá nos preparamos para recibir este 17, 18 y 19 de septiembre, el Smart City Business Colombia, el evento más importante en latinoamérica, en el desarrollo de conocimiento de ciudades inteligentes con una amplia agenda académica donde se dan a conocer y se discuten las últimas tendencias de las tecnologías, productos, soluciones y proyectos del presente y del futuro. Es el evento que ha generado los mayores y más efectivos negocios, alianzas e intercambios en el continente que posiciona a las empresas y organizaciones.","Del 17 al 19 septiembre 2019"],
["artbo.png","Durante cuatro días, la Feria Internacional de Arte de Bogotá convoca nacional e internacionalmente a galerías, curadores, artistas y público general en torno a una plataforma de relacionamiento comercial, que brinda una de las vitrinas culturales de más trascendencia en las artes plásticas en Colombia y convirtiéndose en el eje central del circuito artístico que tiene lugar durante el mes de octubre en Bogotá. A lo largo de los años, la ARTBO | Feria ha crecido gradualmente, manteniendo su cuidadosa selección de galerías en la sección Principal, así como su programa experimental que incluye espacios de formación de públicos, plataformas para artistas locales emergentes, y foros para la discusión del arte contemporáneo. Actualmente, la Feria Internacional de Arte de Bogotá es una de las plataformas más importantes de intercambio cultural e investigación: su enfoque en calidad y diversidad le han otorgado un lugar como una de las ferias más refrescantes y arriesgadas de América Latina. Es por ese motivo que se considera una de las visitas ineludibles en el circuito del arte a nivel mundial.","Del 18 al 22 septiembre 2019"],
["libraq.png","Feria Internacional del Libro de Barranquilla, hace parte de este plan de ciudad, en el que la cultura, -incluida la lectura-, se vive a puertas abiertas, en los espacios públicos, con acceso democrático para los ciudadanos, y que posicionará a la ciudad como capital regional del libro.","Del 18 al 22 septiembre 2019"],
["agrofuturo.png","Agrofuturo es una plataforma especializada de agronegocios que promueven la transferencia de tecnología, el conocimiento , la comercialización y la inversión en Colombia y Latinoamerica. Transformamos la visión de un agro tradicional hacia un agro empresarial.","Del 18 al 20 septiembre 2019"],
["digitech.png","DIGITECH será el espacio idóneo para que los pequeños, medianos y grandes empresarios descubran los distintos procesos de implantación de la creciente Industria 4.0, a través de espacios de conocimiento, innovación, interacción y negocios. Se presentarán tecnologías que están impulsando a las industrias en términos de competitividad y nuevos modelos de negocios, tales como la automatización industrial, el digital manufacturing, el Internet de las cosas, entre otros.","Del 18 al 20 septiembre 2019"],
["bellezaysalud.png","Belleza y Salud 2019 el evento reúne los mejores expertos y marcas nacionales e internacionales, quienes tendrán la oportunidad de interactuar en la mas completa plataforma de negocios para ingresar al mercado latinoamericano. Las marcas mas representativas se darán cita para mostrar a los visitantes los últimos productos, las nuevas tendencias y los avances relacionados con la Belleza integral para la mujer y el hombre moderno, complementado con actividades especiales y agenda académica donde se desarrollaran congresos, talleres, shows y zonas de experiencias. CIFRAS 2018 Visitantes 64.500 Expositores Más de 400 Área Comercializada Mas de 9.000 m² Mas de 10 delegaciones internacionales","Del 02 al 06 octubre 2019"],
["proflora.png","http://www.proflora.org.co","Del 02 al 05 octubre 2019"],
["fica.png","La Feria del Desarrollo Industrial del Caribe es la plataforma de contactos empresariales e industriales que fomenta el crecimiento e intercambio tecnológico y comercial de bienes y servicios para las industrias productivas de la región","Del 03 al 05 octubre 2019"]
};
List<int> saved = [];
var counter =0;

class CFState extends State<CF> with SingleTickerProviderStateMixin{
  GlobalKey globalKey = new GlobalKey();
  Animation<double> animation;
  AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return <Widget>[
            SliverAppBar(
              title:Text("Corferias"),
              //expandedHeight: MediaQuery.of(context).size.height,
              expandedHeight: MediaQuery.of(context).size.height,
              floating: true,
              pinned: true,
              backgroundColor: Color.fromRGBO(3, 54, 71, 1),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top:100.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                          padding:EdgeInsets.only(bottom: 10.0),
                          child: Text("Eventos Destacados",style: TextStyle(color: Colors.white)),
                          ),
                          Container(

                            height: MediaQuery.of(context).size.height*0.65,
                            alignment: Alignment.bottomCenter,
                            child: _buildCarouselSlider(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _buildLabel(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ];
        },
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: ListView(
            children: <Widget>[
              _buildListView("Agosto"),
              _buildListView("Septiembre"),
              _buildListView("Octubre")
            ],
          ),
        ),
        //_contentWidget()
      ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>MyEventList()
              ));
          },
          backgroundColor: Colors.green,
          label: Text(counter.toString()),
          icon: Icon(Icons.confirmation_number),
        )
    );

  }

  @override
  initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,

    ]);
    animationController = AnimationController(vsync: this,duration:Duration(milliseconds: 2500));
    animation = Tween<double>(begin: 0.0,end: 1.0).animate(animationController);
    animation.addStatusListener((status){
      if(status==AnimationStatus.completed){
        animationController.reset();
      }else if(status==AnimationStatus.dismissed){
        animationController.forward();
      }
    });
    animationController.forward();
  }

  @override
  dispose(){
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Widget _buildListView(String mont){
    ListView list = ListView();

    switch(mont){
      case "Agosto":
        list = ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Padding(
            padding: EdgeInsets.only(left: 6.0,right: 2.0),
            child: _buildListItem(eventsInfo.elementAt(0).elementAt(0),eventsInfo.elementAt(0).elementAt(1),eventsInfo.elementAt(0).elementAt(2),0),
            ),
            Padding(
              padding: EdgeInsets.only(left: 6.0,right: 2.0),
              child: _buildListItem(eventsInfo.elementAt(1).elementAt(0),eventsInfo.elementAt(1).elementAt(1),eventsInfo.elementAt(1).elementAt(2),1),
            ),
            Padding(
              padding: EdgeInsets.only(left: 6.0,right: 2.0),
              child: _buildListItem(eventsInfo.elementAt(2).elementAt(0),eventsInfo.elementAt(2).elementAt(1),eventsInfo.elementAt(2).elementAt(2),2),
            ),
            Padding(
              padding: EdgeInsets.only(left: 6.0,right: 2.0),
              child: _buildListItem(eventsInfo.elementAt(3).elementAt(0),eventsInfo.elementAt(3).elementAt(1),eventsInfo.elementAt(3).elementAt(2),3),
            ),
            Padding(
              padding: EdgeInsets.only(left: 6.0,right: 2.0),
              child: _buildListItem(eventsInfo.elementAt(4).elementAt(0),eventsInfo.elementAt(4).elementAt(1),eventsInfo.elementAt(4).elementAt(2),4),
            ),
          ]
        );
        break;
      case "Septiembre":
        list = ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 6.0,right: 2.0),
                child: _buildListItem(eventsInfo.elementAt(5).elementAt(0),eventsInfo.elementAt(5).elementAt(1),eventsInfo.elementAt(5).elementAt(2),5),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.0,right: 2.0),
                child: _buildListItem(eventsInfo.elementAt(6).elementAt(0),eventsInfo.elementAt(6).elementAt(1),eventsInfo.elementAt(6).elementAt(2),6),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.0,right: 2.0),
                child: _buildListItem(eventsInfo.elementAt(7).elementAt(0),eventsInfo.elementAt(7).elementAt(1),eventsInfo.elementAt(7).elementAt(2),7),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.0,right: 2.0),
                child: _buildListItem(eventsInfo.elementAt(8).elementAt(0),eventsInfo.elementAt(8).elementAt(1),eventsInfo.elementAt(8).elementAt(2),8),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.0,right: 2.0),
                child: _buildListItem(eventsInfo.elementAt(9).elementAt(0),eventsInfo.elementAt(9).elementAt(1),eventsInfo.elementAt(9).elementAt(2),9),
              ),
            ]
        );
        break;
      case "Octubre":
        list = ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 6.0,right: 2.0),
                child: _buildListItem(eventsInfo.elementAt(10).elementAt(0),eventsInfo.elementAt(10).elementAt(1),eventsInfo.elementAt(10).elementAt(2),10),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.0,right: 2.0),
                child: _buildListItem(eventsInfo.elementAt(11).elementAt(0),eventsInfo.elementAt(11).elementAt(1),eventsInfo.elementAt(11).elementAt(2),11),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.0,right: 2.0),
                child: _buildListItem(eventsInfo.elementAt(12).elementAt(0),eventsInfo.elementAt(12).elementAt(1),eventsInfo.elementAt(12).elementAt(2),12),
              ),
            ]
        );
        break;
    }


    return Container(
      height: 200.0,
      padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 7.0,bottom: 7.0),
            child: Text(mont,style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold,color:Colors.grey[400], decoration: TextDecoration.none)),
          ),
          Flexible(child: list)
        ],
      ),
    );
  }

  Widget _buildItem(String img,  String desc, String date,int index){
    var asset = new AssetImage("assets/"+img);
    return Material(
      elevation: 15.0,
      child: InkWell(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context)=>EventDetail(img,desc,date,index,false)
              )
          );
        },
        child: Hero(
          tag: img,
          child: Image(image: asset,width: 250.0,height: 105.0)/*Container(
            color: Colors.white,
            width: 250.0,
            height: 105.0,
            child: Icon(Icons.image),
          )*/,
          ),
        ),
      );
  }
  
  Widget _buildListItem(String img,String description, String date, int index)=>Material(
    child: Container(
      width: 258.0,
      decoration: BoxDecoration(
        color: Color.fromRGBO(3, 54, 71, 1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(6.0), child: _buildItem(img,description,date,index)),
          Padding(padding: EdgeInsets.only(left: 6.0,top:2.0),child: Text(description,style: TextStyle(color:Colors.white,fontSize: 8.0,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,)),
          Padding( padding: EdgeInsets.only(left: 6.0,top: 2.0),child:  Text(date,style: TextStyle(color:Colors.white,fontSize: 12.0),),),
        ],
      ),
    ),
  );

  Widget _buildCarouselSlider()=>CarouselSlider(
     items: <Widget>[
       _buildCarouselItem(eventsInfo.elementAt(1).elementAt(0),eventsInfo.elementAt(1).elementAt(1),eventsInfo.elementAt(1).elementAt(2),1),
       _buildCarouselItem(eventsInfo.elementAt(4).elementAt(0),eventsInfo.elementAt(4).elementAt(1),eventsInfo.elementAt(4).elementAt(2),4),
       _buildCarouselItem(eventsInfo.elementAt(6).elementAt(0),eventsInfo.elementAt(6).elementAt(1),eventsInfo.elementAt(6).elementAt(2),6),
       _buildCarouselItem(eventsInfo.elementAt(7).elementAt(0),eventsInfo.elementAt(7).elementAt(1),eventsInfo.elementAt(7).elementAt(2),7),
       _buildCarouselItem(eventsInfo.elementAt(10).elementAt(0),eventsInfo.elementAt(10).elementAt(1),eventsInfo.elementAt(10).elementAt(2),10),

     ],
     autoPlay: true,
     height: MediaQuery.of(context).size.height*0.7,
     viewportFraction: 0.9,
     enlargeCenterPage: true,

   );

  _buildCarouselItem(String img, String desc, String date, int index){
     var asset = new AssetImage("assets/"+img);
     return Container(
         height: MediaQuery.of(context).size.height,
         width: MediaQuery.of(context).size.width,
         margin: EdgeInsets.symmetric(horizontal: 5.0),
         decoration: BoxDecoration(
             color: Colors.green
         ),
         child: Column(
           children: <Widget>[
              Container(
               color: Colors.white,
               child:Image(image:asset,width: 500.0,height: 170.0),
             ),
             Padding(padding: EdgeInsets.all(10.0),
                child: Text(desc,maxLines: 6, style: TextStyle(fontSize: 12.0),textAlign: TextAlign.justify,overflow: TextOverflow.ellipsis)),
             Padding(
               padding: EdgeInsets.only(top: 5),
               child: Text(date),
             ),
             RaisedButton(
               onPressed: () {
                 Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context)=>EventDetail(img,desc,date,index,false)
                     )
                 );
               },
               color: Colors.blue,
               textColor: Colors.white,
               padding: const EdgeInsets.all(0.0),
               child: Container(
                 color: Colors.blue,
                 padding: const EdgeInsets.all(7.0),
                 child: const Text(
                     'Ver mas',
                     style: TextStyle(fontSize: 20)
                 ),
               ),

             )
           ],
         )
     );
   }

  Widget _buildLabel(){
    return  AnimatedLogo(animation: animation);
  }
}

class AnimatedLogo extends AnimatedWidget{

  final Tween<double> _sizeAnim = Tween<double>(begin: 20.0,end:0.0);
  AnimatedLogo({Key key, Animation animation}):super(key:key,listenable:animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Opacity(
      opacity: animation.value,
      child: Transform.translate(
      offset: Offset(0.0, _sizeAnim.evaluate(animation)),
      child: Icon(Icons.keyboard_arrow_up,color: Colors.white,size: 40.0,)
      ));
  }

}


