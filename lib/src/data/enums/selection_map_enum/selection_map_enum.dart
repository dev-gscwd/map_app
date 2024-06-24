enum SelMapEnum { inactive, singlePoint, multiPoint, polygon }

class StatusClass {
  SelMapEnum getStatus(int input) {
    switch (input) {
      case 0:
        return SelMapEnum.inactive;
      case 1:
        return SelMapEnum.singlePoint;
      case 2:
        return SelMapEnum.multiPoint;
      case 3:
        return SelMapEnum.polygon;
      default:
        return SelMapEnum.inactive;
    }
  }
}

extension StatusExtension on SelMapEnum {
  int get getIntVal {
    switch (this) {
      case SelMapEnum.inactive:
        return 0;
      case SelMapEnum.singlePoint:
        return 1;
      case SelMapEnum.multiPoint:
        return 2;
      case SelMapEnum.polygon:
        return 3;
      default:
        return 0;
    }
  }

  String get getStringVal {
    switch (this) {
      case SelMapEnum.inactive:
        return 'Inactive';
      case SelMapEnum.singlePoint:
        return 'Single Point Mode';
      case SelMapEnum.multiPoint:
        return 'Multiple Point Mode';
      case SelMapEnum.polygon:
        return 'Polygon Mode';
      default:
        return 'Error';
    }
  }
}
