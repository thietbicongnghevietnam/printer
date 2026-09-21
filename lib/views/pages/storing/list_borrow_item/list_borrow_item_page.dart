import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/services/models/response/borrow_goods_response_model.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/auth_guard.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

import 'list_borrow_item_controller.dart';
import 'list_borrow_item_state.dart';

@RoutePage()
class ListBorrowItemPage
    extends BasePage<ListBorrowItemController, ListBorrowItemState> {
  const ListBorrowItemPage({super.key});

  @override
  BasePageState createState() => _ListBorrowItemPageState();
}

class _ListBorrowItemPageState
    extends BasePageState<ListBorrowItemController, ListBorrowItemState> {
  late TextEditingController _searchController;
  final ScrollController _scrollController = ScrollController();

  late FocusNode _searchFocusNode;

  late PagingController<int, BorrowGoodsResponseModel> _pagingController =
      PagingController(firstPageKey: 0);

  late PdaDevice pdaDevice;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    context.read<ListBorrowItemController>().initDataBorrowList();

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) async {
      if (_searchFocusNode.hasFocus) {
        _searchController.text = data;
      }
    });

    _pagingController.addPageRequestListener((pageKey) async {
      try {
        await _fetchPage(pageKey);
      } catch (error) {
        _pagingController.error = error;
      }
    });

    _searchFocusNode = FocusNode()..requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pagingController.dispose();
    _searchFocusNode.dispose();
    pdaDevice.dispose();

    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    final newItems = await context.read<ListBorrowItemController>().onLoadMore(
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
        BlocListener<ListBorrowItemController, ListBorrowItemState>(
          listenWhen: (preState, state) =>
              preState.isSearched != state.isSearched,
          listener: (context, state) {
            _pagingController.refresh();
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.storing_borrow_goods_list).tr(),
        ),
        body: _buildBody(cubit),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await context.pushRoute(const StorageBorrowItemRoute());
            Future.delayed(const Duration(milliseconds: 200), () {
              // reset list to get new item
              context
                  .read<ListBorrowItemController>()
                  .initDataBorrowList(isSearched: true, searchName: '');
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildBody(ListBorrowItemController cubit) {
    return BlocListener<ListBorrowItemController, ListBorrowItemState>(
      listenWhen: (preState, state) => preState.isSearched != state.isSearched,
      listener: (context, state) {
        _pagingController.refresh();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchTextField(cubit),
          _buildReCardList(cubit),
        ],
      ),
    );
  }

  Widget _buildSearchTextField(ListBorrowItemController cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: 65,
            child: const Text(LocaleKeys.storing_search).tr(),
          ),
          BlocSelector<ListBorrowItemController, ListBorrowItemState, bool?>(
            selector: (state) {
              return state.isSearched;
            },
            builder: (context, state) {
              return Expanded(
                child: AppFormField(
                  showCursor: true,
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        cubit.initDataBorrowList(
                          searchName: _searchController.text,
                          isSearched: true,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff24DBD0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        child: const Icon(
                          Icons.search_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    hintText: LocaleKeys.storing_search_borrow_item.tr(),
                    hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReCardList(ListBorrowItemController cubit) {
    return BlocBuilder<ListBorrowItemController, ListBorrowItemState>(
      buildWhen: (prev, current) {
        return prev.borrowGoodsList != current.borrowGoodsList;
      },
      builder: (context, state) {
        return Expanded(
          // child: ListView.builder(
          //   physics: const ClampingScrollPhysics(),
          //   shrinkWrap: true,
          //   controller: _scrollController,
          //   itemCount: state.borrowGoodsList.length,
          //   itemBuilder: (context, index) {
          //     return _buildBorrowItem(state.borrowGoodsList[index], cubit)
          //         .paddingOnly(bottom: 8);
          //   },
          // ),
          child: PagedListView<int, BorrowGoodsResponseModel>(
            pagingController: _pagingController,
            padding: const EdgeInsets.all(16),
            builderDelegate:
                PagedChildBuilderDelegate<BorrowGoodsResponseModel>(
              itemBuilder: (context, item, index) {
                return _buildBorrowItem(item, cubit).paddingOnly(bottom: 8);
              },
              noItemsFoundIndicatorBuilder: (_) {
                return  Center(
                    child: const Text(LocaleKeys.error_do_not_have_data).tr());
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildBorrowItem(
    BorrowGoodsResponseModel value,
    ListBorrowItemController cubit,
  ) {
    DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mm');
    DateTime dateTime =
        dateFormat.parse(value.createdDate ?? DateTime.now().toString());
    final hour = dateTime.hour;
    final minute = dateTime.minute;
    final day = dateTime.day;
    final month = dateTime.month;
    final year = dateTime.year;
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              getIt<AppAlertDialog>().show(
                context,
                message: LocaleKeys.storing_out_borrow_goods.tr(),
                onConfirm: () async {
                  await cubit.outBorrowItem(value.id!);

                  _pagingController.refresh();
                },
              );
            },
            backgroundColor: Colors.red.withOpacity(0.5),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: LocaleKeys.storing_out.tr(),
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffEEF2FB)),
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
                  Text(
                    value.goodsName ?? '',
                    style: const TextStyle(
                      color: Color(0xff0A2753),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        color: Color(0xff24DBD0),
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        value.floorName ?? '',
                        style: const TextStyle(
                          color: Color(0xff868D95),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        ', ${value.zoneName}' ?? '',
                        style: const TextStyle(
                          color: Color(0xff868D95),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Assets.images.icRack.image(width: 20, height: 20),
                      const SizedBox(width: 4),
                      Text(
                        value.rackCode ?? '',
                        style: const TextStyle(
                          color: Color(0xff868D95),
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        ', ${value.blockName}' ?? '',
                        style: const TextStyle(
                          color: Color(0xff868D95),
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.edit_note,
                        color: Color(0xff868D95),
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          value.remark ?? '',
                          style: const TextStyle(
                            color: Color(0xff868D95),
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              '$year/$day/$month $hour:$minute' ?? '',
              style: const TextStyle(
                color: Color(0xff868D95),
                fontWeight: FontWeight.w400,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
