import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_app/src/core/utils/utils_handler.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_app/src/data/enums/selection_map_enum/selection_map_enum.dart';
import 'package:map_app/src/presentation/widget/add_layer_modal.dart';

class MyMap extends StatefulWidget {
  const MyMap({super.key, required this.title});
  final String title;

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Position currentPos = UtilsHandler.currentPosition;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      floatingActionButton: SpeedDial(children: [
        SpeedDialChild(
          child: const Icon(Icons.my_location),
          label: 'Single Point Layer',
          onTap: () {
            UtilsHandler.selectionMode = SelMapEnum.singlePoint;
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.accessibility),
          label: 'Multi Point Layer',
          onTap: null,
        ),
      ], child: const Icon(Icons.add)),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Page 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.train,
              ),
              title: const Text('Page 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
            initialCenter: LatLng(currentPos.latitude, currentPos.longitude),
            initialZoom: 10,
            maxZoom: 15,
            onTap: (tap, latlng) {
              switch (UtilsHandler.selectionMode) {
                case SelMapEnum.inactive:
                  break;
                case SelMapEnum.singlePoint:
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => const AddLayerModal());
                  break;
                case SelMapEnum.multiPoint:
                  break;
                case SelMapEnum.polygon:
                  break;
              }
              print('$latlng tap');
            },
            onLongPress: (tap, latlng) {
              print('$latlng longtap');
            }),
        children: <Widget>[
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
              maxClusterRadius: 45,
              size: const Size(40, 40),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(50),
              maxZoom: 15,
              builder: (context, markers) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                  child: Center(
                    child: Text(
                      markers.length.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
