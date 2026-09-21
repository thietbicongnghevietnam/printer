import 'package:flutter/material.dart';

class KittingItemWidget extends StatelessWidget {
  const KittingItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        dense: true,
        title: Text('MSSSKKKSK'),
        subtitle: Text('PIC: 20223333'),
        trailing: Text('Qty: 1000'),
      ),
    );
  }
}
