import 'package:flutter/material.dart';

enum IconMapEnum { point, location, city }

class IconMapEnumClass {
  IconMapEnum getStatus(int input) {
    switch (input) {
      case 0:
        return IconMapEnum.point;
      case 1:
        return IconMapEnum.location;
      case 2:
        return IconMapEnum.city;
      default:
        return IconMapEnum.point;
    }
  }

  IconMapEnum getStatusFromString(String input) {
    switch (input) {
      case 'Point':
        return IconMapEnum.point;
      case 'Location':
        return IconMapEnum.location;
      case 'City':
        return IconMapEnum.city;
      default:
        return IconMapEnum.point;
    }
  }
}

extension StatusExtension on IconMapEnum {
  Icon getIconSet(Color myColor) {
    switch (this) {
      case IconMapEnum.point:
        return Icon(
          Icons.circle_sharp,
          color: myColor,
        );
      case IconMapEnum.location:
        return Icon(Icons.location_on, color: myColor);
      case IconMapEnum.city:
        return Icon(Icons.location_city, color: myColor);
    }
  }

  int get getIntVal {
    switch (this) {
      case IconMapEnum.point:
        return 0;
      case IconMapEnum.location:
        return 1;
      case IconMapEnum.city:
        return 2;
      default:
        return 0;
    }
  }

  String get getStringVal {
    switch (this) {
      case IconMapEnum.point:
        return 'Point';
      case IconMapEnum.location:
        return 'Location';
      case IconMapEnum.city:
        return 'City';
      default:
        return 'Error';
    }
  }
}
