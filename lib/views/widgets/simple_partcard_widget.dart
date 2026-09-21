import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_warehouse/entities/barcode/simple_barcode.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';

class SimplePartCardWidget extends StatefulWidget {
  const SimplePartCardWidget({super.key, this.barcode, this.qty, this.caseMark1, this.caseMark2, this.caseMark3});

  final SimpleBarcode? barcode;
  final String? qty;
  final String? caseMark1;
  final String? caseMark2;
  final String? caseMark3;

  @override
  State<SimplePartCardWidget> createState() => _SimplePartCardWidgetState();
}

class _SimplePartCardWidgetState extends State<SimplePartCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      height: 170,
      width: double.infinity,
      child:  Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
             Padding( padding: const EdgeInsets.only(left: 100),child: Text(LocaleKeys.create_barcode_ng_psnv.tr(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),),
             Align( alignment: Alignment.topRight, child: Container(
               padding: const EdgeInsets.only(right: 40, top: 20),
              child: Text(widget.barcode?.unitNo ?? ''),
            ),),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('Customer Part No:'),
            ),
             Padding(
              padding: const EdgeInsets.only(top: 20, left: 80),
              child: Text(widget.barcode?.material ?? ''),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text('Quantity:'),
            ),
             Padding(
              padding: const EdgeInsets.only(top: 40, left: 80),
              child: Text(widget.barcode?.quantity.toString() ?? ''),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 60),
              child: Text('Date Code:'),
            ),
             const Padding(
              padding: EdgeInsets.only(top: 60, left: 80),
              child: Text(''),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 80),
              child: Text('COO:'),
            ),
             const Padding(
              padding: EdgeInsets.only(top: 80, left: 80),
              child: Text(''),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 100),
              child: Text('CaseMark1:'),
            ),
             const Padding(
              padding: EdgeInsets.only(top: 100, left: 80),
              child: Text(''),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 120),
              child: Text('CaseMark2:'),
            ),
             const Padding(
              padding: EdgeInsets.only(top: 120, left: 80),
              child: Text(''),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 140),
              child: Text('CaseMark3:'),
            ),
             const Padding(
              padding: EdgeInsets.only(top: 140, left: 80),
              child: Text(''),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.only(left: 40),
                width: 120,
                height: 120,
                child: Image.asset(Assets.images.qrSample.path),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
