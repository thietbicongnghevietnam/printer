import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/enums/receving_card_type.dart';
import 'package:smart_warehouse/enums/storage_scan_recard_error.dart';
import 'package:smart_warehouse/services/models/response/plant_type_freqquency_response_model.dart';
import 'package:smart_warehouse/services/models/response/sloc_info_from_plant_response_model.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/dialogs/receiving_card_dialog.dart';
import 'package:smart_warehouse/views/dialogs/view_barcode_dialog.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

import 'stock_to_receiving_card_controller.dart';
import 'stock_to_receiving_card_state.dart';

@RoutePage()
class StockToReceivingCardPage extends BasePage<StockToReceivingCardController,
    StockToReceivingCardState> {
  const StockToReceivingCardPage({super.key});

  @override
  BasePageState createState() => _StockToReceivingCardState();
}

class _StockToReceivingCardState extends BasePageState<
    StockToReceivingCardController, StockToReceivingCardState> {
  late TextEditingController stockCardController;
  late TextEditingController qtyController;
  late TextEditingController boxCardController;
  late TextEditingController editQtyController;
  late TextEditingController wareHouseController;

  late FocusNode stockCardFocusNode;
  late FocusNode qtyFocusNode;
  late FocusNode boxTotalFocusNode;
  late FocusNode boxCardFocusNode;
  late FocusNode wareHouseFocusNode;
  late PdaDevice pdaDevice;

  final dateFormat = DateFormat('dd/MM/yy');

  @override
  void initState() {
    super.initState();

    stockCardController = TextEditingController();
    qtyController = TextEditingController();
    boxCardController = TextEditingController();
    editQtyController = TextEditingController();
    wareHouseController = TextEditingController();

    stockCardFocusNode = FocusNode()..requestFocus();
    qtyFocusNode = FocusNode();
    boxTotalFocusNode = FocusNode();
    boxCardFocusNode = FocusNode();
    wareHouseFocusNode = FocusNode();

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) async {
      if (stockCardFocusNode.hasFocus) {
        await context
            .read<StockToReceivingCardController>()
            .scanStockCard(data);
        stockCardController.text = data;
        boxCardFocusNode.requestFocus();
      } else if (boxCardFocusNode.hasFocus) {
        context.read<StockToReceivingCardController>().inputBoxCard(data);
      } else if (wareHouseFocusNode.hasFocus) {
        context.read<StockToReceivingCardController>().scanWarehouseCard(data);
      }
    });
  }

  @override
  void dispose() {
    stockCardController.dispose();
    pdaDevice.dispose();
    super.dispose();
  }

  @override
  Widget builder(context, cubit, state) {
    return MultiBlocListener(
      listeners: [
        BlocListener<StockToReceivingCardController, StockToReceivingCardState>(
          listenWhen: (prev, current) {
            return prev.stockCard != current.stockCard;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();
            qtyController.text = state.stockCard?.quantity ?? '';
          },
        ),
        BlocListener<StockToReceivingCardController, StockToReceivingCardState>(
          listenWhen: (prev, current) {
            return prev.stockToRcError != current.stockToRcError;
          },
          listener: (context, state) {
            if (state.stockToRcError != null) {
              switch (state.stockToRcError) {
                case StockToRcError.materialNotSame:
                  throw ValidationError(
                    type: ValidationErrorType.materialNotSame,
                  );
                case StockToRcError.boxCardScanned:
                  throw ValidationError(
                    type: ValidationErrorType.boxCardScanned,
                  );
                case StockToRcError.doNotHaveVendorInfo:
                  throw ValidationError(
                    type: ValidationErrorType.doNotHaveVendorInfo,
                  );
                case null:
              }
            }
          },
        ),
      ],
      child: BlocBuilder<StockToReceivingCardController,
          StockToReceivingCardState>(
        buildWhen: (prev, current) {
          return prev.stockCard != current.stockCard;
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title:
                  const Text(LocaleKeys.storing_stock_to_receiving_card).tr(),
              actions: [
                Visibility(
                  visible: state.stockCard != null ,
                  child: GestureDetector(
                    onTap: () {
                      context.pushRoute(
                        RePrintRcConvertRoute(
                            stockBarcode: state.stockCard?.barcode ?? ''),
                      );
                    },
                    child: const Icon(
                      Icons.print_rounded,
                      size: 30,
                      color: Colors.white,
                    ).paddingAll(8),
                  ),
                ),
              ],
            ),
            body: _buildBody(cubit),
            bottomNavigationBar: BlocBuilder<StockToReceivingCardController,
                StockToReceivingCardState>(
              buildWhen: (prev, current) {
                return prev.stockCard != current.stockCard ||
                    prev.listPlant != current.listPlant ||
                    prev.currentPlant != current.currentPlant ||
                    prev.currentSloc != current.currentSloc ||
                    prev.currentListSloc != current.currentListSloc ||
                    prev.currentCategory != current.currentCategory ||
                    prev.currentListCate != current.currentListCate ||
                    prev.boxCardList != current.boxCardList;
              },
              builder: (context, state) {
                return ElevatedButton(
                  child:
                      const Text('Chuyển Stock Card sang Receiving Card').tr(),
                  onPressed: () async {
                    await handleConvertStockToRC(state, cubit);
                  },
                );
              },
            ).paddingSymmetric(horizontal: 16, vertical: 8),
          );
        },
      ),
    );
  }

  Widget _buildBody(StockToReceivingCardController cubit) {
    return BlocBuilder<StockToReceivingCardController,
        StockToReceivingCardState>(
      buildWhen: (prev, current) {
        return prev.stockCard != current.stockCard ||
            prev.listPlant != current.listPlant ||
            prev.urgenUlcoc != current.urgenUlcoc ||
            prev.samplingRohsVendor != current.samplingRohsVendor ||
            prev.currentListSloc != current.currentListSloc ||
            prev.rcTime != current.rcTime ||
            prev.boxCardList != current.boxCardList;
      },
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildStockCardTextField(cubit),
              if (state.stockCard != null) ...[
                const SizedBox(height: 12),
                if (state.stockCard?.vendorCode != null &&
                    state.stockCard!.vendorCode!.isNotEmpty &&
                    state.stockCard?.material != null &&
                    state.stockCard!.material!.isNotEmpty) ...[
                  _buildMaterial(state),
                ],
                Row(
                  children: [
                    const Text('DeliveryDate: '),
                    const SizedBox(width: 10),
                    BlocBuilder<StockToReceivingCardController,
                        StockToReceivingCardState>(
                      buildWhen: (prev, current) {
                        return prev.rcTime != current.rcTime;
                      },
                      builder: (context, state) {
                        final fromDate = state.stockCard?.deliveryDate ??
                            dateFormat.format(state.rcTime ?? DateTime.now());
                        return InkWell(
                          onTap: () {
                            DatePicker.showDatePicker(
                              context,
                              minTime: DateTime(2001),
                              maxTime: DateTime.now(),
                              onChanged: (date) {
                                cubit.onChangeRcDate(date);
                              },
                              onConfirm: (date) {
                                cubit.onChangeRcDate(date);
                              },
                              currentTime: state.rcTime,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(),
                            ),
                            child: Text(
                              fromDate,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ).paddingSymmetric(vertical: 10),
                if (state.listPlant.isNotEmpty) ...[
                  _buildPlantSlocSelection(cubit),
                ],
                const SizedBox(height: 12),
                _buildInputQty(cubit),
                const SizedBox(height: 12),
                _buildInputBoxCard(cubit),
                const SizedBox(height: 12),
                if (state.boxCardList.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tổng số Box: ${state.boxCardList.length}'),
                      Text(
                          'Tổng số lượng: ${state.boxCardList.fold(0, (sum, e) => sum + e.quantity)}/${qtyController.text}'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildBoxList(cubit, state),
                ],
                const SizedBox(height: 24),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildStockCardTextField(StockToReceivingCardController cubit) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: const Text(LocaleKeys.storing_stock_card).tr(),
        ),
        Expanded(
          child: AppFormField(
            readOnly: true,
            showCursor: true,
            controller: stockCardController,
            focusNode: stockCardFocusNode,
            onChanged: cubit.scanStockCard,
          ),
        ),
      ],
    );
  }

  Widget _buildInputQty(StockToReceivingCardController cubit) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: const Text(LocaleKeys.storing_stock_quantity).tr(),
        ),
        Expanded(
          child: AppFormField(
            showCursor: true,
            controller: qtyController,
            focusNode: qtyFocusNode,
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _buildInputBoxCard(StockToReceivingCardController cubit) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: const Text(LocaleKeys.storing_input_box_card).tr(),
        ),
        Expanded(
          child: AppFormField(
            showCursor: true,
            readOnly: true,
            controller: boxCardController,
            focusNode: boxCardFocusNode,
            onChanged: cubit.inputBoxCard,
          ),
        ),
      ],
    );
  }

  Widget _buildMaterial(StockToReceivingCardState state) {
    return Row(
      children: [
        const Text(LocaleKeys.storing_material).tr(),
        Text(
          ': ${state.stockCard?.material ?? ''}',
          style: const TextStyle(
            color: Color(0xff0A2753),
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ).tr(),
      ],
    );
  }

  Widget _buildPlantSlocSelection(StockToReceivingCardController cubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              'Plant',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 15,
              ),
            ),
            const SizedBox(width: 4),
            _buildPlantSelection(cubit),
          ],
        ),
        Row(
          children: [
            const Text(
              'Sloc',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 15,
              ),
            ),
            const SizedBox(width: 4),
            _buildSlocSelection(cubit),
          ],
        ),
        Row(
          children: [
            const Text(
              'Cate',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 15,
              ),
            ),
            const SizedBox(width: 4),
            _buildSelectCategory(cubit),
          ],
        ),
      ],
    );
  }

  Widget _buildSelectCategory(StockToReceivingCardController cubit) {
    return BlocBuilder<StockToReceivingCardController,
        StockToReceivingCardState>(
      buildWhen: (prev, current) {
        return prev.currentCategory != current.currentCategory ||
            prev.currentListCate != current.currentListCate;
      },
      builder: (context, state) {
        final listCate = state.currentListCate;
        if (listCate.isEmpty) {
          return const SizedBox();
        }
        return DropdownButton<String>(
          value: state.currentCategory,
          icon: const Icon(Icons.keyboard_arrow_down),
          style: const TextStyle(color: Colors.blue),
          onChanged: (value) {
            cubit.onSelectCate(value ?? '');
          },
          items: state.currentListCate.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildPlantSelection(StockToReceivingCardController cubit) {
    return BlocBuilder<StockToReceivingCardController,
        StockToReceivingCardState>(
      buildWhen: (prev, current) {
        return prev.currentPlant != current.currentPlant ||
            prev.listPlant != current.listPlant;
      },
      builder: (context, state) {
        final plant = state.listPlant;
        if (plant.isEmpty) {
          return const SizedBox();
        }
        return DropdownButton<PlantTypeFrequencyResponseModel>(
          value: state.currentPlant,
          icon: const Icon(Icons.keyboard_arrow_down),
          style: const TextStyle(color: Colors.blue),
          onChanged: (value) {
            cubit.onSelectPlant(value!);
          },
          items: plant
              .map<DropdownMenuItem<PlantTypeFrequencyResponseModel>>((value) {
            return DropdownMenuItem<PlantTypeFrequencyResponseModel>(
              value: value,
              child: Text(value.plant ?? ''),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildSlocSelection(StockToReceivingCardController cubit) {
    return BlocBuilder<StockToReceivingCardController,
        StockToReceivingCardState>(
      buildWhen: (prev, current) {
        return prev.currentListSloc != current.currentListSloc ||
            prev.currentSloc != current.currentSloc;
      },
      builder: (context, state) {
        final listSloc = state.currentListSloc;
        if (listSloc.isEmpty) {
          return const SizedBox();
        }
        return DropdownButton<SlocInfoFromPlantResponseModel>(
          value: state.currentSloc,
          icon: const Icon(Icons.keyboard_arrow_down),
          style: const TextStyle(color: Colors.blue),
          onChanged: (value) {
            cubit.onSelectSloc(value!);
          },
          items: state.currentListSloc
              .map<DropdownMenuItem<SlocInfoFromPlantResponseModel>>((value) {
            return DropdownMenuItem<SlocInfoFromPlantResponseModel>(
              value: value,
              child: Text(value.sloc ?? ''),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildBoxList(
      StockToReceivingCardController cubit, StockToReceivingCardState state) {
    final boxList = state.boxCardList;
    if (boxList.isEmpty) {
      return const SizedBox.shrink();
    }
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 2.5,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: boxList.length,
      itemBuilder: (c, i) {
        return GestureDetector(
          onDoubleTap: () {
            showBarcodeInfoDialog(context, barcode: boxList[i]);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildRichTextNote(
                      label: 'Box no:',
                      value:
                          '${boxList[i].unitNo?.substring((boxList[i].unitNo?.length ?? 1) - 1)}',
                    ),
                    const SizedBox(height: 10),
                    _buildRichTextNote(
                      label: 'Qty',
                      value: boxList[i].quantity.toString(),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        _showModelEditBoxCard(boxList[i].quantity, () {
                          cubit.updateBoxCard(
                            i,
                            editQtyController.text.toInt(),
                          );
                          editQtyController = TextEditingController();
                          Navigator.pop(context);
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          Icons.edit,
                          color: Colors.black54,
                          size: 20,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        cubit.removeBoxCard(i);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRichTextNote({
    required String label,
    required String value,
  }) {
    return RichText(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: Colors.red,
        ),
        children: [
          TextSpan(
            text: ' $value',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _showModelEditBoxCard(int qty, Function onTap) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Số lượng',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black54,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 10),
                  AppFormField(
                    showCursor: true,
                    controller: editQtyController,
                    decoration: InputDecoration(
                      hintText: qty.toString(),
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                        fontSize: 17,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 15),
                  const Divider(height: 1, color: Colors.grey),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    child: const Text('Cập nhật số lượng').tr(),
                    onPressed: () async {
                      onTap.call();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> handleConvertStockToRC(
    StockToReceivingCardState state,
    StockToReceivingCardController cubit,
  ) async {
    final qty = qtyController.text.toInt();
    final sloc = state.currentSloc;
    final plant = state.currentPlant;
    final cate = state.currentCategory;
    final boxTotalInput = state.boxCardList.length;
    final qtyTotal = state.boxCardList.fold(0, (sum, e) => sum + e.quantity);
    final barcodeStock = stockCardController.text;
    if (sloc == null || plant == null || cate.isEmpty) {
      getIt<AppAlertDialog>().show(
        context,
        type: AppAlertType.error,
        message: 'Vui lòng chọn Sloc, Plant, Category!',
      );
      return;
    }

    if (boxTotalInput > 0) {
      if (qty != qtyTotal && state.boxCardList.isNotEmpty) {
        getIt<AppAlertDialog>().show(
          context,
          type: AppAlertType.error,
          message:
              'Số lượng nhập thực tế đang không bằng số lượng tổng các Barcode',
        );
        return;
      }
    }

    final receivingCardRQ = ReceivingCard(
      plant: state.currentPlant?.plant ?? '',
      receivingCardDate:
          state.stockCard?.deliveryDate?.toDate(DateTimeType.MMddyyyy),
      urgent: state.urgenUlcoc?.urgent ?? '',
      ulcoc: state.urgenUlcoc?.ulcoc ?? '',
      material: state.stockCard?.material ?? '',
      materialType: state.currentSloc?.type ?? '',
      materialFrequency: state.currentSloc?.frequency ?? '',
      daInvNoFromStock: state.stockCard?.daInv,
      vendorCode: state.stockCard?.vendorCode,
      category: state.currentCategory,
      pl: state.samplingRohsVendor?.iqcpl ?? '',
      rohs: state.samplingRohsVendor?.rohs ?? '',
      sloc: state.currentSloc?.sloc ?? '',
      vendorName: state.samplingRohsVendor?.vendorName ?? '',
      samplingCheck: state.samplingRohsVendor?.samplingCheck == 1,
      rohsCheck: state.samplingRohsVendor?.rohsCheck == 1,
      haveBarcode: true,
      totalQuantity: qty,
      currentQuantity: qtyTotal == 0 ? qty : qtyTotal,
      box: boxTotalInput,
      id: 0,
      barcode: '',
      rcType: ReceivingCardPrinterType.rcConvert,
    );

    await showReceivingCardDialog(
      context,
      receivingCard: receivingCardRQ,
      onConfirm: (printer) async {
        final rcConverter = await cubit.convertStockToReceiving(
          totalQty: qty,
          currentQty: qtyTotal == 0 ? qty : qtyTotal,
          boxTotal: boxTotalInput,
          barcodeStock: barcodeStock,
        );

        Duration.zero.delay(() async {
          await cubit.runConverterPrint(
            receivingCardConverted: rcConverter,
            printer: printer,
            boxTotal: boxTotalInput,
          );

          Duration.zero.delay(() async {
            getIt<AppAlertDialog>().show(context,
                type: AppAlertType.confirm,
                message: 'In thành công!\n Bạn có muốn lưu kho luôn không?',
                onConfirm: () async {
              stockCardController.clear();
              stockCardFocusNode.requestFocus();
              qtyController.text = '';
              await context.pushRoute(
                StorageRCCardRoute(
                  rcBarcode: rcConverter.barcode,
                ),
              );
              cubit.clearData();
            }, onCancel: () {
              stockCardController.clear();
              stockCardFocusNode.requestFocus();
              qtyController.text = '';
              cubit.clearData();
            });
          });
        });
      },
      printerDevices: cubit.printerDevices ?? [],
      previousPrinterDevice: cubit.savePrinterDevice,
    );
  }
}
