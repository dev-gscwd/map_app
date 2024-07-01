import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_app/src/core/utils/utils_handler.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_app/src/data/enums/icon_mark_enum/icon_map_enum.dart';
import 'package:map_app/src/data/enums/selection_map_enum/selection_map_enum.dart';
import 'package:map_app/src/data/models/layers_model/layer_model.dart';
import 'package:map_app/src/presentation/widget/add_layer_modal.dart';
import 'package:map_app/src/presentation/widget/description_layer_modal.dart';
import 'package:map_app/src/presentation/widget/mark_layer.dart';

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
    Timer.run(() => showOverlay(context));
    List<Widget> appDrawers = [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Text('Map Example'),
      ),
      ListTile(
        leading: const Icon(
          Icons.my_location,
        ),
        title: const Text('My Current Location'),
        trailing: IconButton(
          icon: const Icon(Icons.remove_red_eye_outlined),
          onPressed: () {},
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    ];
    List<Widget> myLocalLayers = UtilsHandler.defaultLayer;
    List<Marker> markerList = [
      Marker(
          point: LatLng(currentPos.latitude, currentPos.longitude),
          child: IconButton(
            icon: const Icon(
              Icons.my_location,
              color: Color.fromARGB(255, 36, 126, 230),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => DescriptionLayerModal(
                        description: 'This is my current location',
                        latlng:
                            LatLng(currentPos.latitude, currentPos.longitude),
                      ));
            },
          ))
    ];
    for (var layer in UtilsHandler.layers) {
      Widget drawer = ListTile(
        leading: layer.layerIcon.getIconSet(layer.layerColor),
        title: Text(layer.identifier),
        trailing: IconButton(
          icon: layer.showLayer
              ? const Icon(Icons.remove_red_eye_outlined)
              : const FaIcon(FontAwesomeIcons.eyeSlash),
          onPressed: () {
            setState(() {
              UtilsHandler.layers[layer.index] = LayerModel(
                  layerColor: layer.layerColor,
                  layer: layer.layer,
                  index: layer.index,
                  identifier: layer.identifier,
                  markerList: layer.markerList,
                  showLayer: !layer.showLayer,
                  layerIcon: layer.layerIcon);
            });
          },
        ),
      );
      appDrawers.add(drawer);
      if (layer.showLayer) {
        for (var marker in layer.markerList) {
          Marker pointMarker = Marker(
              point: marker,
              child: IconButton(
                icon: layer.layerIcon.getIconSet(layer.layerColor),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => DescriptionLayerModal(
                            description: layer.identifier,
                            latlng: marker,
                          ));
                },
              ));
          markerList.add(pointMarker);
        }
      }
      Widget currentLayer = MarkLayer(markLayers: markerList);
      myLocalLayers.add(currentLayer);
    }
    for (Marker layer in UtilsHandler.tempMarkerList) {
      markerList.add(layer);
    }
    bool hasTempLayer = UtilsHandler.tempMarkerList.isNotEmpty;
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
        floatingActionButton: UtilsHandler.selectionMode ==
                SelMapEnum.multiPoint
            ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          UtilsHandler.selectionMode = SelMapEnum.inactive;
                          UtilsHandler.tempMarkerList = [];
                          UtilsHandler.tempPointList = [];
                          UtilsHandler.overlayLabel = '';
                        });
                      },
                      child: const FaIcon(FontAwesomeIcons.multiply)),
                  const SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton(
                      backgroundColor: hasTempLayer ? null : Colors.grey,
                      onPressed: !hasTempLayer
                          ? () {}
                          : () {
                              setState(() {
                                UtilsHandler.tempMarkerList.removeAt(
                                    UtilsHandler.tempMarkerList.length - 1);
                                UtilsHandler.tempPointList.removeAt(
                                    UtilsHandler.tempPointList.length - 1);
                              });
                            },
                      child: const FaIcon(FontAwesomeIcons.minus)),
                  const SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton(
                      onPressed: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => AddLayerModal(
                                  pointList: UtilsHandler.tempPointList,
                                )).then((val) {
                          setState(() {});
                        });
                      },
                      child: const FaIcon(FontAwesomeIcons.check)),
                ],
              )
            : SpeedDial(
                children: [
                    SpeedDialChild(
                      child: const Icon(Icons.my_location),
                      label: 'Single Point Layer',
                      onTap: () {
                        setState(() {
                          UtilsHandler.overlayLabel =
                              'Please Select Single Location Point';
                          UtilsHandler.selectionMode = SelMapEnum.singlePoint;
                        });
                      },
                    ),
                    SpeedDialChild(
                      child: const Icon(Icons.accessibility),
                      label: 'Multi Point Layer',
                      onTap: () {
                        setState(() {
                          setState(() {
                            UtilsHandler.overlayLabel =
                                'Please Select Multiple Location Point';
                            UtilsHandler.selectionMode = SelMapEnum.multiPoint;
                          });
                        });
                      },
                    ),
                  ],
                child: UtilsHandler.selectionMode == SelMapEnum.inactive
                    ? const Icon(Icons.add)
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            UtilsHandler.overlayLabel = '';
                            UtilsHandler.selectionMode = SelMapEnum.inactive;
                          });
                        },
                        icon: const FaIcon(FontAwesomeIcons.multiply))),
        drawer: Drawer(
          child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: appDrawers),
        ),
        body: FlutterMap(
          options: MapOptions(
              initialCenter: LatLng(currentPos.latitude, currentPos.longitude),
              initialZoom: 10,
              maxZoom: 15,
              onTap: (tap, latlng) {
                switch (UtilsHandler.selectionMode) {
                  case SelMapEnum.inactive:
                    setState(() {});
                    break;
                  case SelMapEnum.singlePoint:
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => AddLayerModal(
                              pointList: [
                                LatLng(latlng.latitude, latlng.longitude)
                              ],
                            )).then((val) {
                      setState(() {});
                    });
                    break;
                  case SelMapEnum.multiPoint:
                    Marker myMark = Marker(
                        point: LatLng(latlng.latitude, latlng.longitude),
                        child: IconButton(
                          icon: const Icon(
                            Icons.add_location,
                            color: Color.fromARGB(255, 36, 126, 230),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => DescriptionLayerModal(
                                      description:
                                          'This is my current location',
                                      latlng: LatLng(
                                          latlng.latitude, latlng.longitude),
                                    ));
                          },
                        ));
                    UtilsHandler.tempMarkerList.add(myMark);
                    UtilsHandler.tempPointList
                        .add(LatLng(latlng.latitude, latlng.longitude));
                    setState(() {});
                    break;
                  case SelMapEnum.polygon:
                    break;
                  default:
                    print('hello');
                    setState(() {});
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
                markers: markerList,
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
        ));
  }
}

void showOverlay(BuildContext context) {
  int num = 0;
  bool isTimer = false;
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => StatefulBuilder(builder: (context, innerSetState) {
      num = num < 100 ? num + 1 : num;
      if (!isTimer) {
        Timer.periodic(
            const Duration(seconds: 5), (Timer t) => innerSetState(() {}));
        isTimer = true;
        print('Timer executed');
      }
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          UtilsHandler.overlayLabel.isEmpty
              ? Container()
              : Material(
                  color: Colors.transparent,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(UtilsHandler.overlayLabel),
                    ),
                  ),
                ),
        ],
      );
    }),
  );

  Overlay.of(context).insert(overlayEntry);

  // To remove the overlay after some time (e.g., 3 seconds)
  // Future.delayed(Duration(seconds: 3), () {
  //   overlayEntry.remove();
  // });
}
