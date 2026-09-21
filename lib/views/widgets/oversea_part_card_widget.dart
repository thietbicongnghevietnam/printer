import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/entities/barcode/oversea_barcode.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';

class OverSeaBarcodeWidget extends StatefulWidget {
  const OverSeaBarcodeWidget({
    super.key,
    this.barcode,
    this.boxNo,
    this.boxTotal,
    this.qty,
  });

  final OverseaBarcode? barcode;
  final String? boxNo;
  final String? boxTotal;
  final String? qty;

  @override
  State<OverSeaBarcodeWidget> createState() => OverSeaBarcodeWidgetState();
}

class OverSeaBarcodeWidgetState extends State<OverSeaBarcodeWidget> {
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
              child: SizedBox(
                width: 60,
                height: 60,
                child: Image.asset(Assets.images.qrSample.path),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(''),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text('${widget.barcode?.po } - ${widget.barcode?.poItem}'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 120),
              child: Text('${widget.barcode?.unitNo.toInt()}/${widget.barcode?.box}'),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 60),
              child: Text(''),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  '${widget.barcode?.unitNo}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  '${widget.barcode?.quantity}/${widget.barcode?.totalQuantity.toString() ?? ''}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 120),
              child: Text(''),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                LocaleKeys.create_barcode_ng_psnv.tr(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
