import 'package:flutter/material.dart';
import 'package:smart_warehouse/enums/kitting_outside_group_select.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/views/widgets/app_alert_dialog.dart';
import 'package:smart_warehouse/views/widgets/app_drop_down.dart';

typedef GetDataOrderByTypeCallBack = void Function(
    String? data,
);

Future<void> kittingSubConOrderByType(
  BuildContext context, {
  required GetDataOrderByTypeCallBack onConfirm,
  required List<String?> listData,
      required KittingOutsideGroupSelect? typeOrder,
}) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => KittingOutsideSelectOrderDialog(
      onConfirm: onConfirm,
      listData: listData,
      typeOrder: typeOrder,
    ),
  );
}

class KittingOutsideSelectOrderDialog extends StatefulWidget {
  const KittingOutsideSelectOrderDialog({
    super.key,
    this.typeOrder,
    required this.onConfirm,
    required this.listData,
  });

  final KittingOutsideGroupSelect? typeOrder;
  final GetDataOrderByTypeCallBack onConfirm;
  final List<String?> listData;

  @override
  State<KittingOutsideSelectOrderDialog> createState() =>
      _KittingOutsideSelectOrderDialogState();
}

class _KittingOutsideSelectOrderDialogState
    extends State<KittingOutsideSelectOrderDialog> {
  late List<String?> listData;
  late KittingOutsideGroupSelect? typeOrder;
  late String? data;

  @override
  void initState() {
    listData = widget.listData;
    typeOrder = widget.typeOrder;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      contentTextStyle: const TextStyle(fontSize: 9, color: Colors.black),
      title: Text('${typeOrder?.text}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
       children: [
         AppDropdown<String>(
           displayStringForOption: (option) => option,
           options: listData.whereType<String>().toList(),
           onChange: (value) {
             setState(() {
               data = value ?? '';
             });
           },
         ),
       ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Hủy'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style:
                  ElevatedButton.styleFrom(foregroundColor: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onConfirm(data);
                  },
                  child: const Text('Xác nhận'),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
