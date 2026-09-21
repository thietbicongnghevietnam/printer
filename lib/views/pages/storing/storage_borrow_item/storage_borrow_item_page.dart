import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/int_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

import 'storage_borrow_item_controller.dart';
import 'storage_borrow_item_state.dart';

@RoutePage()
class StorageBorrowItemPage
    extends BasePage<StorageBorrowItemController, StorageBorrowItemState> {
  const StorageBorrowItemPage({super.key});

  @override
  BasePageState createState() => _StorageBorrowPageState();
}

class _StorageBorrowPageState
    extends BasePageState<StorageBorrowItemController, StorageBorrowItemState> {
  late TextEditingController borrowItemController;
  late TextEditingController locationController;
  late TextEditingController remarkController;
  late ScrollController scrollController;

  late FocusNode borrowItemFocusNode;
  late FocusNode remarkFocus;
  late FocusNode locationFocusNode;

  late PdaDevice pdaDevice;

  @override
  void initState() {
    super.initState();

    borrowItemController = TextEditingController();
    locationController = TextEditingController();
    remarkController = TextEditingController();
    scrollController = ScrollController();

    borrowItemFocusNode = FocusNode()..requestFocus();
    remarkFocus = FocusNode();
    locationFocusNode = FocusNode();

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) async {
      if (locationFocusNode.hasFocus) {
        context.read<StorageBorrowItemController>().updateLocation(data);
      }
      if (borrowItemFocusNode.hasFocus) {
        context.read<StorageBorrowItemController>().updateGoodsItem(data);
      }
    });
  }

  bool isVisible = false;

  @override
  void dispose() {
    borrowItemController.dispose();
    locationController.dispose();
    scrollController.dispose();
    remarkController.dispose();

    pdaDevice.dispose();
    super.dispose();
  }

  @override
  Widget builder(context, cubit, state) {
    return MultiBlocListener(
      listeners: [
        BlocListener<StorageBorrowItemController, StorageBorrowItemState>(
          listenWhen: (prev, current) {
            return prev.itemList != current.itemList;
          },
          listener: (context, state) {
            if (state.itemList.isNotEmpty && scrollController.hasClients) {
              200.milliseconds.delay(() {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.linear,
                );
              });
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.storing_borrow_item).tr(),
        ),
        body: _buildBody(cubit),
        bottomNavigationBar:
            BlocBuilder<StorageBorrowItemController, StorageBorrowItemState>(
          buildWhen: (prev, current) {
            return prev.itemList != current.itemList ||
                prev.goods != current.goods ||
                prev.location != current.location;
          },
          builder: (context, state) {
            return Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: GestureDetector(
                      onTap: () {
                        cubit.addGoodsItem(
                          goodsItem: borrowItemController.text,
                          remark: remarkController.text,
                          location: locationController.text,
                        );
                        borrowItemController.clear();
                        remarkController.clear();
                        locationController.clear();
                        cubit.clearData();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          color: (state.goods.isNotEmpty &&
                                  state.location.isNotEmpty)
                              ? const Color(0xff0370C8)
                              : Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          LocaleKeys.storing_add_borrow_goods,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ).tr(),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await cubit.storingBorrowGoods();

                    await Duration.zero.delay(
                      () async {
                        getIt<AppAlertDialog>().show(
                          context,
                          message:
                              LocaleKeys.storing_storing_product_success.tr(),
                          onConfirm: () {
                            borrowItemController.clear();
                            remarkController.clear();
                            locationController.clear();

                            borrowItemFocusNode.requestFocus();
                          },
                        );
                      },
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    width: state.itemList.isNotEmpty ? 150 : 0,
                    height: state.itemList.isNotEmpty ? 50 : 0,
                    decoration: BoxDecoration(
                      color: const Color(0xff0370C8),
                      borderRadius: state.itemList.isNotEmpty
                          ? BorderRadius.circular(10)
                          : BorderRadius.circular(0),
                    ),
                    child: state.itemList.isNotEmpty
                        ? Center(
                            child: const Text(
                              LocaleKeys.storing_storing_receiving,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.center,
                            ).tr(),
                          )
                        : null,
                  ),
                ),
                if (state.itemList.isNotEmpty) const SizedBox(width: 15),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(StorageBorrowItemController cubit) {
    return BlocBuilder<StorageBorrowItemController, StorageBorrowItemState>(
      buildWhen: (prev, current) {
        return prev.itemList != current.itemList;
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBorrowItemTextField(cubit),
            const SizedBox(height: 8),
            _buildRemarkTextField(cubit),
            const SizedBox(height: 8),
            _buildLocationTextField(cubit),
            if (state.itemList.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(LocaleKeys.storing_borrow_goods_list).tr(),
              const SizedBox(height: 15),
              _buildItemList(cubit),
            ],
          ],
        );
      },
    ).paddingAll(16);
  }

  Widget _buildBorrowItemTextField(StorageBorrowItemController cubit) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: const Text(LocaleKeys.storing_item).tr(),
        ),
        Expanded(
          child: AppFormField(
            showCursor: true,
            controller: borrowItemController,
            focusNode: borrowItemFocusNode,
            onChanged: (value) {
              cubit.updateGoodsItem(value);
            },
          ),
        ),
        GestureDetector(
          onTap: () async {
            final product = await context.pushRoute<String>(
              const CameraCaptureRoute(),
            );
            if (product != null) {
              borrowItemController.text = product;
              cubit.updateGoodsItem(product);
            }
          },
          child: const Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
            child: Icon(
              Icons.camera_alt,
              color: Colors.blue,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRemarkTextField(StorageBorrowItemController cubit) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: const Text(LocaleKeys.storing_remark).tr(),
        ),
        Expanded(
          child: AppFormField(
            showCursor: true,
            controller: remarkController,
            focusNode: remarkFocus,
          ),
        ),
        GestureDetector(
          onTap: () async {
            final remark = await context.pushRoute<String>(
              const CameraCaptureRoute(),
            );
            if (remark != null) {
              remarkController.text = remark;
              cubit.updateRemark(remark);
            }
          },
          child: const Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
            child: Icon(
              Icons.camera_alt,
              color: Colors.blue,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationTextField(StorageBorrowItemController cubit) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: const Text(LocaleKeys.storing_location).tr(),
        ),
        Expanded(
          child: AppFormField(
            showCursor: true,
            controller: locationController,
            focusNode: locationFocusNode,
            onChanged: (value) {
              cubit.updateLocation(value);
            },
          ),
        ),
        GestureDetector(
          onTap: () async {
            final location = await context.pushRoute<String>(
              const CameraCaptureRoute(),
            );
            if (location != null) {
              locationController.text = location;
              cubit.updateLocation(location);
            }
          },
          child: const Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
            child: Icon(
              Icons.camera_alt,
              color: Colors.blue,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItemList(StorageBorrowItemController cubit) {
    return BlocBuilder<StorageBorrowItemController, StorageBorrowItemState>(
      buildWhen: (prev, current) {
        return prev.itemList != current.itemList;
      },
      builder: (context, state) {
        return Expanded(
          child: ListView.separated(
            controller: scrollController,
            addRepaintBoundaries: false,
            addAutomaticKeepAlives: false,
            shrinkWrap: true,
            itemCount: state.itemList.length,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, i) {
              return _borrowGoodsItem(
                location: state.itemList[i].blockName,
                goodsItem: state.itemList[i].goodsName,
                remark: state.itemList[i].remark,
                onRemove: () {
                  cubit.removeGoodsItem(i);
                },
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 15);
            },
          ),
        );
      },
    );
  }

  Widget _borrowGoodsItem({
    String? remark,
    Function? onRemove,
    required String location,
    required String goodsItem,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      LocaleKeys.storing_item,
                      style: TextStyle(
                        color: Color(0xff53B1F5),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ).tr(),
                    Expanded(
                      child: Text(
                        ': $goodsItem',
                        style: const TextStyle(
                          color: Color(0xff0A2753),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const Text(
                      LocaleKeys.storing_location,
                      style: TextStyle(
                        color: Color(0xff53B1F5),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ).tr(),
                    Expanded(
                      child: Text(
                        ': $location',
                        style: const TextStyle(
                          color: Color(0xff0A2753),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Text(
                      LocaleKeys.storing_remark,
                      style: TextStyle(
                        color: Color(0xff0A2753),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ).tr(),
                    Text(': ${remark ?? ''}'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              onRemove?.call();
            },
            padding: const EdgeInsets.all(2),
            icon: const Icon(Icons.cancel_outlined),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
