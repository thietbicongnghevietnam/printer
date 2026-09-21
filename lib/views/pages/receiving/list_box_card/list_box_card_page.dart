import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/barcode/box_card_barcode.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/views/pages/receiving/no_barcode/components/counter_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

import 'list_box_card_controller.dart';
import 'list_box_card_state.dart';

@RoutePage<List<Barcode>>()
class ListBoxCardPage
    extends BasePage<ListBoxCardController, ListBoxCardState> {
  const ListBoxCardPage({
    super.key,
    required this.barcodes,
    required this.totalQuantity,
  });

  final List<Barcode> barcodes;
  final int totalQuantity;

  @override
  BasePageState createState() => _ListBoxCardPageState();
}

class _ListBoxCardPageState
    extends BasePageState<ListBoxCardController, ListBoxCardState> {
  List<TextEditingController> boxController = [];
  List<TextEditingController> quantityController = [];

  int _totalQuantity = 0;

  @override
  void initState() {
    final group =
        groupBy((widget as ListBoxCardPage).barcodes, (p0) => p0.quantity);

    group.forEach((quantity, element) {
      boxController.add(TextEditingController(text: element.length.toString()));
      quantityController.add(TextEditingController(text: quantity.toString()));
    });

    _totalQuantity = group.values.map((e) => e.first.quantity * e.length).sum;
    super.initState();
  }

  void _updateTotalQuantity() {
    setState(() {
      _totalQuantity = List.generate(
        boxController.length,
        (index) =>
            boxController[index].text.toInt() *
            quantityController[index].text.toInt(),
      ).sum;
    });
  }

  void _addItem() {
    setState(() {
      boxController.add(TextEditingController(text: '1'));
      quantityController.add(TextEditingController());
    });
  }

  void _removeItem(int index) {
    if (index == 0) {
      return;
    }

    setState(() {
      boxController.removeAt(index);
      quantityController.removeAt(index);
    });
    _updateTotalQuantity();
  }

  List<Barcode> createBoxCard() {
    final barcode = (widget as ListBoxCardPage).barcodes.first as BoxCardBarcode;

    final list = <Barcode>[];
    for (var i = 0; i < boxController.length; i++) {
      final box = boxController[i].text.toInt();
      final quantity = quantityController[i].text.toInt();

      if (quantity == 0) {
        continue;
      }
      for (var boxIndex = 0; boxIndex < box; boxIndex++) {
        list.add(
          barcode.copyWith(
            changeGuid: true,
            unitNo: (boxIndex + 1).toString(),
            box: box,
            quantity: quantity,
          ),
        );
      }
    }

    return list;
  }

  @override
  Widget builder(context, cubit, state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách Box Card'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 8),
            child: AppText.header(
              'Tổng: ${widget.as<ListBoxCardPage>()?.totalQuantity}',
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Form(
        onChanged: () {
          _updateTotalQuantity();
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          children: [
            ...List.generate(boxController.length, (index) {
              return Slidable(
                enabled: index != 0,
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) => _removeItem(index),
                      backgroundColor: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                      icon: Icons.delete,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    if (index != 0)
                      const Icon(Icons.add)
                    else
                      const SizedBox(width: 24),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 120,
                      child: CounterFormField(
                        controller: boxController[index],
                        onClear: () => _removeItem(index),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.close),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppFormField(
                        enabled: index != 0,
                        controller: quantityController[index],
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).withWidgetBetween(const SizedBox(height: 8)),
            const SizedBox(height: 8),
            const Divider(),
            Row(
              children: [
                Assets.icons.icEqual.svg(width: 24, height: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: AppText.header(
                    _totalQuantity.toString(),
                    style: const TextStyle(fontSize: 20),
                    color: _totalQuantity !=
                            widget.as<ListBoxCardPage>()?.totalQuantity
                        ? Colors.red
                        : Colors.green,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          if (_totalQuantity != (widget as ListBoxCardPage).totalQuantity) {
            getIt<AppAlertDialog>().show(
              context,
              type: AppAlertType.error,
              message: 'Số lượng không khớp',
            );
          }

          final barcodes = createBoxCard();
          context.maybePop(barcodes);
        },
        child: const Text('Lưu thay đổi'),
      ).paddingSymmetric(vertical: 4, horizontal: 12),
    );
  }
}
