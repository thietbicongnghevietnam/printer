import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/views/dialogs/update_quantity_have_barcode_dialog.dart';
import 'package:smart_warehouse/views/dialogs/view_barcode_dialog.dart';
import 'package:smart_warehouse/views/pages/receiving/have_barcode/gr_have_barcode_controller.dart';
import 'package:smart_warehouse/views/pages/receiving/have_barcode/gr_have_barcode_state.dart';

const _kBarcodeFieldKey = 'barcode_field';
const _kNoFieldKey = 'no_field';
const _kQtyFieldKey = 'qty_field';
const _kActionFieldKey = 'action_field';

enum _BarcodeAction {
  view,
  findBarcodeLack,
  edit,
  delete;

  @override
  String toString() {
    return switch (this) {
      view => 'Xem',
      findBarcodeLack => 'Tìm barcode thiếu',
      edit => 'Sửa',
      delete => 'Xóa',
    };
  }
}

class ListScannedBarcodeWidget extends StatefulWidget {
  const ListScannedBarcodeWidget({
    super.key,
    required this.receivingCardItems,
  });

  final List<ReceivingCardItem> receivingCardItems;

  @override
  State<ListScannedBarcodeWidget> createState() =>
      _ListScannedBarcodeWidgetState();
}

class _ListScannedBarcodeWidgetState extends State<ListScannedBarcodeWidget> {
  final List<PlutoRow> rows = [];
  late List<PlutoColumn> columns;

  late PlutoGridStateManager stateManager;

  @override
  void initState() {
    columns = [
      PlutoColumn(
        title: 'Barcode',
        field: _kBarcodeFieldKey,
        hide: true,
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: LocaleKeys.gr_have_barcode_no.tr(),
        field: _kNoFieldKey,
        width: 120,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        type: PlutoColumnType.text(),
        footerRenderer: (rendererContext) {
          return PlutoAggregateColumnFooter(
            rendererContext: rendererContext,
            type: PlutoAggregateColumnType.count,
            titleSpanBuilder: (text) {
              return [
                const TextSpan(text: 'Số hộp: '),
                TextSpan(text: text),
              ];
            },
          );
        },
      ),
      PlutoColumn(
        title: 'Số lượng',
        field: _kQtyFieldKey,
        type: PlutoColumnType.number(),
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        footerRenderer: (rendererContext) {
          return PlutoAggregateColumnFooter(
            rendererContext: rendererContext,
            type: PlutoAggregateColumnType.sum,
            titleSpanBuilder: (text) {
              return [
                const TextSpan(text: 'Tổng: '),
                TextSpan(text: text),
              ];
            },
          );
        },
      ),
      PlutoColumn(
        title: '',
        width: 50,
        field: _kActionFieldKey,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        type: PlutoColumnType.number(),
        renderer: (rendererContext) {
          return PopupMenuButton(
            onSelected: (choice) {
              final cubit = context.read<GRHaveBarcodeController>();
              final state = cubit.state;

              final row = rendererContext.row;
              final barcodeString = rendererContext
                  .row.cells[_kBarcodeFieldKey]?.value as String?;
              final receivingCardItem = state.receivingCardItems
                  .firstWhere((e) => e.barcode == barcodeString);
              final index = state.receivingCardItems.indexOf(receivingCardItem);
              switch (choice) {
                case _BarcodeAction.view:
                  showBarcodeInfoDialog(context, barcode: receivingCardItem.partCard);
                case _BarcodeAction.findBarcodeLack:
                  final scanningBarcodes = state.receivingCardItems;
                  if (receivingCardItem.partCard.box != null) {
                    context.pushRoute(
                      CheckBarcodeLackRoute(
                        barcode: receivingCardItem.partCard,
                        scanningBarcode: scanningBarcodes,
                      ),
                    );
                  } else {
                    getIt<AppAlertDialog>().show(
                      context,
                      message: 'Tính năng không hỗ trợ cho loại barcode này',
                    );
                  }
                case _BarcodeAction.edit:
                  final quantity = receivingCardItem.currentQuantity;
                  showUpdateQuantityHaveBarcodeDialog(
                    context,
                    quantity: quantity,
                    onUpdate: (value) {
                      cubit.updateQuantityBarcode(index, value);
                      final cell = row.cells[_kQtyFieldKey];
                      if (cell != null) {
                        stateManager.changeCellValue(cell, value, force: true);
                      }
                    },
                  );
                case _BarcodeAction.delete:
                  cubit.removeBarcode(index);
                  stateManager.removeRows([row]);
              }
            },
            itemBuilder: (context) {
              return _BarcodeAction.values.map((choice) {
                return PopupMenuItem(
                  value: choice,
                  child: Text(choice.toString()),
                );
              }).toList();
            },
          );
        },
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GRHaveBarcodeController, GRHaveBarcodeState>(
      listenWhen: (preState, state) =>
          preState.receivingCardItems.length != state.receivingCardItems.length,
      listener: (context, state) {
        if (state.scanningItem == null) {
          stateManager.removeAllRows();
        } else {
          final lastIndex = stateManager.refRows.length;
          final row = List.generate(state.receivingCardItems.length - lastIndex,
              (index) {
            final receivingCardItem =
                state.receivingCardItems[lastIndex + index];
            return PlutoRow(
              cells: {
                _kBarcodeFieldKey: PlutoCell(value: receivingCardItem.barcode),
                _kNoFieldKey: PlutoCell(value: receivingCardItem.unitNo ?? ''),
                _kQtyFieldKey:
                    PlutoCell(value: receivingCardItem.currentQuantity),
                _kActionFieldKey: PlutoCell(value: 0),
              },
            );
          });

          stateManager.insertRows(lastIndex, row);
          stateManager.moveScrollByRow(
            PlutoMoveDirection.down,
            state.receivingCardItems.length,
          );
        }
      },
      child: PlutoGrid(
        mode: PlutoGridMode.readOnly,
        columns: columns,
        rows: rows,
        configuration: const PlutoGridConfiguration(
          columnSize: PlutoGridColumnSizeConfig(
            autoSizeMode: PlutoAutoSizeMode.scale,
          ),
        ),
        onLoaded: (event) {
          stateManager = event.stateManager;
          final row = List.generate(widget.receivingCardItems.length, (index) {
            final receivingCardItem = widget.receivingCardItems[index];
            return PlutoRow(
              cells: {
                _kBarcodeFieldKey: PlutoCell(value: receivingCardItem.barcode),
                _kNoFieldKey: PlutoCell(value: receivingCardItem.unitNo),
                _kQtyFieldKey:
                    PlutoCell(value: receivingCardItem.currentQuantity),
                _kActionFieldKey: PlutoCell(value: 0),
              },
            );
          });

          stateManager.insertRows(0, row);
          stateManager.moveScrollByRow(
            PlutoMoveDirection.down,
            widget.receivingCardItems.length,
          );
        },
      ),
    );
  }
}
