import 'package:flutter/cupertino.dart';
import 'package:smart_warehouse/views/widgets/table_row_spacing.dart';

extension TableRowExtensions on List<TableRow> {
  List<TableRow> withSpaceBetween(double spacing) {
    final list = <TableRow>[];
    forEach((element) {
      list.add(element);
      list.add(
        TableRowSpacing(
          countItem: element.children.length,
          spacing: spacing,
        ),
      );
    });
    list.removeLast();

    return list;
  }
}
