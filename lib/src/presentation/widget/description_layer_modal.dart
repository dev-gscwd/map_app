import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_app/src/core/utils/utils_handler.dart';
import 'package:map_app/src/data/enums/selection_map_enum/selection_map_enum.dart';

class DescriptionLayerModal extends StatefulWidget {
  final String description;
  final LatLng latlng;
  const DescriptionLayerModal(
      {super.key, required this.description, required this.latlng});

  @override
  State<DescriptionLayerModal> createState() => _DescriptionLayerModalState();
}

class _DescriptionLayerModalState extends State<DescriptionLayerModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          ElevatedButton(
              onPressed: () {
                UtilsHandler.selectionMode = SelMapEnum.inactive;
                Navigator.pop(context);
              },
              child: const Icon(Icons.close))
        ],
      ),
      actionsAlignment: MainAxisAlignment.start,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            thickness: 1,
            endIndent: 10,
            indent: 10,
            color: Colors.black12,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Description : ${widget.description}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    endIndent: 10,
                    indent: 10,
                    color: Colors.black12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Latitude : ${widget.latlng.latitude}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    endIndent: 10,
                    indent: 10,
                    color: Colors.black12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Longitude : ${widget.latlng.longitude}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              )),
          const Divider(
            thickness: 1,
            endIndent: 10,
            indent: 10,
            color: Colors.black12,
          ),
        ],
      ),
    );
  }
}
