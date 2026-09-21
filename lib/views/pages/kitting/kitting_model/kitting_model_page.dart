import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/kitting/kitting_detail.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/int_extensions.dart';
import 'package:smart_warehouse/shared/extensions/table_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/dialogs/kitting_ntime_dialog.dart';
import 'package:smart_warehouse/views/dialogs/location_kitting_dialog.dart';
import 'package:smart_warehouse/views/pages/kitting/kitting_model/kitting_model_controller.dart';
import 'package:smart_warehouse/views/pages/kitting/kitting_model/kitting_model_state.dart';
import 'package:smart_warehouse/views/widgets/app_drop_down.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_radio.dart';
import 'package:smart_warehouse/views/widgets/app_table.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';
import 'package:smart_warehouse/views/widgets/kitting_card_dialog.dart';

@RoutePage()
class KittingModelPage
    extends BasePage<KittingModelController, KittingModelState> {
  const KittingModelPage({
    super.key,
  });

  @override
  BasePageState createState() => _KittingModelPageState();
}

class _KittingModelPageState
    extends BasePageState<KittingModelController, KittingModelState> {
  final List<PlutoRow> rows = [];
  late List<PlutoColumn> columns = [];

  late PlutoGridStateManager stateManager;
  late TextEditingController _codeController;
  late PlutoInfinityScrollRowsRequest request;
  late FocusNode _barCodeFocusNode;

  @override
  void initState() {
    final controller = context.read<KittingModelController>();
    initColumn(controller);
    _codeController = TextEditingController();
    _barCodeFocusNode = FocusNode();
    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) {
      controller.scanCard(data);
    });
    super.initState();
  }

  @override
  void handleError(
      BuildContext context,
      Object? error, [
        StackTrace? stackTrace,
      ]) {
    final cubit = context.read<KittingModelController>();
    if (error is ValidationError) {
      if (error.type == ValidationErrorType.barcodeNotSame) {
        getIt<AppAlertDialog>().show(
          context,
          type: AppAlertType.confirm,
          barrierDismissible: true,
          message:
          '${error.message}\n${LocaleKeys.dialog_discard_current_receive_card.tr()}',
          onConfirm: () {
            cubit.discardBarcode();
          },
        );
        return;
      }

      if (error.type == ValidationErrorType.connectPrinterError) {
        getIt<AppAlertDialog>().show(
          context,
          type: AppAlertType.error,
          barrierDismissible: true,
          message: LocaleKeys.error_cannot_connect_with_printer.tr(),
          onConfirm: () {
            cubit.cleatData();
          },
        );
        return;
      }

      if (error.type == ValidationErrorType.isNotFirstLot) {
        getIt<AppAlertDialog>().show(
          context,
          type: AppAlertType.warning,
          barrierDismissible: true,
          message: 'Card đã quét không phải last lot!',
          onConfirm: () {},
        );
        return;
      }
    }

    if (error is ServerError) {
      getIt<AppAlertDialog>().show(
        context,
        type: AppAlertType.error,
        barrierDismissible: true,
        message: error.message,
        onConfirm: () {
          cubit.cleatData();
        },
      );
      return;
    }
    super.handleError(context, error, stackTrace);
  }

  late PdaDevice pdaDevice;
  @override
  Widget builder(
    BuildContext context,
    KittingModelController cubit,
    KittingModelState state,
  ) {
    return BlocListener<KittingModelController, KittingModelState>(
      listenWhen: (preState, state) => preState.material != state.material,
      listener: (context, state) {
        ScaffoldMessenger.of(context).clearSnackBars();
        _codeController.text = state.material ?? '';
        const Duration(milliseconds: 500).delay(() async {
          stateManager.eventManager?.addEvent(PlutoGridRefetchDataEvent());
        });
        cubit.updatePage();
      },
      child: Scaffold(
        appBar: _buildAppBar(cubit, state),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      BlocSelector<KittingModelController, KittingModelState,
                          (int?, int?, bool?)>(
                        selector: (state) => (
                          state.startTime,
                          state.endTime,
                          state.isOnTheHour,
                        ),
                        builder: (context, state) {
                          return IconButton(
                            onPressed: () async {
                              Duration.zero.delay(() async {
                                await kittingNTimeDialog(
                                  context,
                                  startTime: state.$1 ?? 0,
                                  endTime: state.$2 ?? 0,
                                  isOnTheHour: state.$3,
                                  onConfirm: (
                                    timeStart,
                                    timeEnd,
                                    isOnTheHour,
                                  ) async {
                                    await cubit.updateTime(
                                      startTime: timeStart,
                                      endTime: timeEnd,
                                      isOnTheHour: isOnTheHour,
                                    );
                                    stateManager.eventManager?.addEvent(
                                      PlutoGridRefetchDataEvent(),
                                    );
                                  },
                                );
                              });
                            },
                            icon: const Icon(Icons.watch_later_outlined),
                          );
                        },
                      ),
                      const Text('Chọn Giờ'),
                      BlocSelector<KittingModelController, KittingModelState,
                          bool>(
                        selector: (state) => state.isKittingEnough,
                        builder: (context, isKittingEnough) {
                          return Expanded(
                            child: CheckboxListTile(
                              value: isKittingEnough,
                              contentPadding: EdgeInsets.zero,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: const Text('Chưa Kitting'),
                              onChanged: (_) async {
                                await cubit.updateKittingEnough(
                                  isKittingEnough: isKittingEnough,
                                );
                                stateManager.eventManager
                                    ?.addEvent(PlutoGridRefetchDataEvent());
                              },
                            ),
                          );
                        },
                      ),
                      AppRadio(
                        value: '',
                        groupValue: '',
                        onChanged: (value) async {
                          await cubit.resetData();
                          stateManager.eventManager
                              ?.addEvent(PlutoGridRefetchDataEvent());
                        },
                        title: 'Total',
                      ),
                    ],
                  ),
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FixedColumnWidth(100),
                      1: FlexColumnWidth(),
                    },
                    children: [
                      TableRow(
                        children: [
                          const Text('Model:'),
                          BlocSelector<KittingModelController, KittingModelState, List<KittingDetail>>(
                            selector: (state) => state.kittingModels,
                            builder: (context, kittingModels) {
                              return AppDropdown(
                                displayStringForOption: (option) => option,
                                options: kittingModels
                                    .map((element) => element.model)
                                    .toSet()
                                    .toList(),
                                onChange: (value) {
                                  cubit.updateModel(value);
                                  stateManager.eventManager
                                      ?.addEvent(PlutoGridRefetchDataEvent());
                                  _barCodeFocusNode.requestFocus();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text('Scan code:'),
                          AppFormField(
                            readOnly: true,
                            showCursor: true,
                            showClear: false,
                            controller: _codeController,
                            focusNode: _barCodeFocusNode,
                          ),
                        ],
                      ),
                    ].withSpaceBetween(10),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text('Total kitting card:'),
                      const SizedBox(
                        width: 10,
                      ),
                      BlocBuilder<KittingModelController, KittingModelState>(
                        buildWhen: (pre, current) =>
                            pre.totalRecord != current.totalRecord ||
                            pre.countKittingDone != current.countKittingDone,
                        builder: (context, state) {
                          return AppText.title(
                            '${state.countKittingDone}/${state.totalRecord}',
                          );
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text('Qty Barcode:'),
                      const SizedBox(
                        width: 10,
                      ),
                      BlocBuilder<KittingModelController, KittingModelState>(
                        buildWhen: (pre, current) =>
                            pre.totalQuantityBarcode !=
                            current.totalQuantityBarcode,
                        builder: (context, state) {
                          return AppText.title(
                            '${state.totalQuantityBarcode}',
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5,),
            BlocBuilder<KittingModelController, KittingModelState>(
              buildWhen: (pre, current) =>
                  pre.kittingModels != current.kittingModels,
              builder: (context, kittingList) {
                return Expanded(
                  child: PlutoGrid(
                    mode: PlutoGridMode.readOnly,
                    columns: columns,
                    rows: rows,
                    onLoaded: (event) {
                      stateManager = event.stateManager;
                    },
                    rowColorCallback: (rowColorContext) {
                      return cubit.setRowColor(rowColorContext);
                    },
                    createFooter: (s) {
                      return AppTable(
                        fetch: (request) =>
                            cubit.fetchData(request, s, context),
                        stateManager: s,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar:
            BlocBuilder<KittingModelController, KittingModelState>(
          buildWhen: (pre, current) =>
              pre.quantityStorage != current.quantityStorage ||
              current.totalQuantityBarcode != pre.totalQuantityBarcode ||
              pre.kittingModels != current.kittingModels,
          builder: (context, state) {
            return ElevatedButton(
              onPressed: () async {
                await confirmPrintKittingCard(context, cubit, state);
              },
              child: const Text('Print Kitting Card'),
            ).paddingSymmetric(horizontal: 16, vertical: 8);
          },
        ),
      ),
    );
  }

  void initColumn(KittingModelController cubit) {
    columns = [
      PlutoColumn(
        title: 'Part',
        field: Constants.kPartFieldKey,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        enableFilterMenuItem: false,
        width: 220,
        renderer: (rendererContext) {
          final pl = rendererContext.row.cells[Constants.kPl]?.value as String?;
          final isOverDue = rendererContext.row.cells[Constants.kOverDue]?.value as bool;
          final missing = rendererContext.row.cells[Constants.kMissing]?.value as String?;
          return Row(
            children: [
              Text(rendererContext.cell.value.toString()),
              const SizedBox(width: 5,),
              if (pl?.trim() == 'PL')
                Image.asset(Assets.icons.poland.path)
              else
                const SizedBox(),
              if (isOverDue)
                const Icon(Icons.ac_unit_rounded)
              else
                const SizedBox(),
              if (missing != '' && missing != null)
                Assets.images.expired.image(width: 25, height: 25)
              else
                const SizedBox(),
            ],
          );
        },
      ),
      PlutoColumn(
        title: 'Location',
        field: Constants.kLocationFieldKey,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        width: 160,
        enableColumnDrag: false,
        enableFilterMenuItem: false,
        // renderer: (rendererContext) {
        //   final locationName = rendererContext
        //       .row.cells[Constants.kLocationFieldKey]?.value as String?;
        //   final listName = locationName?.split(',');
        //   final isOverDue = rendererContext.row.cells[Constants.kOverDue]?.value as bool;
        //   final missing = rendererContext.row.cells[Constants.kMissing]?.value as String?;
        //   return Row(
        //     children: [
        //       Expanded(child: Text(listName?.firstOrNull ?? '')),
        //       if (listName?.length != 1)
        //         IconButton(
        //           onPressed: () {
        //             Duration.zero.delay(() async {
        //               await locationKittingDialog(context, locations: listName ?? []);
        //             });
        //           },
        //           icon: Icon(Icons.add_circle_outline),
        //         )
        //       else
        //         SizedBox(),
        //
        //       if (isOverDue)
        //        Icon(Icons.ac_unit_rounded)
        //       else
        //         SizedBox(),
        //
        //       if (missing != '')
        //         Icon(Icons.area_chart)
        //       else
        //         SizedBox(),
        //     ],
        //   );
        // },
      ),
      PlutoColumn(
        title: 'Model',
        field: Constants.kModelFieldKey,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        enableFilterMenuItem: false,
      ),
      PlutoColumn(
        title: 'Quantity',
        field: Constants.kQuantityFieldKey,
        type: PlutoColumnType.number(),
        enableContextMenu: false,
        enableDropToResize: false,
        width: 80,
        enableColumnDrag: false,
        enableFilterMenuItem: false,
      ),
      PlutoColumn(
        title: 'Time',
        field: Constants.kTimeFieldKey,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        width: 80,
        enableColumnDrag: false,
        enableFilterMenuItem: false,
      ),
      PlutoColumn(
        title: 'PickedQuantity',
        field: Constants.kPickedQuantityFieldKey,
        type: PlutoColumnType.number(),
        enableContextMenu: false,
        enableDropToResize: false,
        width: 80,
        enableColumnDrag: false,
        enableFilterMenuItem: false,
      ),
      PlutoColumn(
        title: 'Plant',
        field: Constants.kPlantFieldKey,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        width: 80,
        enableColumnDrag: false,
        enableFilterMenuItem: false,
      ),
      PlutoColumn(
        title: 'Sloc',
        field: Constants.kSlocKey,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        width: 80,
        enableColumnDrag: false,
        enableFilterMenuItem: false,
      ),
      PlutoColumn(
        title: 'Delivery Date',
        field: Constants.kDeliveryDate,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        width: 120,
        enableColumnDrag: false,
        enableFilterMenuItem: false,
      ),
      PlutoColumn(
        title: 'PL',
        field: Constants.kPl,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        width: 60,
        enableColumnDrag: false,
        enableFilterMenuItem: false,
      ),
      PlutoColumn(
        title: '',
        field: Constants.kReprint,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        width: 60,
        enableColumnDrag: false,
        enableFilterMenuItem: false,
        renderer: (rendererContext) {
          final pickedQty = rendererContext
              .row.cells[Constants.kPickedQuantityFieldKey]?.value as int?;
          final index = rendererContext.rowIdx;

          if (pickedQty != 0) {
            return IconButton(
              onPressed: () async {
                final kittingCards = await cubit.rePrintKittingCard(index);
                final kittingCardsMap = kittingCards.where((element) => element.status != 1).toList();
                Duration.zero.delay(() async {
                  await createKittingCardDialog(
                    context,
                    kittingCards: kittingCardsMap,
                    onConfirm: (printer, kittingCard) async {
                      await cubit.checkConnectPrint(printerDevice: printer);
                      await cubit.printKittingCard(
                        printerDevice: printer,
                        kittingCards: [kittingCard],
                      );
                      Duration.zero.delay(() async {
                        getIt<AppAlertDialog>().show(
                          context,
                          message: LocaleKeys.dialog_print_success.tr(),
                          onConfirm: () {
                            cubit.commands.clear();
                          },
                        );
                      });
                    },
                    printerDevices: cubit.printerDevices ?? [],
                    previousPrinterDevice: cubit.savePrinterDevice,
                  );
                });
              },
              icon: const Icon(Icons.add),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    ];
  }

  AppBar _buildAppBar(
    KittingModelController cubit,
    KittingModelState state,
  ) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.maybePop();
        },
      ),
      title: const Text('Kitting Model'),
      actions: [
        IconButton(
          icon: const Icon(Icons.calendar_month),
          onPressed: () async {
            final response = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(100.days),
              lastDate: DateTime.now().add(10.days),
            );
            final deliveryDate = response?.toText(DateTimeType.yyyyMMdd);
            cubit.updateDeliveryDate(deliveryDate);
            stateManager.eventManager?.addEvent(PlutoGridRefetchDataEvent());
          },
        ),
        IconButton(
          icon: const Icon(Icons.map_outlined),
          onPressed: () async {
            await cubit.getPositionOfMaterialOnMap(
              context,
              stateManager,
            );
          },
        ),
        BlocBuilder<KittingModelController, KittingModelState>(
          buildWhen: (pre, current) =>
              pre.receivingCards != current.receivingCards ||
              pre.receivingCardItems != current.receivingCardItems,
          builder: (context, state) {
            final count = (state.receivingCards?.length ?? 0) +
                (state.receivingCardItems?.length ?? 0);
            return Visibility(
              child: IconButton(
                onPressed: () {
                  context.pushRoute(
                    BarCodeScannedRoute(
                      removeReceivingCardCallBack: (receivingCard) async {
                        await cubit.removeReceivingCard(receivingCard);
                      },
                      removePartCardCallBack: (receivingCardItem) async {
                        await cubit.removePartCard(receivingCardItem);
                      },
                      receivingCards: state.receivingCards,
                      receivingCardItems: state.receivingCardItems,
                      backToScreen: () async {
                        await cubit.updatePage();
                        stateManager.eventManager
                            ?.addEvent(PlutoGridRefetchDataEvent());
                      },
                    ),
                  );
                },
                icon: Badge(
                  label: Text(count.toString()),
                  child: const Icon(Icons.shopping_cart_checkout),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Future<void> confirmPrintKittingCard(
    BuildContext context,
    KittingModelController cubit,
    KittingModelState state,
  ) async {
    if (state.receivingCards!.isEmpty && state.receivingCardItems!.isEmpty) {
      getIt<AppAlertDialog>()
          .show(context, message: 'Vui lòng quét barcode để kitting!');
    } else {
      final listRow = stateManager.currentSelectingRows.toList();
      final listIndex = List<int>.empty(growable: true);
      for (final element in listRow) {
        listIndex.add(element.sortIdx);
      }
      var listKittingDetails = List<KittingDetail>.empty(growable: true);
      if (listIndex.isEmpty) {
        listKittingDetails = state.kittingModels;
      } else {
        for (final element in listRow) {
          listKittingDetails.add(state.kittingModels[element.sortIdx]);
        }
      }
      final modifiableList = List<KittingDetail>.from(listKittingDetails);
      final kittingCardPreview =
          await cubit.createKittingCard(kittingModels: modifiableList);
      Duration.zero.delay(() async {
        await createKittingCardDialog(
          context,
          kittingCards: kittingCardPreview,
          onConfirm: (printer, kittingCard) async {
            await cubit.createKittingCard(
              printer: printer,
              isPreview: false,
              kittingModels: modifiableList,
            );
            Duration.zero.delay(() async {
              getIt<AppAlertDialog>().show(
                context,
                message: LocaleKeys.dialog_print_success.tr(),
                onConfirm: () async {
                  await cubit.updatePage();
                },
              );
            });
          },
          printerDevices: cubit.printerDevices ?? [],
          previousPrinterDevice: cubit.savePrinterDevice,
        );
      });
    }
  }
}
