import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class LayerModel {
  final Widget layer;
  final List<Marker> markerList;
  final String identifier;
  const LayerModel(
      {required this.layer,
      required this.identifier,
      required this.markerList});
}
