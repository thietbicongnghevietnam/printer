import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/inventory/plant_sloc_category.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/enums/receving_card_type.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/dialogs/receiving_card_dialog.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_rich_text_note.dart';

import 'split_receiving_card_controller.dart';
import 'split_receiving_card_state.dart';

enum SplitRcAction {
  // reprint,
  listRCClone;

  @override
  String toString() {
    return switch (this) {
      // reprint => 'In lại',
      listRCClone => 'Danh sách RC đã tách'
    };
  }
}

@RoutePage()
class SplitReceivingPage
    extends BasePage<SplitReceivingCardController, SplitReceivingCardState> {
  const SplitReceivingPage({super.key});

  @override
  BasePageState createState() => _SplitReceivingPageState();
}

class _SplitReceivingPageState extends BasePageState<
    SplitReceivingCardController, SplitReceivingCardState> {
  late TextEditingController receivingCardController;
  late TextEditingController materialController;
  late TextEditingController quantityController;
  late TextEditingController boxCardController;
  late TextEditingController editQtyBoxController;
  late TextEditingController slocController;

  late FocusNode receivingCardFocusNode;
  late FocusNode materialFocusNode;
  late FocusNode quantityFocusNode;
  late FocusNode boxCardFocusNode;
  late FocusNode slocFocusNode;
  late PdaDevice pdaDevice;

  @override
  void initState() {
    super.initState();

    receivingCardController = TextEditingController();
    materialController = TextEditingController();
    quantityController = TextEditingController();
    boxCardController = TextEditingController();
    editQtyBoxController = TextEditingController();
    slocController = TextEditingController();

    receivingCardFocusNode = FocusNode()..requestFocus();
    materialFocusNode = FocusNode();
    quantityFocusNode = FocusNode();
    boxCardFocusNode = FocusNode();
    slocFocusNode = FocusNode();

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) async {
      if (receivingCardFocusNode.hasFocus) {
        context.read<SplitReceivingCardController>().scanReceivingCard(data);
      }
      if (boxCardFocusNode.hasFocus) {
        context.read<SplitReceivingCardController>().scanBoxCard(data);
      }
      if (slocFocusNode.hasFocus) {
        context.read<SplitReceivingCardController>().scanSloc(data);
      }
      if (materialFocusNode.hasFocus) {
        context.read<SplitReceivingCardController>().updateMaterial(data);
      }
    });
  }

  @override
  void dispose() {
    receivingCardController.dispose();
    materialController.dispose();
    quantityController.dispose();
    boxCardController.dispose();
    editQtyBoxController.dispose();
    receivingCardFocusNode.dispose();
    materialFocusNode.dispose();
    boxCardFocusNode.dispose();
    quantityFocusNode.dispose();

    pdaDevice.dispose();
    super.dispose();
  }

  void handleClick(SplitRcAction value) {
    final cubit = context.read<SplitReceivingCardController>();
    switch (value) {
      case SplitRcAction.listRCClone:
        context.pushRoute(
          ReceivingCardListRoute(parentId: cubit.state.currentReCard?.id),
        );
    }
  }

  @override
  Widget builder(context, cubit, state) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SplitReceivingCardController, SplitReceivingCardState>(
          listenWhen: (prev, current) {
            return prev.currentReCard != current.currentReCard;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();
            receivingCardController.text = state.currentReCard?.barcode ?? '';
            materialController.text = state.currentReCard?.material ?? '';
            quantityController.text =
                state.currentReCard?.currentQuantity.toString() ?? '';
          },
        ),
        BlocListener<SplitReceivingCardController, SplitReceivingCardState>(
          listenWhen: (prev, current) {
            return prev.slocUpdate != current.slocUpdate;
          },
          listener: (context, state) {
            slocController.text = state.slocUpdate ?? '';
          },
        ),
      ],
      child: BlocBuilder<SplitReceivingCardController, SplitReceivingCardState>(
        buildWhen: (prev, current) {
          return prev.currentReCard != current.currentReCard;
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(LocaleKeys.storing_split_receiving_card).tr(),
              actions: [
                Visibility(
                  visible: state.currentReCard != null,
                  child: PopupMenuButton(
                    onSelected: handleClick,
                    itemBuilder: (context) {
                      return SplitRcAction.values.map((choice) {
                        return PopupMenuItem(
                          value: choice,
                          child: Text(choice.toString()),
                        );
                      }).toList();
                    },
                  ),
                ),
              ],
            ),
            body: _buildBody(cubit),
            bottomNavigationBar: BlocBuilder<SplitReceivingCardController,
                SplitReceivingCardState>(
              buildWhen: (prev, current) {
                return prev.currentReCard != current.currentReCard ||
                    prev.currentSloc != current.currentSloc ||
                    prev.currentCate != current.currentCate ||
                    prev.currentPlant != current.currentPlant ||
                    prev.qcSamplingReCheck != current.qcSamplingReCheck ||
                    prev.materialUpdate != current.materialUpdate ||
                    prev.listBoxScanned != current.listBoxScanned;
              },
              builder: (context, state) {
                return ElevatedButton(
                  child:
                      const Text(LocaleKeys.storing_split_receiving_card).tr(),
                  onPressed: () async {
                    await handleSplitRc(cubit, state);
                  },
                );
              },
            ).paddingSymmetric(horizontal: 16, vertical: 8),
          );
        },
      ),
    );
  }

  Widget _buildBody(SplitReceivingCardController cubit) {
    return BlocBuilder<SplitReceivingCardController, SplitReceivingCardState>(
      buildWhen: (prev, current) {
        return prev.currentReCard != current.currentReCard ||
            prev.listBoxScanned != current.listBoxScanned ||
            prev.isSamplingCheck != current.isSamplingCheck;
      },
      builder: (context, state) {
        final rc = state.currentReCard;
        final listBoxNotSame = rc?.items.map((e) => e.barcode).toSet();
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocSelector<SplitReceivingCardController,
                  SplitReceivingCardState, List<PlantCategory>>(
                selector: (state) => state.listPlant,
                builder: (context, listPlant) {
                  if (listPlant.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return _buildPlantCate(cubit);
                },
              ).paddingSymmetric(horizontal: 16, vertical: 8),
              if (rc != null &&
                  rc.items.isNotEmpty &&
                  (listBoxNotSame?.length == rc.items.length)) ...[
                Center(
                  child: const Text(
                    'Receiving Card có box, hãy quét Box Card!',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ).paddingSymmetric(vertical: 8),
                ),
              ],
              _buildReCardTextField(cubit, state)
                  .paddingSymmetric(horizontal: 16, vertical: 8),
              if (state.currentReCard != null) ...[
                _buildMaterialTextField(cubit, state)
                    .paddingSymmetric(horizontal: 16, vertical: 8),
                _buildQuantityTextField(cubit, state)
                    .paddingSymmetric(horizontal: 16, vertical: 8),
                if (rc != null &&
                    rc.items.isNotEmpty &&
                    (listBoxNotSame?.length == rc.items.length)) ...[
                  _buildBoxCardTextField(cubit, state)
                      .paddingSymmetric(horizontal: 16, vertical: 8),
                ],
              ],
              if (state.listBoxScanned.isNotEmpty) ...[

                const Text(
                  'Danh sách Boxcard đã quét',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ).paddingSymmetric(horizontal: 16, vertical: 8),

                //Tuấn Anh sửa
                if ((state.materialUpdate != state.currentReCard?.material && state.materialUpdate.isNotEmpty) ||
                    (state.currentSloc != null && state.currentReCard?.sloc != null && state.currentSloc != state.currentReCard?.sloc) || state.qcSamplingReCheck)
                  _buildBoxListTA(cubit, state.listBoxScanned)
                else
                  _buildBoxList(cubit, state.listBoxScanned),

                //_buildBoxList(cubit, state.listBoxScanned),




              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlantCate(SplitReceivingCardController cubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              'Cate',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            _buildCateSelection(cubit),
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

  Widget _buildPlantSelection(SplitReceivingCardController cubit) {
    return BlocBuilder<SplitReceivingCardController, SplitReceivingCardState>(
      buildWhen: (prev, current) {
        return prev.listPlant != current.listPlant ||
            prev.currentPlant != current.currentPlant;
      },
      builder: (context, state) {
        final plant = state.listPlant;
        if (plant.isEmpty) {
          return const SizedBox();
        }
        return DropdownButton<PlantCategory>(
          value: state.currentPlant,
          icon: const Icon(Icons.keyboard_arrow_down),
          style: const TextStyle(color: Colors.blue),
          onChanged: (value) {
            cubit.onSelectPlant(value!);
          },
          items: plant.map<DropdownMenuItem<PlantCategory>>((value) {
            return DropdownMenuItem<PlantCategory>(
              value: value,
              child: Text(value.plant ?? ''),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildCateSelection(SplitReceivingCardController cubit) {
    return BlocBuilder<SplitReceivingCardController, SplitReceivingCardState>(
      buildWhen: (prev, current) {
        return prev.listCate != current.listCate ||
            prev.currentCate != current.currentCate;
      },
      builder: (context, state) {
        final listCate = state.listCate;
        if (listCate.isEmpty) {
          return const SizedBox();
        }
        return DropdownButton<CategorySloc>(
          value: state.currentCate,
          icon: const Icon(Icons.keyboard_arrow_down),
          style: const TextStyle(color: Colors.blue),
          onChanged: (value) {
            cubit.onSelectCate(value!);
          },
          items: listCate.map<DropdownMenuItem<CategorySloc>>((value) {
            return DropdownMenuItem<CategorySloc>(
              value: value,
              child: Text(value.category ?? ''),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildSlocSelection(SplitReceivingCardController cubit) {
    return BlocBuilder<SplitReceivingCardController, SplitReceivingCardState>(
      buildWhen: (prev, current) {
        return prev.listSloc != current.listSloc ||
            prev.currentSloc != current.currentSloc;
      },
      builder: (context, state) {
        final listSloc = state.listSloc;
        if (listSloc.isEmpty) {
          return const SizedBox();
        }
        return DropdownButton<String>(
          value: state.currentSloc,
          icon: const Icon(Icons.keyboard_arrow_down),
          style: const TextStyle(color: Colors.blue),
          onChanged: (value) {
            cubit.onSelectSloc(value!);
          },
          items: listSloc.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildReCardTextField(
    SplitReceivingCardController cubit,
    SplitReceivingCardState state,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: const Text(LocaleKeys.temporary_area_re_card).tr(),
        ),
        Expanded(
          child: AppFormField(
            readOnly: true,
            showCursor: true,
            controller: receivingCardController,
            focusNode: receivingCardFocusNode,
            onChanged: cubit.scanReceivingCard,
          ),
        ),
        const SizedBox(width: 5),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocSelector<SplitReceivingCardController, SplitReceivingCardState,
                bool?>(
              selector: (state) => state.isSamplingCheck,
              builder: (context, isSampling) {
                return Checkbox(
                    value: isSampling,
                    onChanged: (value) {
                      cubit.onChangeSampling(value!);
                    });
              },
            ),
            const Text(
              'Sampling',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMaterialTextField(
    SplitReceivingCardController cubit,
    SplitReceivingCardState state,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: const Text(LocaleKeys.storing_material).tr(),
        ),
        Flexible(
          flex: 2,
          child: AppFormField(
            showCursor: true,
            controller: materialController,
            focusNode: materialFocusNode,
            onChanged: (value) {
              cubit.updateMaterial(value);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityTextField(
    SplitReceivingCardController cubit,
    SplitReceivingCardState state,
  ) {
    final rc = state.currentReCard;
    final listBoxNotSame = rc?.items.map((e) => e.barcode).toSet();
    final haveToScanBox = listBoxNotSame?.length == rc?.items.length &&
        rc?.items != null &&
        rc!.items.isNotEmpty;

    return Row(
      children: [
        SizedBox(
          width: 60,
          child: const Text(LocaleKeys.storing_current_quantity).tr(),
        ),
        Flexible(
          flex: 2,
          child: AppFormField(
            showCursor: true,
            readOnly: haveToScanBox,
            enabled: !haveToScanBox,
            controller: quantityController,
            keyboardType: TextInputType.number,
            focusNode: quantityFocusNode,
            onChanged: (value) {
              cubit.updateQuantity(value);
            },
          ),
        ),
        const SizedBox(width: 5),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocSelector<SplitReceivingCardController, SplitReceivingCardState,
                bool?>(
              selector: (state) => state.qcSamplingReCheck,
              builder: (context, qcSamplingReCheck) {
                return Checkbox(
                    value: qcSamplingReCheck,
                    onChanged: (value) {
                      cubit.onChangeReCheck(value!);
                    });
              },
            ),
            const Text(
              'Recheck',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBoxCardTextField(
    SplitReceivingCardController cubit,
    SplitReceivingCardState state,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: const Text('Thêm Boxcard').tr(),
        ),
        Flexible(
          flex: 2,
          child: AppFormField(
            showCursor: true,
            readOnly: true,
            controller: boxCardController,
            focusNode: boxCardFocusNode,
            onChanged: (value) {
              cubit.updateQuantity(value);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBoxList(
    SplitReceivingCardController cubit,
    List<ReceivingCardItem> boxList,
  ) {
    if (boxList.isEmpty) {
      return const SizedBox.shrink();
    }
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: boxList.length,
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
                      boxList[i].barcode,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      softWrap: true,
                    ),
                    const SizedBox(height: 5),
                    AppRichTextNote(
                      label: 'Qty',
                      value: boxList[i].currentQuantity.toString(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Tuấn Anh sửa
                  // InkWell(
                  //   onTap: () async {
                  //     _showModelEditBoxCard(
                  //       boxList[i].currentQuantity,
                  //       () {
                  //         cubit.updateQtyBoxInRc(
                  //           updateQty: editQtyBoxController.text.toInt(),
                  //           index: i,
                  //           rcItem: boxList[i],
                  //         );
                  //         editQtyBoxController = TextEditingController();
                  //         Navigator.pop(context);
                  //       },
                  //       cubit,
                  //     );
                  //   },
                  //   child: const Icon(
                  //     Icons.edit,
                  //     color: Colors.black54,
                  //     size: 20,
                  //   ).paddingSymmetric(vertical: 5, horizontal: 6),
                  // ),
                  // kết thúc Tuấn Anh sửa
                  InkWell(
                    onTap: () async {
                      cubit.removeBoxCard(index: i);
                      editQtyBoxController = TextEditingController();
                    },
                    child: const Icon(
                      Icons.delete_forever,
                      color: Colors.redAccent,
                      size: 20,
                    ).paddingSymmetric(vertical: 5, horizontal: 6),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Tuấn Anh thêm 309
  Widget _buildBoxListTA(
      SplitReceivingCardController cubit,
      List<ReceivingCardItem> boxList,
      ) {
    if (boxList.isEmpty) {
      return const SizedBox.shrink();
    }
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: boxList.length,
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
                      boxList[i].barcode,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      softWrap: true,
                    ),
                    const SizedBox(height: 5),
                    AppRichTextNote(
                      label: 'Qty',
                      value: boxList[i].currentQuantity.toString(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Tuấn Anh sửa
                  InkWell(
                    onTap: () async {
                      _showModelEditBoxCard(
                        boxList[i].currentQuantity,
                            () {
                          cubit.updateQtyBoxInRc(
                            updateQty: editQtyBoxController.text.toInt(),
                            index: i,
                            rcItem: boxList[i],
                          );
                          editQtyBoxController = TextEditingController();
                          Navigator.pop(context);
                        },
                        cubit,
                      );
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Colors.black54,
                      size: 20,
                    ).paddingSymmetric(vertical: 5, horizontal: 6),
                  ),
                  // kết thúc Tuấn Anh sửa
                  InkWell(
                    onTap: () async {
                      cubit.removeBoxCard(index: i);
                      editQtyBoxController = TextEditingController();
                    },
                    child: const Icon(
                      Icons.delete_forever,
                      color: Colors.redAccent,
                      size: 20,
                    ).paddingSymmetric(vertical: 5, horizontal: 6),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }


  void _showModelEditBoxCard(
    int qty,
    Function onTap,
    SplitReceivingCardController cubit,
  ) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (context) {
        return BlocProvider.value(
          value: cubit,
          child: Padding(
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
                      controller: editQtyBoxController,
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
          ),
        );
      },
    );
  }

  Future<void> handleSplitRc(
    SplitReceivingCardController cubit,
    SplitReceivingCardState state,
  ) async {
    if (state.currentReCard == null) {
      await Duration.zero.delay(() async {
        getIt<AppAlertDialog>().show(
          context,
          type: AppAlertType.error,
          message: 'Thông tin chưa đủ, vui lòng nhập đủ thông tin',
          onConfirm: () {},
        );
      });
    } else {
      final hasBox = state.currentReCard?.items.isNotEmpty ?? false;
      final listBoxNotSame =
          state.currentReCard?.items.map((e) => e.barcode).toSet();
      final hasBoxScanned = state.listBoxScanned.isNotEmpty;

      if (hasBox &&
          (listBoxNotSame?.length == state.currentReCard?.items.length) &&
          !hasBoxScanned) {
        await Duration.zero.delay(() async {
          getIt<AppAlertDialog>().show(
            context,
            type: AppAlertType.error,
            message: 'Receiving Card có box, hãy thêm box',
            onConfirm: () {},
          );
        });

      } else {
        ReceivingCard resRc = await cubit.splitReceivingCard(
          qtyUpdate: quantityController.text,
          materialUpdate: materialController.text,
          slocUpdate: slocController.text,
          isPreview: true,
        );
        final rcCheck = state.qcSamplingReCheck;
        final materialUpdate = state.materialUpdate;
        final selectedSloc = state.currentSloc;
        final materialInOldRc = state.currentReCard?.material;
        final rcSloc = state.currentReCard?.sloc;
        // Tuấn Anh check 309
        //final is309Case = (materialUpdate.isNotEmpty && materialUpdate != materialInOldRc) || (selectedSloc != null && rcSloc != null && selectedSloc != rcSloc);

        final is309Case = (materialUpdate.isNotEmpty && materialUpdate != materialInOldRc) || (selectedSloc != null && rcSloc != null && selectedSloc != rcSloc);


       resRc = resRc.copyWith(
            rcCurrentType: rcCheck
                ? ReceivingCardPrinterType.reCheckCard
                : is309Case
                    ? ReceivingCardPrinterType.three09Card
                    : ReceivingCardPrinterType.receivingCard);
        await Duration.zero.delay(() async {
          await showReceivingCardDialog(
            context,
            receivingCard: resRc,
            onConfirm: (printer) async {
              final resRcBack = await cubit.splitReceivingCard(
                qtyUpdate: quantityController.text,
                materialUpdate: materialController.text,
                slocUpdate: slocController.text,
              );

              Duration.zero.delay(() async {
                await cubit.runConverterPrint(
                  receivingCardConverted: resRcBack,
                  printer: printer,
                  context: context,
                );

                Duration.zero.delay(() async {
                  getIt<AppAlertDialog>().show(
                    context,
                    type: AppAlertType.success,
                    message: 'In thành công!',
                    onConfirm: () async {
                      receivingCardController.clear();
                      quantityController.clear();
                      materialController.clear();
                      boxCardController.clear();
                      receivingCardFocusNode.requestFocus();
                      cubit.clearData();
                    },
                  );
                });
              });
            },
            printerDevices: cubit.printerDevices ?? [],
            previousPrinterDevice: cubit.savePrinterDevice,
          );
        });
      }
    }
  }
}
