import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'model/Shopping.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  Completer<GoogleMapController> _controller = Completer();

  LatLng curitiba = new LatLng(-25.441105, -49.276855);

  double zoomVal = 12.0;
  Set<Shopping> shoppings = Set();
  Set<Marker> markers = Set();

  void populateMarkers() {
    shoppings.clear();
    markers.clear();

    getData();

    for (Shopping item in shoppings) {
      markers.add(Marker(
        markerId: MarkerId(item.id.toString()),
        infoWindow: InfoWindow(title: item.name, snippet: item.address),
        position: LatLng(item.lat, item.lng),
      ));
    }

    setState(() {});
  }

  void getData() {
    shoppings.add(new Shopping(
        1,
        "Shopping Curitiba",
        "R. Brg. Franco, 2300 - Centro, Curitiba - PR, 80250-030",
        -25.4409898,
        -49.2795667,
        "https://images.unsplash.com/photo-1521404945951-3b88e463be35?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9"));
    shoppings.add(new Shopping(
        2,
        "Shopping Estação",
        "Av. Sete de Setembro, 2775 - Rebouças, Curitiba - PR, 80230-010",
        -25.4381598,
        -49.2687119,
        "https://images.unsplash.com/photo-1521404945951-3b88e463be35?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9"));

    shoppings.add(new Shopping(
        3,
        "Shopping Palladium",
        "Av. Pres. Kennedy, 4121 - Portão, Curitiba - PR, 80610-905",
        -25.4777481,
        -49.2931498,
        "https://images.unsplash.com/photo-1521404945951-3b88e463be35?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9"));

    shoppings.add(new Shopping(
        4,
        "Shopping Barigui",
        "R. Prof. Pedro Viriato Parigot de Souza, 600 - Mossunguê, Curitiba - PR, 81200-100",
        -25.4351965,
        -49.3186757,
        "https://images.unsplash.com/photo-1521404945951-3b88e463be35?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9"));

    shoppings.add(new Shopping(
        5,
        "Shopping Mueller",
        "Av. Cândido de Abreu, 127 - Centro Cívico, Curitiba - PR, 80530-900",
        -25.4233429,
        -49.2705916,
        "https://images.unsplash.com/photo-1521404945951-3b88e463be35?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9"));

    shoppings.add(new Shopping(
        6,
        "Shopping Itália",
        "R. Mal. Deodoro, 630 - Centro, Curitiba - PR, 80010-010",
        -25.4302983,
        -49.2684551,
        "https://images.unsplash.com/photo-1521404945951-3b88e463be35?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9"));

    shoppings.add(new Shopping(
        7,
        "Jockey Plaza Shopping Center",
        "R. Konrad Adenauer, 370 - Tarumã, Curitiba - PR, 82821-020",
        -25.4289404,
        -49.2170265,
        "https://images.unsplash.com/photo-1521404945951-3b88e463be35?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9"));

    shoppings.add(new Shopping(
        8,
        "Shopping Jardim das Américas",
        "Av. Nossa Sra. de Lourdes, 63 - Jardim das Américas, Curitiba - PR, 81530-020",
        -25.451164,
        -49.2313142,
        "https://images.unsplash.com/photo-1521404945951-3b88e463be35?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9"));

    shoppings.add(new Shopping(
        9,
        "Shopping Cidade",
        "Av. Mal. Floriano Peixoto, 4984, Curitiba - PR",
        -25.4724032,
        -49.2545086,
        "https://images.unsplash.com/photo-1521404945951-3b88e463be35?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9"));
  }

  @override
  void initState() {
    super.initState();
    populateMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping In Curitiba"),
      ),
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _zoomminusfunction(),
          _zoomplusfunction(),
          _buildContainer(context),
        ],
      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(target: curitiba, zoom: zoomVal),
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Widget _buildContainer(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 225,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: shoppings.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildCarouselItem(context, index);
            }),
      ),
    );
  }

  Widget _buildCarouselItem(BuildContext context, int itemIndex) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: _boxes(
          shoppings.elementAt(itemIndex).image,
          shoppings.elementAt(itemIndex).lat,
          shoppings.elementAt(itemIndex).lng,
          shoppings.elementAt(itemIndex).name,
          shoppings.elementAt(itemIndex).address),
    ));
  }

  Widget _boxes(String _image, double lat, double long, String shoppingName,
      String address) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Wrap(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(_image),
                  ),
                ),
              ),
              ListTile(
                title: Text(shoppingName),
                subtitle: Text(address),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget detailContainer(String shoppingName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            shoppingName,
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          )),
        ),
      ],
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, long), zoom: 15)));
  }

  Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchMinus, color: Color(0xff6200ee)),
          onPressed: () {
            zoomVal--;
            _minus(zoomVal);
          }),
    );
  }

  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchPlus, color: Color(0xff6200ee)),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: curitiba, zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: curitiba, zoom: zoomVal)));
  }
}
