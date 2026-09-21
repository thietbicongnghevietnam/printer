import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';

import 'material_position_controller.dart';
import 'material_position_state.dart';

const _kStoringDateFieldKey = 'storing_date_field';
const _kReceivingDateFieldKey = 'receiving_date_field';
const _kStoreFieldKey = 'store_field';
const _kKittingFieldKey = 'kitting_field';
const _kTempFieldKey = 'temp_field';
const _kPositionFieldKey = 'position_field';

@RoutePage()
class MaterialPositionPage
    extends BasePage<MaterialPositionController, MaterialPositionState> {
  const MaterialPositionPage({
    super.key,
    required this.material,
    required this.currentSloc,
  });

  final String material;
  final String currentSloc;

  @override
  BasePageState createState() => _PositionPage();
}

class _PositionPage
    extends BasePageState<MaterialPositionController, MaterialPositionState> {
  final List<PlutoRow> rows = [];
  late List<PlutoColumn> columns;
  late PlutoGridStateManager stateManager;

  @override
  void initState() {
    super.initState();
    final sloc = widget.as<MaterialPositionPage>()?.currentSloc;
    final material = widget.as<MaterialPositionPage>()?.material;
    context
        .read<MaterialPositionController>()
        .initDataMaterial(material!, sloc!);

    columns = [
      PlutoColumn(
        title: 'Position',
        field: _kPositionFieldKey,
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
        title: 'Store',
        field: _kStoreFieldKey,
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: 'Temp',
        field: _kTempFieldKey,
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: 'Store Date',
        field: _kStoringDateFieldKey,
        type: PlutoColumnType.text(),
        width: 30,
      ),
      PlutoColumn(
        title: 'Receive Date',
        field: _kReceivingDateFieldKey,
        type: PlutoColumnType.text(),
        width: 30,
      ),
    ];
    context.read<MaterialPositionController>().initDataMaterial(
          widget.as<MaterialPositionPage>()!.material,
          widget.as<MaterialPositionPage>()!.currentSloc,
        );
  }

  @override
  Widget builder(context, cubit, state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.storing_position).tr(),
      ),
      body: BlocBuilder<MaterialPositionController, MaterialPositionState>(
        buildWhen: (prev, current) {
          return prev.materialList != current.materialList;
        },
        builder: (context, state) {
          final kittingQty = state.materialList.first.qtyKitting;
          final tempQty = state.materialList.first.qtyTemp;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Material:',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.red,
                  ),
                  children: [
                    TextSpan(
                      text: ' ${widget.as<MaterialPositionPage>()?.material}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ).paddingOnly(top: 10),
              RichText(
                text: TextSpan(
                  text: 'Total Qty:',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.red,
                  ),
                  children: [
                    TextSpan(
                      text:
                          ' ${state.materialList.fold(0, (sum, e) => sum + (e.totalCurrentQuantity ?? 0))}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ).paddingOnly(top: 10),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Sloc:',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.red,
                      ),
                      children: [
                        TextSpan(
                          text:
                              ' ${widget.as<MaterialPositionPage>()?.currentSloc}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ).paddingOnly(top: 10, bottom: 8, right: 15),
                  RichText(
                    text: TextSpan(
                      text: 'Kitting Qty:',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.red,
                      ),
                      children: [
                        TextSpan(
                          text: ' $kittingQty',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ).paddingOnly(top: 10, bottom: 8, right: 15),
                  RichText(
                    text: TextSpan(
                      text: 'Temp Qty:',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.red,
                      ),
                      children: [
                        TextSpan(
                          text: ' $tempQty',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ).paddingOnly(top: 10, bottom: 8),
                ],
              ),
              _buildTableTitle(),
              _buildListMaterial(cubit, state),
            ],
          ).paddingSymmetric(horizontal: 20, vertical: 16);
        },
      ),
    );
  }

  Widget _buildTableTitle() {
    return Row(
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
                border: const Border(
                  top: BorderSide(),
                  left: BorderSide(),
                  bottom: BorderSide(),
                ),
                color: Colors.yellow.withOpacity(0.5)),
            child: const Center(
              child: Text(
                'No',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              border: const Border(
                top: BorderSide(),
                left: BorderSide(),
                bottom: BorderSide(),
              ),
              color: Colors.yellow.withOpacity(0.5),
            ),
            child: Center(
              child: const Text(
                LocaleKeys.storing_position,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
              ).tr(),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              border: const Border(
                top: BorderSide(),
                left: BorderSide(),
                bottom: BorderSide(),
              ),
              color: Colors.yellow.withOpacity(0.5),
            ),
            child: const Center(
              child: Text(
                "Q'ty",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              border: const Border(
                top: BorderSide(),
                left: BorderSide(),
                bottom: BorderSide(),
                right: BorderSide(),
              ),
              color: Colors.yellow.withOpacity(0.5),
            ),
            child: Center(
              child: const Text(
                'Store Date',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
              ).tr(),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              border: const Border(
                top: BorderSide(),
                bottom: BorderSide(),
                right: BorderSide(),
              ),
              color: Colors.yellow.withOpacity(0.5),
            ),
            child: Center(
              child: const Text(
                'Receive Date',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
              ).tr(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListMaterial(
    MaterialPositionController cubit,
    MaterialPositionState state,
  ) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.materialList.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (ctx, i) {
          final materialList = state.materialList;
          DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mm');

          DateTime dateTimeStore = dateFormat.parse(
            state.materialList[i].createdDate ?? DateTime.now().toString(),
          );

          DateTime dateTimeRc = DateTime.parse(
              state.materialList[i].receivingCardDate ??
                  DateTime.now().toString());

          String formattedDateRC = DateFormat('dd/MM/yyyy').format(dateTimeRc);
          String formattedDateStore =
              DateFormat('dd/MM/yyyy').format(dateTimeStore);

          if (materialList[i].totalCurrentQuantity == 0) {
            return const SizedBox.shrink();
          }

          return GestureDetector(
            onTap: () {
              context.popRoute(state.materialList[i].position);
              // context.pushRoute(CheckBlockDataRoute(blockName: state.materialList[i].position));
            },
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                    )),
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                    )),
                    padding: const EdgeInsets.only(
                      left: 2,
                      top: 3,
                      bottom: 3,
                    ),
                    child: Text(
                      materialList[i].position ?? '',
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                    )),
                    padding: const EdgeInsets.only(
                      left: 2,
                      top: 3,
                      bottom: 3,
                    ),
                    child: Text(
                      '${materialList[i].totalCurrentQuantity ?? 0}',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    )),
                    padding: const EdgeInsets.only(
                      left: 2,
                      top: 3,
                      bottom: 3,
                    ),
                    child: Text(
                      formattedDateStore,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(),
                      right: BorderSide(),
                    )),
                    padding: const EdgeInsets.only(
                      left: 2,
                      top: 3,
                      bottom: 3,
                    ),
                    child: Text(
                      formattedDateRC,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
