import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_app/src/data/enums/icon_mark_enum/icon_map_enum.dart';

class LayerModel {
  final int index;
  final Color layerColor;
  final IconMapEnum layerIcon;
  final bool showLayer;
  final Widget layer;
  final List<LatLng> markerList;
  final String identifier;
  const LayerModel(
      {required this.layer,
      required this.identifier,
      required this.markerList,
      required this.showLayer,
      required this.layerIcon,
      required this.index,
      required this.layerColor});
}
