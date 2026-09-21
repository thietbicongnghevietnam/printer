import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/kitting/kitting_detail.dart';
import 'package:smart_warehouse/entities/storage_card.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/int_extensions.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/views/dialogs/kitting_detail_info_dialog.dart';
import 'package:smart_warehouse/views/pages/kitting/kitting/kitting_controller.dart';
import 'package:smart_warehouse/views/pages/kitting/kitting/kitting_state.dart';
import 'package:smart_warehouse/views/widgets/kitting_card_dialog.dart';

const _kIDFieldKey = 'id_field';
const _kMaterialFieldKey = 'material_field';
const _kLocationFieldKey = 'location_field';
const _kTimeFieldKey = 'time_field';
const _kLineFieldKey = 'line_field';
const _kModelFieldKey = 'model_field';
const _kPlantFieldKey = 'plant_field';
const _kSlocKey = 'sloc_field';
const _kDeliveryDate = 'delivery_date_field';
const _kActionFieldKey = 'action_field';

enum _BarcodeAction {
  view,
  reprint,
  checkStorage,
  find;

  @override
  String toString() {
    return switch (this) {
      view => 'Xem',
      reprint => 'In lại',
      checkStorage => 'Kiểm kho',
      find => 'Tìm vị trí',
    };
  }
}

class ListKittingDetailWidget extends StatefulWidget {
  const ListKittingDetailWidget(
      {super.key, required this.kittingDetails, this.scanningCard});

  final List<KittingDetail> kittingDetails;
  final StorageCard? scanningCard;

  @override
  State<ListKittingDetailWidget> createState() =>
      _ListKittingDetailWidgetState();
}

class _ListKittingDetailWidgetState extends State<ListKittingDetailWidget> {
  final List<PlutoRow> rows = [];
  late List<PlutoColumn> columns;

  late PlutoGridStateManager stateManager;

  @override
  void initState() {
    columns = [
      PlutoColumn(
        title: 'ID',
        field: _kIDFieldKey,
        hide: true,
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Vị trí',
        width: 120,
        field: _kLocationFieldKey,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        suppressedAutoSize: true,
        renderer: (rendererContext) {
          final arr = (rendererContext.cell.value as String).split(';');
          final location = arr[0];
          final warning = arr[1].toBool();

          return Row(
            children: [
              Text(
                location,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(width: 4),
              if (warning) Assets.images.icWarning.image(width: 16, height: 16),
            ],
          );
        },
      ),
      PlutoColumn(
        title: 'Mã',
        field: _kMaterialFieldKey,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        renderer: (rendererContext) {
          final arr = (rendererContext.cell.value as String).split(';');
          final material = arr[0];
          final kittingQuantity = arr[1].toInt();
          final totalQuantity = arr[2].toInt();
          final isPl = arr[3].toBool();
          final isOverdue = arr[4].toBool();
          //Tuấn Anh thêm
          final isSameMaterial = arr[5].toBool();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    material,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 1),
                  if (isPl) Assets.images.icPl.image(width: 14, height: 14),
                  const SizedBox(width: 1),
                  if (isOverdue)
                    Assets.images.expired.image(width: 14, height: 14),
                  //Tuấn Anh thêm
                  const SizedBox(width: 1),
                  if (isSameMaterial)
                    Assets.images.alarm.image(width: 14, height: 14),

                ],
              ),
              Text(
                '$kittingQuantity/$totalQuantity',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          );
        },
      ),
      PlutoColumn(
        title: 'Model',
        field: _kModelFieldKey,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
      ),
      PlutoColumn(
        title: 'Line',
        width: 80,
        field: _kLineFieldKey,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
      ),
      PlutoColumn(
        title: 'Time',
        width: 80,
        field: _kTimeFieldKey,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
      ),
      PlutoColumn(
        title: 'Plant',
        width: 80,
        field: _kPlantFieldKey,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
      ),
      PlutoColumn(
        title: 'Sloc',
        width: 80,
        field: _kSlocKey,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
      ),
      PlutoColumn(
        title: 'Delivery Date',
        width: 120,
        field: _kDeliveryDate,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
      ),
      PlutoColumn(
        title: '',
        width: 40,
        minWidth: 40,
        field: _kActionFieldKey,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        frozen: PlutoColumnFrozen.end,
        type: PlutoColumnType.number(),
        renderer: (rendererContext) {
          return PopupMenuButton(
            padding: EdgeInsets.zero,
            onSelected: (choice) async {
              final cubit = context.read<KittingController>();
              final state = cubit.state;

              final id = rendererContext.row.cells[_kIDFieldKey]?.value as int?;
              final kittingDetail = widget.kittingDetails
                  .firstWhere((element) => element.id == id);
              switch (choice) {
                case _BarcodeAction.view:
                  showKittingDetailInfoDialog(context, detail: kittingDetail);
                case _BarcodeAction.reprint:
                  final kittingCards =
                      await cubit.getKittingCardByKittingDetail(kittingDetail);
                  0.seconds.delay(() {
                    if (kittingCards.isEmpty) {
                      getIt<AppAlertDialog>().show(
                        context,
                        message: 'Item chưa in Kitting Card',
                      );
                      return;
                    }
                    createKittingCardDialog(
                      context,
                      kittingCards: kittingCards,
                      onConfirm: (printer, kittingCard) async {
                        await cubit.reprintKittingCards(
                          [kittingCard],
                          printer,
                        );
                        Duration.zero.delay(() async {
                          getIt<AppAlertDialog>().show(
                            context,
                            message: LocaleKeys.dialog_print_success.tr(),
                          );
                        });
                      },
                      printerDevices: cubit.printerDevices ?? [],
                      previousPrinterDevice: cubit.savedPrinterDevice,
                    );
                  });
                case _BarcodeAction.checkStorage:
                  context.pushRoute(CheckMaterialInStoreRoute(
                      positionOrRc: kittingDetail.locationName));
                case _BarcodeAction.find:
                  context.pushRoute(
                    EmapKittingRoute(
                      listKittingDetails: widget.kittingDetails,
                      selectedLocations: [kittingDetail.locationName ?? ''],
                      orderBlocks: state.orderBlocks,
                      suggestPaths: state.suggestPaths,
                    ),
                  );
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

    rows.addAll(_loadData());
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ListKittingDetailWidget oldWidget) {
    if (oldWidget.scanningCard?.material != widget.scanningCard?.material ||
        oldWidget.kittingDetails != widget.kittingDetails) {
      stateManager.removeAllRows();
      stateManager.insertRows(0, _loadData());
    }
    super.didUpdateWidget(oldWidget);
  }

  List<PlutoRow> _loadData() {
    return (widget.scanningCard != null
            ? widget.kittingDetails.where(
                (element) => element.material == widget.scanningCard?.material)
            : widget.kittingDetails)
        .map(
          (e) => PlutoRow(
            cells: {
              _kIDFieldKey: PlutoCell(value: e.id),
              _kMaterialFieldKey: PlutoCell(
                value:
                    '${e.material};${e.pickedQuantity};${e.quantity};${e.pl == 'PL'};${e.isOverdue};${e.sameMaterial}',
              ),
              _kLocationFieldKey: PlutoCell(
                  value: '${e.locationName};${e.missingItem.isNotEmpty()}'),
              _kModelFieldKey: PlutoCell(value: e.model),
              _kLineFieldKey: PlutoCell(value: e.line),
              _kTimeFieldKey: PlutoCell(value: e.time),
              _kPlantFieldKey: PlutoCell(value: e.plant),
              _kSlocKey: PlutoCell(value: e.sloc),
              _kDeliveryDate: PlutoCell(value: e.deliveryDate?.toText()),
              _kActionFieldKey: PlutoCell(),
            },
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<KittingController, KittingState>(
      listener: (context, state) {
        if (state.selectedKittingDetails.isEmpty) {
          stateManager.clearCurrentSelecting();
        }
      },
      listenWhen: (preState, state) =>
          preState.selectedKittingDetails != state.selectedKittingDetails,
      child: PlutoGrid(
        columns: columns,
        rows: rows,
        mode: PlutoGridMode.multiSelect,
        onLoaded: (event) {
          stateManager = event.stateManager;
          stateManager.addListener(() {
            final selectedRows = stateManager.currentSelectingRows;
            final selectedKittingDetails = <int>[];
            for (final row in selectedRows) {
              final id = row.cells[_kIDFieldKey]?.value as int;
              selectedKittingDetails.add(id);
            }
            selectedKittingDetails.sort((a, b) => a.compareTo(b));
            final cubit = context.read<KittingController>();
            cubit.updateSelectedKittingDetails(selectedKittingDetails);
          });
        },
        rowColorCallback: (rowColorContext) {
          final id = rowColorContext.row.cells[_kIDFieldKey]?.value as int?;
          final kittingDetail = widget.kittingDetails
              .firstWhereOrNull((element) => element.id == id);

          if (kittingDetail == null) {
            return Colors.white;
          }
          if (kittingDetail.pickedQuantity == kittingDetail.quantity) {
            return Colors.greenAccent;
          } else if (kittingDetail.pickedQuantity > 0) {
            return Colors.yellowAccent;
          } else {
            return Colors.white;
          }
        },
      ),
    );
  }
}
