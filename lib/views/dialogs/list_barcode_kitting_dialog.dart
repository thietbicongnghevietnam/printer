import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/storage_card.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';
import 'package:smart_warehouse/views/dialogs/update_box_card_dialog.dart';
import 'package:smart_warehouse/views/dialogs/update_quantity_have_barcode_dialog.dart';

void showListBarcodeKittingDialog(
  BuildContext context, {
  required List<StorageCard> kittingScannedList,
  required ValueChanged<StorageCard> onUpdate,
  required ValueChanged<StorageCard> onDelete,
}) {
  showModalBottomSheet<void>(
    context: context,
    builder: (context) {
      return _ListBarcodeKitting(
        kittingScannedList: kittingScannedList,
        onUpdate: onUpdate,
        onDelete: onDelete,
      );
    },
  );
}

class _ListBarcodeKitting extends StatefulWidget {
  const _ListBarcodeKitting({
    required this.kittingScannedList,
    required this.onUpdate,
    required this.onDelete,
  });

  final List<StorageCard> kittingScannedList;
  final ValueChanged<StorageCard> onUpdate;
  final ValueChanged<StorageCard> onDelete;

  @override
  State<_ListBarcodeKitting> createState() => _ListBarcodeKittingState();
}

class _ListBarcodeKittingState extends State<_ListBarcodeKitting> {
  List<StorageCard> _kittingScannedList = [];

  @override
  void initState() {
    _kittingScannedList = widget.kittingScannedList.clone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Danh sách Barcode đã quét'),
          trailing: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              size: 20,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: _kittingScannedList
                .mapIndexed(
                  (index, e) => _buildItem(e, () {
                    showUpdateQuantityHaveBarcodeDialog(context, quantity: e.quantity,
                        onUpdate: (updatedQuantity) {
                      setState(() {
                        _kittingScannedList[index] = e.copyWith(stockQuantity: updatedQuantity);
                      });
                      widget.onUpdate(_kittingScannedList[index]);
                    });
                  }, () {
                    setState(() {
                      _kittingScannedList.remove(e);
                    });
                    widget.onDelete(e);
                    if (_kittingScannedList.isEmpty) {
                      Navigator.pop(context);
                    }
                  }),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(
    StorageCard storageCard,
    VoidCallback onEdit,
    VoidCallback onDelete,
  ) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onEdit(),
            backgroundColor: const Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Sửa',
          ),
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Xóa',
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: storageCard is ReceivingCard ? Colors.green : Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            storageCard is ReceivingCard ? 'RC' : 'BC',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        minLeadingWidth: 0,
        minVerticalPadding: 0,
        dense: true,
        title: Text(
          storageCard.barcode,
          style: const TextStyle(fontSize: 12),
        ),
        subtitle: Text('Số lượng: ${storageCard.quantity}'),
      ),
    );
  }
}
