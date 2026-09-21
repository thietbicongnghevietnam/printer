import 'package:flutter/material.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/barcode/box_card_barcode.dart';
import 'package:smart_warehouse/entities/barcode/local_barcode.dart';
import 'package:smart_warehouse/entities/barcode/oversea_barcode.dart';
import 'package:smart_warehouse/entities/barcode/pmd_barcode.dart';
import 'package:smart_warehouse/entities/barcode/simple_barcode.dart';
import 'package:smart_warehouse/entities/barcode/standard_barcode.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/views/widgets/box_card_widget.dart';
import 'package:smart_warehouse/views/widgets/pmd_partcard_widget.dart';
import 'package:smart_warehouse/views/widgets/simple_partcard_widget.dart';
import 'package:smart_warehouse/views/widgets/standard_partcard_widget.dart';

import 'local_part_card_widget.dart';
import 'oversea_part_card_widget.dart';

class BarcodeWidget extends StatelessWidget {
  const BarcodeWidget({super.key, required this.barcode});

  final Barcode barcode;

  @override
  Widget build(BuildContext context) {
    return switch (barcode) {
      LocalBarcode() => LocalBarcodeWidget(barcode: barcode.as()),
      OverseaBarcode() => OverSeaBarcodeWidget(barcode: barcode.as()),
      SimpleBarcode() => SimplePartCardWidget(barcode: barcode.as()),
      StandardBarcode() => StandardPartCardWidget(barcode: barcode.as()),
      PMDBarcode() => PMDPartCardWidget(barcode: barcode.as()),
      BoxCardBarcode() => BoxCardWidget(barcode: barcode.as()),
      _ => const Text(''),
    };
  }
}
