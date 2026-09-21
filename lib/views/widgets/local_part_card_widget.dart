import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/entities/barcode/local_barcode.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';

class LocalBarcodeWidget extends StatefulWidget {
  const LocalBarcodeWidget({
    super.key,
    this.barcode,
    this.boxNo,
    this.boxTotal,
    this.qty,
  });

  final LocalBarcode? barcode;
  final String? boxNo;
  final String? boxTotal;
  final String? qty;

  @override
  State<LocalBarcodeWidget> createState() => LocalBarcodeWidgetState();
}

class LocalBarcodeWidgetState extends State<LocalBarcodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Text(
              widget.barcode?.material ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(widget.barcode?.invoice ?? ''),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 20),
              child: Text(widget.barcode?.poItem?.toString() ?? ''),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 40),
              child: Text(widget.barcode?.po ?? ''),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Text(widget.barcode?.deliveryDate.toText() ?? ''),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 120),
              child: Text('${widget.barcode?.unitNo.toInt()}/${widget.barcode?.box}'),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.only(bottom: 30),
                width: 60,
                height: 60,
                child: Image.asset(Assets.images.qrSample.path),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  widget.barcode?.unitNo.toString() ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  '${widget.barcode?.quantity ?? ''}/${widget.barcode?.totalQuantity} ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Text('${widget.barcode?.deliveryPlan?.no} - ${widget.barcode?.daItem}'),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                LocaleKeys.create_barcode_ng_psnv.tr(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
