import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'material_history_transition_controller.dart';
import 'material_history_transition_state.dart';

const _kStoringDateFieldKey = 'storing_date_field';
const _kReceivingDateFieldKey = 'receiving_date_field';
const _kRemarkFieldKey = 'remark_field';
const _kStoreFieldKey = 'store_field';
const _kKittingFieldKey = 'kitting_field';
const _kStockFieldKey = 'stock_field';
const _kBalanceFieldKey = 'balance_field';
const _kPICFieldKey = 'pic_field';

@RoutePage()
class MaterialHistoryTransitionPage extends BasePage<
    MaterialHistoryTransitionController, MaterialHistoryTransitionState> {
  const MaterialHistoryTransitionPage({
    super.key,
    required this.material,
    required this.sloc,
  });

  final String material;
  final String sloc;

  @override
  BasePageState createState() => _MaterialHistoryTransitionPageState();
}

class _MaterialHistoryTransitionPageState extends BasePageState<
    MaterialHistoryTransitionController, MaterialHistoryTransitionState> {
  final dateFormat = DateFormat('dd/MM/yy');

  final List<PlutoRow> rows = [];
  late List<PlutoColumn> columns;
  late PlutoGridStateManager stateManager;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
    ]);

    columns = [
      PlutoColumn(
        title: 'Date',
        field: _kStoringDateFieldKey,
        type: PlutoColumnType.text(),
        width: 20,
      ),
      // PlutoColumn(
      //   title: 'ReceivingDate',
      //   field: _kReceivingDateFieldKey,
      //   type: PlutoColumnType.text(),
      //   width: 20,
      // ),
      PlutoColumn(
        title: 'Remark',
        field: _kRemarkFieldKey,
        type: PlutoColumnType.text(),
        width: 50,
      ),
      PlutoColumn(
        title: 'Store',
        field: _kStoreFieldKey,
        type: PlutoColumnType.number(),
        width: 50,
      ),
      PlutoColumn(
        title: 'Kitting',
        field: _kKittingFieldKey,
        type: PlutoColumnType.number(),
        width: 50,
      ),
      PlutoColumn(
        title: 'Stock',
        field: _kStockFieldKey,
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: 'Adjust Stock',
        field: _kBalanceFieldKey,
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: 'PIC',
        field: _kPICFieldKey,
        type: PlutoColumnType.text(),
        width: 50,
      ),
    ];
    logger.e(widget.as<MaterialHistoryTransitionPage>()!.sloc);
    context.read<MaterialHistoryTransitionController>().initDataMaterial(
          widget.as<MaterialHistoryTransitionPage>()!.material,
          widget.as<MaterialHistoryTransitionPage>()!.sloc,
        );

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    super.dispose();
  }

  @override
  Widget builder(context, cubit, state) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MaterialHistoryTransitionController,
            MaterialHistoryTransitionState>(
          listenWhen: (prev, current) {
            return prev.onSearchHistory != current.onSearchHistory ||
                prev.materialHistoryTransition !=
                    current.materialHistoryTransition;
          },
          listener: (context, state) {
            if (state.onSearchHistory) {
              // final lastIndex = stateManager.refRows.length;

              stateManager.removeAllRows();

              final materialInfoList = state.historyList ?? [];
              final row = List.generate(materialInfoList.length, (index) {
                final materialItem = materialInfoList[index];

                final dateFormat = DateFormat('yyyy-MM-ddTHH:mm');
                final createDate = dateFormat.parse(
                  materialInfoList[index].createdDate ??
                      DateTime.now().toString(),
                );
                final day = createDate.day;
                final month = createDate.month;
                final year = createDate.year;

                final newFormat = '$year/$day/$month';
                return PlutoRow(
                  cells: {
                    _kStoringDateFieldKey: PlutoCell(
                      value: newFormat,
                    ),
                    // _kReceivingDateFieldKey: PlutoCell(
                    //   value: newFormat,
                    // ),
                    _kRemarkFieldKey: PlutoCell(
                      value: materialItem.remark,
                    ),
                    _kStoreFieldKey:
                        PlutoCell(value: materialItem.store?.abs()),
                    _kKittingFieldKey:
                        PlutoCell(value: materialItem.kitting?.abs()),
                    _kStockFieldKey:
                        PlutoCell(value: materialItem.stock?.abs()),
                    _kPICFieldKey: PlutoCell(value: materialItem.createdBy),
                    _kBalanceFieldKey:
                        PlutoCell(value: materialItem.qtyBalance),
                  },
                );
              });

              stateManager.insertRows(0, row);
            }
          },
        ),
        BlocListener<MaterialHistoryTransitionController,
            MaterialHistoryTransitionState>(
          listenWhen: (prev, current) {
            return prev.hasActiveBack != current.hasActiveBack ||
                prev.positionBack != current.positionBack;
          },
          listener: (ctx, state) async {
            Future.delayed(const Duration(milliseconds: 1000), () {
              if (state.hasActiveBack) {
                logger.i('Position: ${state.positionBack}');
                context.popRoute(state.positionBack);
              }
            });
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            LocaleKeys.storing_material_history_transition,
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          ).tr(),
          actions: [
            BlocSelector<MaterialHistoryTransitionController,
                MaterialHistoryTransitionState, String?>(
              selector: (state) {
                return state.currentSloc;
              },
              builder: (context, currentSloc) {
                return InkWell(
                  onTap: () {
                    _showActionBottomSheet(cubit, currentSloc ?? '');
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Icon(
                      Icons.menu,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: _buildBody(cubit, state),
      ),
    );
  }

  Widget _buildBody(
    MaterialHistoryTransitionController cubit,
    MaterialHistoryTransitionState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMaterialInformation(cubit),
        const SizedBox(height: 6),
        _buildDateTime(cubit),
        const SizedBox(height: 10),
        Expanded(
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
              final materialInfoList = state.historyList;
              final row = List.generate(materialInfoList.length, (index) {
                final materialItem = materialInfoList[index];

                final dateFormat = DateFormat('yyyy-MM-ddTHH:mm');
                final createDate = dateFormat.parse(
                  materialInfoList[index].createdDate ??
                      DateTime.now().toString(),
                );
                final day = createDate.day;
                final month = createDate.month;
                final year = createDate.year;

                final newFormat = '$year/$day/$month';
                return PlutoRow(
                  cells: {
                    _kStoringDateFieldKey: PlutoCell(
                      value: newFormat,
                    ),
                    // _kReceivingDateFieldKey: PlutoCell(
                    //   value: newFormat,
                    // ),
                    _kRemarkFieldKey: PlutoCell(
                      value: materialItem.remark,
                    ),
                    _kStoreFieldKey:
                        PlutoCell(value: materialItem.store?.abs()),
                    _kKittingFieldKey:
                        PlutoCell(value: materialItem.kitting?.abs()),
                    _kStockFieldKey:
                        PlutoCell(value: materialItem.stock?.abs()),
                    _kPICFieldKey: PlutoCell(value: materialItem.createdBy),
                    _kBalanceFieldKey:
                        PlutoCell(value: materialItem.qtyBalance),
                  },
                );
              });

              stateManager.insertRows(0, row);
              // stateManager.moveScrollByRow(
              //   PlutoMoveDirection.down,
              //   state.historyList.length,
              // );
            },
            onChanged: (event) {},
          ),
        ),
      ],
    ).paddingAll(16);
  }

  Widget _buildMaterialInformation(MaterialHistoryTransitionController cubit) {
    return BlocBuilder<MaterialHistoryTransitionController,
        MaterialHistoryTransitionState>(
      buildWhen: (prev, current) {
        return prev.materialHistoryTransition !=
            current.materialHistoryTransition;
      },
      builder: (context, state) {
        return Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            Text(
              '${LocaleKeys.storing_material.tr()}: ${state.materialHistoryTransition?.material}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            GestureDetector(
              onTap: () {
                _buildListSloc(cubit);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${LocaleKeys.storing_sloc.tr()}: ${state.currentSloc ?? state.materialHistoryTransition?.slocs?.first}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ).tr(),
                  const Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 15,
                  ),
                ],
              ),
            ),
            Text(
              '${LocaleKeys.storing_stock.tr()}: ${state.materialHistoryTransition?.totalStock}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 5),
            Text(
              '${LocaleKeys.storing_frequency.tr()}: ${state.materialHistoryTransition?.frequency}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 5),
            Text(
              '${LocaleKeys.storing_type.tr()}: ${state.materialHistoryTransition?.type}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 5),
            Text(
              '${LocaleKeys.storing_kind.tr()}: ${state.materialHistoryTransition?.kind}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
    );
  }

  Widget _buildDateTime(MaterialHistoryTransitionController cubit) {
    return BlocBuilder<MaterialHistoryTransitionController,
        MaterialHistoryTransitionState>(
      buildWhen: (prev, current) {
        return prev.fromDate != current.fromDate ||
            prev.isOpenPage != current.isOpenPage ||
            prev.currentSloc != current.currentSloc ||
            prev.toDate != current.toDate;
      },
      builder: (context, state) {
        String? fromDate;
        String? toDate;
        if (state.isOpenPage && state.historyList.isNotEmpty) {
          final currentDate = state.historyList.first.createdDate;
          if (currentDate != null && currentDate.isNotEmpty) {
            DateTime dateTimeRc = DateTime.parse(currentDate);

            fromDate = DateFormat('dd/MM/yy').format(dateTimeRc);
            toDate = DateFormat('dd/MM/yy').format(dateTimeRc);
          }
        } else {
          fromDate = dateFormat.format(state.fromDate);
          toDate = dateFormat.format(state.toDate);
        }

        final currentSloc = state.currentSloc;
        return Row(
          children: [
            const Text(
              LocaleKeys.storing_from_date,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ).tr(),
            const SizedBox(width: 4),
            InkWell(
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  minTime: DateTime(2001),
                  maxTime: DateTime.now(),
                  onChanged: (date) {
                    cubit.onChangeFromDate(date);
                  },
                  onConfirm: (date) {
                    cubit.onChangeFromDate(date);
                  },
                  currentTime: state.fromDate,
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
                  fromDate!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4),
            const Text(
              LocaleKeys.storing_to_date,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ).tr(),
            const SizedBox(width: 4),
            InkWell(
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  minTime: DateTime(2001),
                  maxTime: DateTime.now(),
                  onChanged: (date) {
                    cubit.onChangeToDate(date);
                  },
                  onConfirm: (date) {
                    cubit.onChangeToDate(date);
                  },
                  currentTime: state.toDate,
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
                  toDate!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () async {
                await cubit.onSearch(
                  material:
                      widget.as<MaterialHistoryTransitionPage>()!.material,
                  sloc: currentSloc,
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff53B1F5),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  LocaleKeys.storing_search.tr(),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showActionBottomSheet(
    MaterialHistoryTransitionController cubit,
    String currentSloc,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () async {
                  Navigator.pop(context);

                  final res = await context.pushRoute(
                    MaterialPositionRoute(
                      material:
                          widget.as<MaterialHistoryTransitionPage>()!.material,
                      currentSloc: currentSloc,
                    ),
                  );
                  if (res != null && res is String) {
                    cubit.onActiveBack(res);

                    // 200.milliseconds.delay(() {
                    //   // context.router.pop(res);
                    //   cubit.onActiveBack(res);
                    // });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_pin,
                        color: Color(0xff24DBD0),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        LocaleKeys.storing_position.tr(),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 2,
                color: Colors.grey.withOpacity(0.3),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);

                  context.pushRoute(
                    MaterialSampleRoute(
                        material: widget
                            .as<MaterialHistoryTransitionPage>()!
                            .material),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.egg_alt_rounded,
                        color: Color(0xffFFE7E7),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        LocaleKeys.storing_sample.tr(),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _buildListSloc(MaterialHistoryTransitionController cubit) {
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
          child: BlocBuilder<MaterialHistoryTransitionController,
              MaterialHistoryTransitionState>(
            buildWhen: (prev, current) {
              return prev.materialHistoryTransition !=
                  current.materialHistoryTransition;
            },
            builder: (context, state) {
              final slocList = state.listSlocOnMaterial;
              if (slocList.isEmpty) {
                return const SizedBox();
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LocaleKeys.storing_select_sloc_for_searching.tr(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    itemCount: slocList.length,
                    shrinkWrap: true,
                    itemBuilder: (_, i) {
                      return GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);

                          await cubit.onSearch(
                              material: widget
                                  .as<MaterialHistoryTransitionPage>()!
                                  .material,
                              sloc: slocList[i]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blueAccent),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Center(
                            child: Text(
                              'Sloc: ${slocList[i]}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                        color: Colors.black12,
                      );
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
