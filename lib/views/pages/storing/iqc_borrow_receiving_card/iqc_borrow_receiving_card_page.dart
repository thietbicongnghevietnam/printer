import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/services/models/response/plant_type_freqquency_response_model.dart';
import 'package:smart_warehouse/services/models/response/sloc_info_from_plant_response_model.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/pages/storing/storing_widget/storage_receiving_item.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_radio.dart';
import 'package:smart_warehouse/views/widgets/app_rich_text_note.dart';
import 'package:smart_warehouse/views/widgets/receiving_card_item_widget.dart';

import 'iqc_borrow_receiving_card_controller.dart';
import 'iqc_borrow_receiving_card_state.dart';

@RoutePage()
class IQCBorrowReceivingCardPage extends BasePage<
    IQCBorrowReceivingCardController,
    IQCBorrowReceivingCardState> {
  const IQCBorrowReceivingCardPage({super.key});

  @override
  BasePageState createState() => _IQCBorrowReceivingCardPageState();
}

class _IQCBorrowReceivingCardPageState extends BasePageState<
    IQCBorrowReceivingCardController,
    IQCBorrowReceivingCardState> {
  _IQCBorrowReceivingCardPageState();

  late TextEditingController receivingCardController;
  late TextEditingController qtyController;
  late TextEditingController boxCardController;

  late FocusNode receivingCardFocusNode;
  late FocusNode qtyFocusNode;
  late FocusNode boxCardFocusNode;

  late PdaDevice pdaDevice;

  @override
  void initState() {
    receivingCardController = TextEditingController();
    qtyController = TextEditingController();
    boxCardController = TextEditingController();

    receivingCardFocusNode = FocusNode()
      ..requestFocus();
    qtyFocusNode = FocusNode();
    boxCardFocusNode = FocusNode();

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) async {
      if (receivingCardFocusNode.hasFocus) {
        context
            .read<IQCBorrowReceivingCardController>()
            .scanReceivingCard(data);
      }
      if (boxCardFocusNode.hasFocus) {
        context.read<IQCBorrowReceivingCardController>().scanBoxCard(data);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    receivingCardController.dispose();

    pdaDevice.dispose();
    super.dispose();
  }

  @override
  Widget builder(context, cubit, state) {
    return MultiBlocListener(
      listeners: [
        BlocListener<IQCBorrowReceivingCardController,
            IQCBorrowReceivingCardState>(
          listenWhen: (prev, current) {
            return prev.currentReCard != current.currentReCard;
          },
          listener: (context, state) async {
            ScaffoldMessenger.of(context).clearSnackBars();
            if (state.currentReCard?.items != null &&
                state.currentReCard!.items.isNotEmpty) {
              boxCardFocusNode.requestFocus();
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.storing_iqc_borrow_receiving_card).tr(),
        ),
        body: _buildBody(cubit),
        bottomNavigationBar: BlocBuilder<IQCBorrowReceivingCardController,
            IQCBorrowReceivingCardState>(
          buildWhen: (prev, current) {
            return prev.currentReCard != current.currentReCard ||
                prev.listBoxInScanned != current.listBoxInScanned ||
                prev.listBoxQtyReturn != current.listBoxQtyReturn ||
                prev.icqBorrowType != current.icqBorrowType;
          },
          builder: (context, state) {
            return ElevatedButton(
              child: Text(state.icqBorrowType == IQCBorrowType.borrowRc
                  ? LocaleKeys.storing_borrow_receiving_card
                  : LocaleKeys.storing_return_receiving_card)
                  .tr(),
              onPressed: () async {
                await onHandleCreateIQCBorrow(cubit, state);
              },
            );
          },
        ).paddingSymmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildBody(IQCBorrowReceivingCardController cubit) {
    return SingleChildScrollView(
      child: BlocBuilder<IQCBorrowReceivingCardController,
          IQCBorrowReceivingCardState>(
        buildWhen: (prev, current) {
          return prev.currentReCard != current.currentReCard ||
              prev.icqBorrowType != current.icqBorrowType ||
              prev.qtyInput != current.qtyInput ||
              prev.listBoxQtyReturn != current.listBoxQtyReturn ||
              prev.listBoxInScanned != current.listBoxInScanned;
        },
        builder: (context, state) {
          final rc = state.currentReCard;
          final listBoxNotSame = rc?.items.map((e) => e.barcode).toSet();
          final showBox = listBoxNotSame?.length == rc?.items.length;
          final iqcBorrowType = state.icqBorrowType;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRadioButtonChange(cubit),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: AppFormField(
                      showCursor: true,
                      readOnly: true,
                      controller: receivingCardController,
                      focusNode: receivingCardFocusNode,
                      onChanged: cubit.scanReceivingCard,
                      decoration: const InputDecoration(
                        hintText: 'RC barcode',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff868D95),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  // Column(
                ],
              ),
              const SizedBox(height: 15),
              if (rc != null) ...[
                _buildRC(rc),
                const SizedBox(height: 15),
                if (iqcBorrowType == IQCBorrowType.returnRc) ...[
                  _buildPlantSloc(cubit),
                  const SizedBox(height: 15),
                ],
                if (iqcBorrowType == IQCBorrowType.borrowRc) ...[
                  if (showBox && rc.items.isNotEmpty) ...[
                    AppFormField(
                      showCursor: true,
                      readOnly: true,
                      controller: boxCardController,
                      focusNode: boxCardFocusNode,
                      onChanged: cubit.scanBoxCard,
                      decoration: const InputDecoration(
                        hintText: 'Box barcode',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff868D95),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ] else
                    ...[
                      AppFormField(
                        showCursor: true,
                        controller: qtyController,
                        focusNode: qtyFocusNode,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: LocaleKeys.storing_qty_borrow.tr(),
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xff868D95),
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                ] else
                  ...[
                    if (state.listBoxQtyReturn.isEmpty) ...[
                      AppFormField(
                        showCursor: true,
                        controller: qtyController,
                        focusNode: qtyFocusNode,
                        keyboardType: TextInputType.number,
                        onChanged: cubit.onInputQty,
                        decoration: InputDecoration(
                          hintText: LocaleKeys.storing_qty_return.tr(),
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xff868D95),
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                    if (state.qtyInput.isEmpty) ...[
                      AppFormField(
                        showCursor: true,
                        readOnly: true,
                        controller: boxCardController,
                        focusNode: boxCardFocusNode,
                        onChanged: cubit.scanBoxCard,
                        decoration: const InputDecoration(
                          hintText: 'Box barcode',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xff868D95),
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ],
              ],
              _buildBoxList(cubit),
            ],
          );
        },
      ).paddingAll(16),
    );
  }

  Widget _buildRadioButtonChange(IQCBorrowReceivingCardController cubit) {
    return BlocSelector<IQCBorrowReceivingCardController,
        IQCBorrowReceivingCardState,
        IQCBorrowType>(
      selector: (state) => state.icqBorrowType,
      builder: (context, outType) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppRadio(
              title: 'Mượn',
              value: IQCBorrowType.borrowRc,
              groupValue: outType,
              onChanged: (value) {
                cubit.onChangeBorrowType(value!);
              },
            ),
            AppRadio(
              title: 'Trả',
              value: IQCBorrowType.returnRc,
              groupValue: outType,
              onChanged: (value) {
                cubit.onChangeBorrowType(value!);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildRC(ReceivingCard rc) {
    return StorageReceivingItem(
      reCardData: rc,
      hasRemove: false,
      isMinimalData: true,
    );
  }

  Widget _buildBoxList(IQCBorrowReceivingCardController cubit,) {
    return BlocBuilder<IQCBorrowReceivingCardController,
        IQCBorrowReceivingCardState>(
      buildWhen: (prev, current) {
        return prev.listBoxInScanned != current.listBoxInScanned ||
            prev.listBoxQtyReturn != current.listBoxQtyReturn;
      },
      builder: (context, state) {
        final borrowType = state.icqBorrowType;
        final boxListOnRc = state.listBoxInScanned;
        final boxListReturn = state.listBoxQtyReturn;
        if (boxListOnRc.isEmpty && borrowType == IQCBorrowType.borrowRc) {
          return const SizedBox.shrink();
        }
        if (boxListReturn.isEmpty && borrowType == IQCBorrowType.returnRc) {
          return const SizedBox.shrink();
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: borrowType == IQCBorrowType.borrowRc
              ? boxListOnRc.length
              : boxListReturn.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          itemBuilder: (c, i) {
            return Container(
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Barcode:',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.red,
                            // ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          borrowType == IQCBorrowType.borrowRc
                              ? boxListOnRc[i].barcode
                              : (boxListReturn[i].barcode ?? ''),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 7,
                        ),
                        const SizedBox(height: 5),
                        AppRichTextNote(
                          label: 'Qty',
                          value: borrowType == IQCBorrowType.borrowRc
                              ? boxListOnRc[i].currentQuantity.toString()
                              : boxListReturn[i].currentQuantity.toString(),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      cubit.removeBoxCard(index: i);
                    },
                    child: const Icon(
                      Icons.delete_forever,
                      color: Colors.redAccent,
                      size: 20,
                    ).paddingSymmetric(vertical: 5, horizontal: 6),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPlantSloc(IQCBorrowReceivingCardController cubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Text(
              'Plant',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            _buildPlantSelection(cubit),
          ],
        ),
        Column(
          children: [
            const Text(
              'Sloc',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            _buildSlocSelection(cubit),
          ],
        ),
      ],
    );
  }

  Widget _buildPlantSelection(IQCBorrowReceivingCardController cubit) {
    return BlocBuilder<IQCBorrowReceivingCardController,
        IQCBorrowReceivingCardState>(
      buildWhen: (prev, current) {
        return prev.listPlant != current.listPlant ||
            prev.currentPlant != current.currentPlant;
      },
      builder: (context, state) {
        final plant = state.listPlant;
        final rc = state.currentReCard;

        if (plant.isEmpty) {
          return Text(rc?.plant ?? '');
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

  Widget _buildSlocSelection(IQCBorrowReceivingCardController cubit) {
    return BlocBuilder<IQCBorrowReceivingCardController,
        IQCBorrowReceivingCardState>(
      buildWhen: (prev, current) {
        return prev.currentListSloc != current.currentListSloc ||
            prev.currentSloc != current.currentSloc;
      },
      builder: (context, state) {
        final listSloc = state.currentListSloc;
        final rc = state.currentReCard;

        if (listSloc.isEmpty) {
          return Text(rc?.sloc ?? '');
        }
        return DropdownButton<SlocInfoFromPlantResponseModel>(
          value: state.currentSloc,
          icon: const Icon(Icons.keyboard_arrow_down),
          style: const TextStyle(color: Colors.blue),
          onChanged: (value) {
            cubit.onSelectSloc(value!);
          },
          items: listSloc
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

  Future<void> onHandleCreateIQCBorrow(IQCBorrowReceivingCardController cubit,
      IQCBorrowReceivingCardState state,) async {
    final rc = state.currentReCard;
    final listBoxNotSame = rc?.items.map((e) => e.barcode).toSet();
    final showBox = listBoxNotSame?.length == rc?.items.length;
    final listBoxInScanned = state.listBoxInScanned;
    final listBoxQtyReturn = state.listBoxQtyReturn;
    final borrowType = state.icqBorrowType;
    if (rc == null) {
      await Duration.zero.delay(() async {
        getIt<AppAlertDialog>().show(
          context,
          type: AppAlertType.error,
          message: 'Thông tin chưa đủ, vui lòng nhập đủ thông tin',
          onConfirm: () {},
        );
      });
    } else {
      if (borrowType == IQCBorrowType.borrowRc &&
          showBox &&
          listBoxInScanned.isEmpty &&
          rc.items.isNotEmpty) {
        await Duration.zero.delay(() async {
          getIt<AppAlertDialog>().show(
            context,
            type: AppAlertType.error,
            message: 'Vui lòng quét boxcard!',
            onConfirm: () {},
          );
        });
      } else if (borrowType == IQCBorrowType.borrowRc && !showBox &&
          qtyController.text.isEmpty) {
        await Duration.zero.delay(() async {
          getIt<AppAlertDialog>().show(
            context,
            type: AppAlertType.error,
            message: 'Vui lòng nhập qty IQC mượn!',
            onConfirm: () {},
          );
        });
      } else if (borrowType == IQCBorrowType.returnRc &&
          (qtyController.text.isEmpty && listBoxQtyReturn.isEmpty)) {
        await Duration.zero.delay(() async {
          getIt<AppAlertDialog>().show(
            context,
            type: AppAlertType.error,
            message: 'Thông tin chưa đủ, vui lòng nhập đủ thông tin',
            onConfirm: () {},
          );
        });
      } else {
        await cubit.createQCBorrowRC(qtyController.text.toInt());
        Duration.zero.delay(() async {
          getIt<AppAlertDialog>().show(
            context,
            type: AppAlertType.success,
            message: 'Tạo thành công yêu cầu!',
            onConfirm: () async {
              receivingCardController.clear();
              boxCardController.clear();
              qtyController.clear();
              receivingCardFocusNode.requestFocus();
              cubit.clearData();
            },
          );
        });
      }
    }
  }
}
