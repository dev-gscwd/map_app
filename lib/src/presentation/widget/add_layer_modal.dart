import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:map_app/src/core/utils/constants.dart';
import 'package:map_app/src/core/utils/utils_handler.dart';
import 'package:map_app/src/data/enums/icon_mark_enum/icon_map_enum.dart';
import 'package:map_app/src/data/enums/selection_map_enum/selection_map_enum.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_app/src/data/models/layers_model/layer_model.dart';
import 'package:map_app/src/presentation/widget/description_layer_modal.dart';

class AddLayerModal extends StatefulWidget {
  final List<LatLng> pointList;
  const AddLayerModal({super.key, required this.pointList});

  @override
  State<AddLayerModal> createState() => _AddLayerModalState();
}

class _AddLayerModalState extends State<AddLayerModal> {
  TextEditingController txtDesc = TextEditingController();
  TextEditingController txtIcon = TextEditingController();
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            'Add Layer',
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
      content: SingleChildScrollView(
        child: Column(
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
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Description",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    TextField(
                      controller: txtDesc,
                      scrollPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).viewInsets.bottom),
                      style:
                          const TextStyle(fontSize: 12.0, color: Colors.black),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid)),
                          hintText: "Description",
                          hintStyle: TextStyle(fontSize: 12.0),
                          fillColor: Colors.white,
                          filled: true),
                      maxLines: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: DropdownMenu<dynamic>(
                              controller: txtIcon,
                              hintText: "Select Icon",
                              width: MediaQuery.of(context).size.width * .5,
                              textStyle: const TextStyle(fontSize: 13),
                              dropdownMenuEntries: UtilsHandler.iconSelection
                                  .map<DropdownMenuEntry<dynamic>>(
                                      (dynamic remarks) {
                                return DropdownMenuEntry(
                                    value: remarks.value, label: remarks.label);
                              }).toList(),
                            )),
                      ],
                    )
                  ],
                )),
            const Divider(
              thickness: 1,
              endIndent: 10,
              indent: 10,
              color: Colors.black12,
            ),
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Color: ",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: SizedBox(
                      height: 200,
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: currentColor,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7))),
                        child: const Text('Select Color'),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Pick a color!'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: pickerColor,
                                  onColorChanged: (val) {
                                    pickerColor = val;
                                  },
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text('Got it'),
                                  onPressed: () {
                                    setState(() => currentColor = pickerColor);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kBackgroundColor,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7))),
                  onPressed: () {
                    //SAVE HERE
                    int myIndex = UtilsHandler.layers.length;
                    LayerModel myLayer = LayerModel(
                        showLayer: true,
                        layer: Container(),
                        identifier: txtDesc.text,
                        markerList: widget.pointList,
                        index: myIndex,
                        layerIcon: IconMapEnumClass()
                            .getStatusFromString(txtIcon.text),
                        layerColor: currentColor);
                    UtilsHandler.layers.add(myLayer);
                    UtilsHandler.selectionMode = SelMapEnum.inactive;
                    UtilsHandler.tempMarkerList = [];
                    UtilsHandler.tempPointList = [];
                    UtilsHandler.overlayLabel = '';
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "SAVE",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )),
            const Divider(
              thickness: 1,
              endIndent: 10,
              indent: 10,
              color: Colors.black12,
            ),
          ],
        ),
      ),
    );
  }
}
