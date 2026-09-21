import 'package:flutter/material.dart';
import 'package:smart_warehouse/entities/kitting/kitting_detail.dart';
import 'package:smart_warehouse/enums/kitting_time_type.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/table_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

Future<void> showKittingDetailInfoDialog(
  BuildContext context, {
  required KittingDetail detail,
}) {
  return showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text('Kitting Item'),
        contentTextStyle: const TextStyle(fontSize: 10, color: Colors.black),
        content: Column(
          children: [
            Center(
              child: Text(
                KittingTimeType.fromCode(detail.kittingTimeType).toString() ??
                    '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FixedColumnWidth(50),
                1: FlexColumnWidth(3),
                2: FixedColumnWidth(45),
                3: FlexColumnWidth(),
              },
              children: [
                TableRow(
                  children: [
                    const Text('Material:'),
                    Text(
                      detail.material,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('Quantity:'),
                    Text(
                      '${detail.quantity.toInt()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Text('Model No:'),
                    Text(
                      detail.model,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('Category:'),
                    Text(
                      '${detail.category}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Text('Plant:'),
                    Text(
                      '${detail.plant}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('Sloc:'),
                    Text(
                      '${detail.sloc}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Text('Date:'),
                    Text(
                      detail.deliveryDate?.toText() ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('Time:'),
                    Text(
                      '${detail.time}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ].withSpaceBetween(10),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                detail.locationName ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            const Center(child: Text('Ảnh sản phẩm')),
            const Expanded(
              child: FlutterLogo(
                size: double.infinity,
              ),
            ),
          ],
        ).paddingSymmetric(vertical: 10),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          )
        ],
      );
    },
  );
}
