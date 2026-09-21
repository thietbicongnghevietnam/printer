import 'package:flutter/material.dart';
import 'package:smart_warehouse/shared/extensions/table_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

class KittingListInfoWidget extends StatelessWidget {
  const KittingListInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AppText.header('Xuất theo giờ'),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(2),
              },
              children: const [
                TableRow(
                  children: [
                    TableCell(child: Text('Model: ARBGBA208195-V4')),
                    TableCell(child: Text('Line: PA1')),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: Text('Time: 06:00')),
                    TableCell(child: Text('Date: 09/09/2024')),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: Text('Plant: V501')),
                    TableCell(child: Text('Quantity: 200/240')),
                  ],
                ),
              ].withSpaceBetween(2),
            ),
          ].withWidgetBetween(const SizedBox(height: 4)),
        ),
      ),
    );
  }
}
