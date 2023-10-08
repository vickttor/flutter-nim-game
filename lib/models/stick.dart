import 'package:flutter_nim_game/enums/turn.dart';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Stick {
  late String id;
  late bool rendering;
  Turn selectedBy;
  bool pickedUp;

  Stick({required this.selectedBy, required this.pickedUp}) {
    id = uuid.v4();
    rendering = true;
  }

  Turn getSelectedBy() {
    return selectedBy;
  }

  void setSelectedBy(Turn selectedBy) {
    this.selectedBy = selectedBy;
  }

  bool getPickedUp() {
    return pickedUp;
  }

  void setPickedUp(bool pickedUp) {
    this.pickedUp = pickedUp;
    if (pickedUp == true) {
      rendering = false;
    }
  }

  bool isRendering() {
    return rendering;
  }
}
