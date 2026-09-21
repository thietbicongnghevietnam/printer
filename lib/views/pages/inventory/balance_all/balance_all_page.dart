import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/inventory/balance_detail.dart';
import 'package:smart_warehouse/entities/inventory/plant_sloc_category.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

import 'balance_all_controller.dart';
import 'balance_all_state.dart';

@RoutePage()
class BalanceAllPage extends BasePage<BalanceAllController, BalanceAllState> {
  const BalanceAllPage({
    super.key,
  });

  @override
  BasePageState createState() => _BalanceAllPageState();
}

class _BalanceAllPageState
    extends BasePageState<BalanceAllController, BalanceAllState> {
  late TextEditingController currentQtyController;
  late TextEditingController systemQtyController;
  late TextEditingController noteController;
  late TextEditingController rcController;

  late FocusNode currentQtyFocusNode;
  late FocusNode systemQtyFocusNode;
  late FocusNode noteFocusNode;
  late FocusNode rcFocusNode;

  late PdaDevice pdaDevice;

  late PagingController<int, BalanceDetail> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    currentQtyController = TextEditingController();
    systemQtyController = TextEditingController();
    noteController = TextEditingController();
    rcController = TextEditingController();

    currentQtyFocusNode = FocusNode()..requestFocus();
    systemQtyFocusNode = FocusNode();
    noteFocusNode = FocusNode();
    rcFocusNode = FocusNode();

    _pagingController.addPageRequestListener((pageKey) async {
      try {
        await _fetchPage(pageKey);
      } catch (error) {
        _pagingController.error = error;
      }
    });

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) {
      if (rcFocusNode.hasFocus) {
        context.read<BalanceAllController>().onInputMaterial(data);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    currentQtyController.dispose();
    currentQtyFocusNode.dispose();

    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    final newItems = await context.read<BalanceAllController>().onLoadMore(
          pageNumber: pageKey + 1,
        );
    final isLastPage = newItems.$1;
    if (isLastPage) {
      if (newItems.$2.isNotEmpty) {
        _pagingController.appendLastPage(newItems.$2);
      } else {
        _pagingController.appendLastPage([]);
      }
    } else {
      _pagingController.appendPage(newItems.$2, pageKey + 1);
    }
  }

  @override
  Widget builder(context, cubit, state) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BalanceAllController, BalanceAllState>(
          listenWhen: (preState, state) =>
              preState.isSearched != state.isSearched,
          listener: (context, state) {
            _pagingController.refresh();
          },
        ),
        BlocListener<BalanceAllController, BalanceAllState>(
          listenWhen: (preState, state) =>
              preState.receivingCard != state.receivingCard,
          listener: (context, state) {
            rcController.text = state.receivingCard?.material ?? '';
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Balance All Page'),
          actions: [
            GestureDetector(
              onTap: () {
                onTapFilter(cubit: cubit);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.filter_list,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
        body: _buildBody(cubit),
      ),
    );
  }

  void onTapFilter({
    required BalanceAllController cubit,
  }) {
    showModalBottomSheet<void>(
      context: context,
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
                    Row(
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
                    ),
                    const SizedBox(height: 15),
                    const Divider(height: 1, color: Colors.grey),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      child: const Text('Tìm kiếm').tr(),
                      onPressed: () async {
                        // Search with filter
                        Navigator.pop(context);
                        cubit.searchBalance(isSearched: true);
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

  Widget _buildBody(BalanceAllController cubit) {
    return BlocBuilder<BalanceAllController, BalanceAllState>(
      buildWhen: (prev, current) {
        return prev.listBalanceDetail != current.listBalanceDetail ||
            prev.listUpdateBalance != current.listUpdateBalance;
      },
      builder: (context, state) {
        return Column(
          children: [
            AppFormField(
              showCursor: true,
              readOnly: true,
              controller: rcController,
              focusNode: rcFocusNode,
              onChanged: cubit.onInputMaterial,
              decoration: const InputDecoration(
                hintText: 'Quét ReceivingCard',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                  fontSize: 15,
                ),
              ),
            ).paddingOnly(left: 16, right: 16, top: 16, bottom: 20),
            if (state.listBalanceDetail.isNotEmpty) ...[
              Expanded(child: _buildIncorrectQtyList(cubit, state)),
              if (state.listUpdateBalance.isNotEmpty)
                ElevatedButton(
                  child: const Text('Cập nhật lại số lượng').tr(),
                  onPressed: () async {
                    await cubit.createBalanceQty();

                    Duration.zero.delay(() async {
                      getIt<AppAlertDialog>().show(
                        context,
                        message: 'Đã gửi thành công yêu cầu!',
                        onConfirm: () async {
                        },
                      );
                    });
                  },
                ).paddingSymmetric(horizontal: 16, vertical: 8),
            ] else
              Center(
                child: const Text(LocaleKeys.error_do_not_have_data).tr(),
              )
          ],
        );
      },
    );
  }

  Widget _buildIncorrectQtyList(
      BalanceAllController cubit, BalanceAllState state) {
    return PagedListView<int, BalanceDetail>(
      pagingController: _pagingController,
      shrinkWrap: true,
      addRepaintBoundaries: false,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      builderDelegate: PagedChildBuilderDelegate<BalanceDetail>(
        itemBuilder: (context, item, index) {
          return _buildIncorrectItem(item, index, cubit).paddingOnly(bottom: 8);
        },
        noItemsFoundIndicatorBuilder: (_) {
          return Center(
              child: const Text(LocaleKeys.error_do_not_have_data).tr());
        },
      ),
    );
  }

  Widget _buildPlantSelection(BalanceAllController cubit) {
    return BlocBuilder<BalanceAllController, BalanceAllState>(
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

  Widget _buildCateSelection(BalanceAllController cubit) {
    return BlocBuilder<BalanceAllController, BalanceAllState>(
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

  Widget _buildSlocSelection(BalanceAllController cubit) {
    return BlocBuilder<BalanceAllController, BalanceAllState>(
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
              child: Text(value ?? ''),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildIncorrectItem(
    BalanceDetail balance,
    int index,
    BalanceAllController cubit,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: balance.isUpdate ? Colors.green : Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRichText(
                label: LocaleKeys.storing_plan.tr(),
                value: '${balance.plant}',
                isUpdate: balance.isUpdate,
              ),
              _buildRichText(
                label: LocaleKeys.storing_sloc.tr(),
                value: '${balance.sloc}',
                isUpdate: balance.isUpdate,
              ),
              _buildRichText(
                label: LocaleKeys.storing_category.tr(),
                value: '${balance.category}',
                isUpdate: balance.isUpdate,
              ),
              _buildRichText(
                label: LocaleKeys.storing_material.tr(),
                isUpdate: balance.isUpdate,
                value: '${balance.material}',
              ),
              _buildRichText(
                label: LocaleKeys.storing_current_quantity.tr(),
                isUpdate: balance.isUpdate,
                value: '${balance.currentQuantity}',
              ),
              _buildRichText(
                label: 'SAP Qty',
                value: '${balance.sapQuantity}',
                isUpdate: balance.isUpdate,
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              _showModelEditQty(
                qty: balance.currentQuantity ?? 0,
                systemQty: balance.sapQuantity ?? 0,
                perQty: balance.perQuantity ?? 0,
                onTap: () {
                  Navigator.pop(context);

                  int? balanceQty = currentQtyController.text.toInt();

                  cubit.updateBalanceQty(
                    detail: balance,
                    balanceQty: balanceQty,
                    sysQty: balance.currentQuantity ?? 0,
                    index: index,
                    note: noteController.text,
                  );

                  currentQtyController = TextEditingController();
                  systemQtyController = TextEditingController();
                  noteController = TextEditingController();
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.edit,
                color: Color(0xff53B1F5),
                size: 19,
              ),
            ),
          ),
        ],
      ),
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
                    controller: currentQtyController,
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
                  const Text(
                    'Số lượng tại SAP',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black54,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 10),
                  AppFormField(
                    showCursor: true,
                    readOnly: true,
                    enabled: false,
                    controller: systemQtyController,
                    decoration: InputDecoration(
                      hintText: systemQty.toString(),
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                        fontSize: 15,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Ghi chú',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black54,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 10),
                  AppFormField(
                    showCursor: true,
                    controller: noteController,
                  ),
                  // const SizedBox(height: 20),
                  // Text(
                  //   'Số lượng chênh lệch: $perQty',
                  //   style: const TextStyle(
                  //     fontWeight: FontWeight.w700,
                  //     color: Colors.redAccent,
                  //     fontSize: 17,
                  //   ),
                  // ),
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

  Widget _buildRichText({
    required String label,
    required String value,
    bool isUpdate = false,
  }) {
    return RichText(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 11,
          color: Colors.red,
        ),
        children: [
          TextSpan(
            text: ' $value',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11,
              color: isUpdate ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
