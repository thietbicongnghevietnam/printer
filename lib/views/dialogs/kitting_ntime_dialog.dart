import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/views/widgets/app_alert_dialog.dart';
import 'package:smart_warehouse/views/widgets/app_drop_down.dart';
import 'package:smart_warehouse/views/widgets/app_radio.dart';

typedef GetDataNTimeCallBack = void Function(
  int kittingTimeIntStart,
  int kittingTimeIntEnd,
    bool? isOnTheHour,
);



Future<void> kittingNTimeDialog(
  BuildContext context, {
  required GetDataNTimeCallBack onConfirm,
  required int startTime,
  required int endTime,
      bool? isOnTheHour,
}) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => KittingNTimeDialog(
      onConfirm: onConfirm,
      kittingTimeNTimeIntStart: startTime,
      kittingTimeNTimeIntEnd: endTime,
      isOnTheHour: isOnTheHour,
    ),
  );
}

class KittingNTimeDialog extends StatefulWidget {
  const KittingNTimeDialog({
    super.key,
    required this.onConfirm,
    required this.kittingTimeNTimeIntStart,
    required this.kittingTimeNTimeIntEnd, this.isOnTheHour,
  });

  final GetDataNTimeCallBack onConfirm;
  final int kittingTimeNTimeIntStart;
  final int kittingTimeNTimeIntEnd;
  final bool? isOnTheHour;

  @override
  State<KittingNTimeDialog> createState() => _KittingNTimeDialogState();
}

class _KittingNTimeDialogState extends State<KittingNTimeDialog> {
  late int startTime;
  late int endTime;
  bool? isOnTheHour;


  final List<int> listTimeNTimeInt = List.generate(24, (index) => index);

  @override
  void didUpdateWidget(covariant KittingNTimeDialog oldWidget) {
    if (oldWidget.kittingTimeNTimeIntStart != widget.kittingTimeNTimeIntStart ||
        oldWidget.kittingTimeNTimeIntEnd != widget.kittingTimeNTimeIntEnd) {
      startTime = widget.kittingTimeNTimeIntStart;
      endTime = widget.kittingTimeNTimeIntEnd;
      isOnTheHour = widget.isOnTheHour;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    startTime = widget.kittingTimeNTimeIntStart;
    endTime = widget.kittingTimeNTimeIntEnd;
    isOnTheHour = widget.isOnTheHour;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      contentTextStyle: const TextStyle(fontSize: 9, color: Colors.black),
      title:  const Text('Chọn Khung Giờ'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              AppRadio(value: true, groupValue: isOnTheHour, onChanged: (value) {
               setState(() {
                 if (isOnTheHour == value) {
                   isOnTheHour = null;
                 } else {
                   isOnTheHour = value;
                 }
               });
              }, title: 'Giờ đầu cuối',),
              const SizedBox(width: 40,),
              AppRadio(value: false, groupValue: isOnTheHour, onChanged: (value) {
                setState(() {
                  if (isOnTheHour == value) {
                    isOnTheHour = null;
                  } else {
                    isOnTheHour = value;
                  }
                });
              }, title: 'Giờ giữa',),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: AppDropdown(
                  displayStringForOption: (option) => option.toString(),
                  options: listTimeNTimeInt,
                  value: startTime,
                  onChange: (value) {
                    setState(() {
                      startTime = value ?? 00;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: AppDropdown(
                  displayStringForOption: (option) => option.toString(),
                  options: listTimeNTimeInt,
                  value: endTime,
                  onChange: (value) {
                    setState(() {
                      endTime = value ?? 00;
                    });
                  },
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
                    if (startTime > endTime) {
                      getIt<AppAlertDialog>().show(context,
                          message: 'Giờ bắt đầu phải bé hơn giờ kết thúc');
                    } else {
                      Navigator.pop(context);
                      widget.onConfirm(startTime, endTime, isOnTheHour);
                    }
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


