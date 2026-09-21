import 'package:flutter/cupertino.dart';

abstract interface class PdaDevice {
  Future<void> initialize();

  void listen(
    BuildContext context,
    void Function(String data) result, {
    bool onDialog = false,
  });

  void dispose();
}
