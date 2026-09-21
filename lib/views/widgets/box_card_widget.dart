import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_warehouse/entities/barcode/box_card_barcode.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';

class BoxCardWidget extends StatelessWidget {
  const BoxCardWidget({
    super.key,
    this.barcode,
  });

  final BoxCardBarcode? barcode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      height: 160,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            alignment: Alignment.center,
            width: double.infinity,
            decoration:
            const BoxDecoration(border: Border(bottom: BorderSide())),
            child: const Text(
              'Box Card',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Table(
            border: TableBorder.symmetric(inside: const BorderSide()),
            columnWidths: const {
              0: FixedColumnWidth(60),
              1: FlexColumnWidth(),
            },
            children: [
              TableRow(
                children: [
                  _buildCell(
                    child: Text(
                      DateTime.now().toText(DateTimeType.dateFUll2),
                      style: TextStyle(fontSize: 6),
                    ),
                  ),
                  _buildCell(
                    child: Text(
                      barcode?.plant ?? '',
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  _buildCell(
                    child: const Text(
                      'Material',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  _buildCell(
                    child: Text(
                      barcode?.material ?? '',
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.black,
          ),
          Expanded(
            child: Row(
              children: [
                Table(
                  border: TableBorder.symmetric(inside: const BorderSide()),
                  columnWidths: const {
                    0: FixedColumnWidth(60),
                    1: FixedColumnWidth(100),
                  },
                  children: [
                    TableRow(
                      children: [
                        _buildCell(child: const Text('Type')),
                        _buildCell(child: Text(barcode?.type ?? '')),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildCell(child: const Text('Frequency')),
                        _buildCell(child: Text(barcode?.frequency ?? '')),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildCell(child: const Text('Sloc')),
                        _buildCell(child:  Text(barcode?.sloc ?? '')),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildCell(child: const Text('Quantity')),
                        _buildCell(child:  Text(barcode?.quantity.toString() ?? '')),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildCell(child: const Text('Box No')),
                        _buildCell(child: Text('${barcode?.unitNo}/${barcode?.box}')),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildCell(child: const Text('Invoice/DA')),
                        _buildCell(child: Text(barcode?.deliveryPlan?.no ?? '')),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration:
                    const BoxDecoration(border: Border(left: BorderSide())),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide()),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Assets.images.qrSample.image(),
                          ),
                        ),
                        Container(
                          height: 16,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(barcode?.vendor ?? ''),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TableCell _buildCell({required Widget child}) {
    return TableCell(
      child: Container(
        height: 16,
        padding: const EdgeInsets.only(left: 2),
        alignment: Alignment.centerLeft,
        child: child,
      ),
    );
  }
}

