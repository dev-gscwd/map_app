import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_app/src/data/enums/selection_map_enum/selection_map_enum.dart';
import 'package:map_app/src/data/models/layers_model/layer_model.dart';

class UtilsHandler {
  static Position currentPosition = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0);
  static List<LayerModel> layers = [];
  static SelMapEnum selectionMode = SelMapEnum.inactive;
}
