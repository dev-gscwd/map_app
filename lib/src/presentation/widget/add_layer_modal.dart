import 'package:flutter/material.dart';
import 'package:map_app/src/core/utils/constants.dart';
import 'package:map_app/src/core/utils/utils_handler.dart';
import 'package:map_app/src/data/enums/selection_map_enum/selection_map_enum.dart';

class AddLayerModal extends StatefulWidget {
  const AddLayerModal({super.key});

  @override
  State<AddLayerModal> createState() => _AddLayerModalState();
}

class _AddLayerModalState extends State<AddLayerModal> {
  TextEditingController txtDesc = TextEditingController();
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
                    style: const TextStyle(fontSize: 12.0, color: Colors.black),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0)),
                            borderSide: BorderSide(
                                color: Colors.black, style: BorderStyle.solid)),
                        hintText: "Description",
                        hintStyle: TextStyle(fontSize: 12.0),
                        fillColor: Colors.white,
                        filled: true),
                    maxLines: 2,
                  ),
                ],
              )),
          const Divider(
            thickness: 1,
            endIndent: 10,
            indent: 10,
            color: Colors.black12,
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
                  UtilsHandler.selectionMode = SelMapEnum.inactive;
                },
                child: const Text(
                  "SAVE",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ))
        ],
      ),
    );
  }
}
