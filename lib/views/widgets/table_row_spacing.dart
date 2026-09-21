import 'package:flutter/material.dart';

class TableRowSpacing extends TableRow {
  TableRowSpacing({required int countItem, required double spacing})
      : super(
          children: List.generate(
            countItem,
            (index) => SizedBox(height: spacing),
          ),
        );
}
