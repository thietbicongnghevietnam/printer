import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/inventory/balance_detail.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/enums/balance_scan_type.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/int_extensions.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/router/auth_guard.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/pages/storing/storing_widget/storage_receiving_item.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_radio.dart';
import 'package:smart_warehouse/views/widgets/app_rich_text_note.dart';

import 'balance_rc_controller.dart';
import 'balance_rc_state.dart';

@RoutePage()
class BalanceRcPage extends BasePage<BalanceRcController, BalanceRcState> {
  const BalanceRcPage({
    super.key,
    this.rcBarcode,
  });

  final String? rcBarcode;

  @override
  BasePageState createState() => _BalanceRcPageState();
}

class _BalanceRcPageState
    extends BasePageState<BalanceRcController, BalanceRcState> {
  late TextEditingController editQtyRcController;
  late TextEditingController rcController;
  late TextEditingController editQtyBoxController;
  late TextEditingController boxCardController;

  late FocusNode currentQtyFocusNode;
  late FocusNode rcFocusNode;
  late FocusNode editQtyFocusNode;
  late FocusNode boxCardFocusNode;

  late PdaDevice pdaDevice;

  late PagingController<int, BalanceDetail> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    editQtyRcController = TextEditingController();
    rcController = TextEditingController();
    editQtyBoxController = TextEditingController();
    boxCardController = TextEditingController();

    rcFocusNode = FocusNode()..requestFocus();
    currentQtyFocusNode = FocusNode();
    editQtyFocusNode = FocusNode();
    boxCardFocusNode = FocusNode();

    final rc = (widget as BalanceRcPage).rcBarcode;
    if (rc != null && rc.isNotEmpty) {
      1.seconds.delay(() {
        context.read<BalanceRcController>().onInputRC(rc);
      });
    }

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) {
      if (rcFocusNode.hasFocus) {
        context.read<BalanceRcController>().onInputRC(data);
      } else if (boxCardFocusNode.hasFocus) {
        context.read<BalanceRcController>().scanBoxCardWillBalance(data);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    editQtyRcController.dispose();
    currentQtyFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget builder(context, cubit, state) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BalanceRcController, BalanceRcState>(
          listenWhen: (preState, state) =>
              preState.receivingCard != state.receivingCard,
          listener: (context, state) {
            rcController.text = state.receivingCard?.material ?? '';
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Balance ReceivingCard Page',
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: _buildBody(cubit),
      ),
    );
  }

  Widget _buildBody(BalanceRcController cubit) {
    return BlocBuilder<BalanceRcController, BalanceRcState>(
      buildWhen: (prev, current) {
        return prev.receivingCard != current.receivingCard ||
            prev.boxCard != current.boxCard ||
            prev.balanceScanType != current.balanceScanType ||
            prev.updateQty != current.updateQty ||
            prev.boxCardWillBalance != current.boxCardWillBalance ||
            prev.listReceivingCardScanned != current.listReceivingCardScanned ||
            prev.boxTotal != current.boxTotal ||
            prev.boxListShowTotalChange != current.boxListShowTotalChange ||
            prev.currentQty != current.currentQty;
      },
      builder: (context, state) {
        final hasBox =
            state.listReceivingCardScanned.any((e) => e.items.isNotEmpty);
        final hasEditRc =
            state.listReceivingCardScanned.any((e) => e.balanceQty != 0);
        final totalQtyBefore = state.listReceivingCardScanned
            .fold(0, (sum, e) => sum + e.currentQuantity);
        final totalBoxQtyBefore = state.boxCardWillBalance
            .fold(0, (sum, e) => sum + e.currentQuantity);
        final totalChangeWithBox = state.boxListShowTotalChange
            .fold(0, (sum, e) => sum + e.currentQuantity);
        final listRcScanned = state.listReceivingCardScanned;
        final boxWillBalance = state.boxCardWillBalance;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildRadioButtonChange(cubit).paddingSymmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    _buildTextFieldBarcode(cubit),
                    if (state.balanceScanType == BalanceScanType.scanRc) ...[
                      if (listRcScanned.isNotEmpty) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tổng số ReceivingCard: ${listRcScanned.length}',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ).paddingSymmetric(vertical: 5),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Total qty: $totalQtyBefore',
                              style: const TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ).paddingSymmetric(vertical: 5),
                          ],
                        ),
                      ],
                      _buildReceivingCardList(cubit, state),
                      if (state.boxListShowTotalChange.isNotEmpty) ...[
                        AppRichTextNote(
                                label: 'Số lượng cũ: ${state.currentQty}',
                                value: 'Số lượng sửa đổi $totalChangeWithBox')
                            .paddingSymmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ],
                      if (listRcScanned.isNotEmpty && hasBox && !hasEditRc) ...[
                        if (state.boxTotal != null && state.boxTotal != 0) ...[
                          Text('Tổng số Box: ${state.boxTotal}')
                              .paddingSymmetric(vertical: 5),
                        ],
                        AppFormField(
                          showCursor: true,
                          readOnly: true,
                          controller: boxCardController,
                          focusNode: boxCardFocusNode,
                          onChanged: cubit.scanBoxCardWillBalance,
                          decoration: const InputDecoration(
                            hintText: 'Quét Barcode BoxCard',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                              fontSize: 15,
                            ),
                          ),
                        ).paddingSymmetric(horizontal: 16),
                        if (boxWillBalance.isNotEmpty) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Boxcard Balance: ${state.boxCardWillBalance.length}',
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ).paddingSymmetric(vertical: 5),
                              const SizedBox(width: 10),
                              Text(
                                'Box Scanned Total: $totalBoxQtyBefore',
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ).paddingSymmetric(vertical: 5),
                            ],
                          ),
                          _buildBoxList(
                            cubit,
                            state.boxCardWillBalance,
                          ),
                        ],
                      ],
                    ] else ...[
                      _buildBoxList(
                        cubit,
                        state.boxCardWillBalance,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (state.listReceivingCardScanned.isNotEmpty ||
                state.boxCardWillBalance.isNotEmpty) ...[
              ElevatedButton(
                child: const Text('Cập nhật lại số lượng').tr(),
                onPressed: () async {
                  await Duration.zero.delay(() async {
                    getIt<AppAlertDialog>().show(
                      context,
                      type: AppAlertType.warning,
                      message: 'Xác nhận tiến hành Balance!',
                      onConfirm: () async {
                        await cubit.createBalanceRcQty();

                        await Duration.zero.delay(() async {
                          getIt<AppAlertDialog>().show(
                            context,
                            type: AppAlertType.confirm,
                            message:
                                'Đã gửi thành công yêu cầu! Bạn muốn kiểm kê luôn với thông tin của RC vừa rồi?',
                            onConfirm: () async {
                              context.pushRoute(CheckMaterialInStoreRoute(
                                positionOrRc: state
                                    .listReceivingCardScanned.first.barcode,
                              ));
                            },
                          );
                        });
                      },
                      onCancel: () {},
                    );
                  });
                },
              ).paddingSymmetric(horizontal: 16, vertical: 8),
            ],
          ],
        );
      },
    );
  }

  Widget _buildTextFieldBarcode(BalanceRcController cubit) {
    return BlocBuilder<BalanceRcController, BalanceRcState>(
      buildWhen: (prev, current) =>
          prev.balanceAllBox != current.balanceAllBox ||
          prev.listReceivingCardScanned != current.listReceivingCardScanned ||
          prev.balanceAllLot != current.balanceAllLot ||
          prev.balanceScanType != current.balanceScanType,
      builder: (context, state) {
        final hasEdit =
            state.listReceivingCardScanned.any((e) => e.balanceQty != 0);
        return Row(
          children: [
            Expanded(
              child: AppFormField(
                showCursor: true,
                readOnly: true,
                controller: rcController,
                focusNode: rcFocusNode,
                onChanged: cubit.onInputRC,
                decoration: const InputDecoration(
                  hintText: 'Quét Barcode',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                ),
              ).paddingOnly(left: 16, right: 8),
            ),
            if (state.balanceScanType != BalanceScanType.scanBox) ...[
              if (!hasEdit) ...[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                        value: state.balanceAllBox,
                        onChanged: (value) {
                          cubit.onChangeBalanceAllBox(value!);
                        }),
                    const SizedBox(
                      width: 60,
                      child: Text(
                        'Balance all box',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                      value: state.balanceAllLot,
                      onChanged: (value) {
                        cubit.onChangeBalanceAllLot(value!);
                      }),
                  const SizedBox(
                    width: 60,
                    child: Text(
                      'Balance Stock',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildRadioButtonChange(BalanceRcController cubit) {
    return BlocSelector<BalanceRcController, BalanceRcState, BalanceScanType>(
      selector: (state) => state.balanceScanType,
      builder: (context, outType) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppRadio(
              title: 'Scan ReceivingCard',
              value: BalanceScanType.scanRc,
              groupValue: outType,
              onChanged: cubit.changeLocationType,
            ),
            AppRadio(
              title: 'Scan BoxCard',
              value: BalanceScanType.scanBox,
              groupValue: outType,
              onChanged: cubit.changeLocationType,
            ),
          ],
        );
      },
    );
  }

  Widget _buildReceivingCardList(
      BalanceRcController cubit, BalanceRcState state) {
    return BlocSelector<BalanceRcController, BalanceRcState,
        List<ReceivingCard>>(
      selector: (state) => state.listReceivingCardScanned,
      builder: (context, listRC) {
        bool hasEdit = listRC.any((e) => e.items.isEmpty);
        if (listRC.isEmpty) {
          return const SizedBox.shrink();
        }
        return SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: listRC.length,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            itemBuilder: (c, i) {
              return SizedBox(
                height: 180,
                width: 300,
                child: StorageReceivingItem(
                  reCardData: listRC[i],
                  hasEdit: hasEdit,
                  hasRemove: false,
                  fromBalance: true,
                  onEditQty: () {
                    _showModelEditQty(
                      onTap: () {
                        cubit.updateQty(
                          qty: editQtyRcController.text.toInt(),
                          index: i,
                        );
                        editQtyRcController = TextEditingController();
                        Navigator.pop(context);
                      },
                      qty: state.boxCard?.quantity ?? 0,
                      systemQty: state.boxCard?.totalQuantity ?? 0,
                      perQty: 0,
                    );
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 20);
            },
          ),
        );
      },
    );
  }

  Widget _buildBoxList(
    BalanceRcController cubit,
    List<ReceivingCardItem> boxList,
    // bool isBoxCardBalance,
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
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
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
              InkWell(
                onTap: () async {
                  _showModelEditBoxCard(boxList[i].currentQuantity, () {
                    cubit.updateQtyBoxInRc(
                      updateQty: editQtyBoxController.text.toInt(),
                      index: i, rcItem: boxList[i],
                      // isBoxCardBalance: isBoxCardBalance,
                    );
                    editQtyBoxController = TextEditingController();
                    Navigator.pop(context);
                  });
                },
                child: const Icon(
                  Icons.edit,
                  color: Colors.black54,
                  size: 20,
                ).paddingSymmetric(vertical: 5, horizontal: 6),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showModelEditQty({
    required int qty,
    required int systemQty,
    required int perQty,
    required Function onTap,
  }) {
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
                    'Số lượng tại kho',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black54,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 10),
                  AppFormField(
                    showCursor: true,
                    controller: editQtyRcController,
                    decoration: InputDecoration(
                      hintText: qty.toString(),
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                        fontSize: 15,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
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
        );
      },
    );
  }
}
