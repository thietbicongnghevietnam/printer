import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/kitting/kitting_card.dart';
import 'package:smart_warehouse/enums/kitting_type.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';
import 'package:smart_warehouse/views/widgets/app_alert_dialog.dart';
import 'package:smart_warehouse/views/widgets/app_drop_down.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';
import 'package:smart_warehouse/views/widgets/kitting_card_widget.dart';

typedef CreateKittingCardCallBack = void Function(
    PrinterDevice printerDevice,
    KittingCard kittingCard,
);

Future<void> viewKittingCardDialog(
  BuildContext context, {
  required List<KittingCard> kittingCards,
}) async {
  await showDialog<void>(
    context: context,
    builder: (_) => _KittingCardDialog(
      kittingCards: kittingCards,
    ),
  );
}

class _KittingCardDialog extends StatefulWidget {
  const _KittingCardDialog({
    super.key,
    required this.kittingCards,
  });

  final List<KittingCard> kittingCards;

  @override
  State<_KittingCardDialog> createState() => _KittingCardDialogState();
}

class _KittingCardDialogState extends State<_KittingCardDialog> {
  final PageController _pageController = PageController();
  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    final kittingCards = widget.kittingCards;
    return AppDialog(
      contentTextStyle: const TextStyle(fontSize: 9, color: Colors.black),
      title: const Text('Xem Kitting Card'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 150,
            child: PageView.builder(
              itemBuilder: (context, index) {
                return KittingCardWidget(kittingCard: kittingCards[index]);
              },
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _activePage = page;
                });
              },
              itemCount: kittingCards.length,
            ),
          ),
          Text(
            '${_activePage + 1}/${kittingCards.length}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Đóng'),
        ),
      ],
    );
  }
}
