import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LayerModel {
  final Widget layer;
  final List<LatLng> markerList;
  final String identifier;
  const LayerModel(
      {required this.layer,
      required this.identifier,
      required this.markerList});
}
