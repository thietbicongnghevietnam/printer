import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_warehouse/views/widgets/app_alert_dialog.dart';
import 'package:smart_warehouse/views/widgets/app_autocomplete.dart';
import 'package:smart_warehouse/views/widgets/app_drop_down.dart';

typedef GetDataKittingByModel = void Function(
  String model,
);

Future<void> selectModelKittingDialog(
  BuildContext context, {
  required GetDataKittingByModel onConfirm,
  required List<String> listModel,
}) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => SelectModelKittingDialog(
      onConfirm: onConfirm,
      listModel: listModel,
    ),
  );
}

class SelectModelKittingDialog extends StatefulWidget {
  const SelectModelKittingDialog({
    super.key,
    required this.onConfirm,
    required this.listModel,
  });

  final GetDataKittingByModel onConfirm;
  final List<String> listModel;

  @override
  State<SelectModelKittingDialog> createState() => _SelectModelKittingDialog();
}

class _SelectModelKittingDialog extends State<SelectModelKittingDialog> {
  late List<String> listModel;
  late String model;

  @override
  void didUpdateWidget(covariant SelectModelKittingDialog oldWidget) {
    if (oldWidget.listModel != widget.listModel) {
      listModel = widget.listModel;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    listModel = widget.listModel;
    model = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      contentTextStyle: const TextStyle(fontSize: 9, color: Colors.black),
      title: const Text('Chọn Model'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: AppAutoComplete(
                  optionsBuilder: (textEditingValue) {
                    return listModel.where((element) => element
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()));
                  },
                  onSelect: (value) {
                    setState(() {
                      model = value ?? '';
                    });
                  },
                  displayStringForOption: (object) => object,
                ),
              ),
            ],
          )
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
                    widget.onConfirm(model);
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
