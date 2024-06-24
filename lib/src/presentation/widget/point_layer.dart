import 'package:flutter/material.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

class PointLayer extends StatefulWidget {
  final LatLng point;
  const PointLayer({super.key, required this.point});

  @override
  State<PointLayer> createState() => _PointLayerState();
}

class _PointLayerState extends State<PointLayer> {
  @override
  Widget build(BuildContext context) {
    return MarkerClusterLayerWidget(
        options: MarkerClusterLayerOptions(
      maxClusterRadius: 45,
      size: const Size(40, 40),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(50),
      maxZoom: 15,
      builder: (context, markers) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.blue),
          child: Center(
            child: Text(
              markers.length.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    ));
  }
}
