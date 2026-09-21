import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/entities/delivery_plan_detail.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/views/dialogs/delivery_plan_detail_dialog.dart';
import 'package:smart_warehouse/views/dialogs/filter_delivery_plan_dialog.dart';

import 'da_invoice_controller.dart';
import 'da_invoice_state.dart';

const _kNoFieldKey = 'no_field';
const _kPartNoFieldKey = 'part_no_field';
const _kQtyFieldKey = 'qty_field';

@RoutePage()
class DAInvoicePage extends BasePage<DAInvoiceController, DAInvoiceState> {
  const DAInvoicePage({
    super.key,
    required this.deliveryPlan,
  });

  final DeliveryPlan deliveryPlan;

  @override
  DAInvoiceController buildCubit(BuildContext context) {
    return getIt<DAInvoiceController>()..deliveryPlan = deliveryPlan;
  }

  @override
  BasePageState createState() => _DAInvoicePageState();
}

class _DAInvoicePageState
    extends BasePageState<DAInvoiceController, DAInvoiceState> {
  late PlutoGridStateManager stateManager;
  String material = '';

  List<PlutoColumn> columns = [
    PlutoColumn(
      title: LocaleKeys.da_invoice_no.tr(),
      field: _kNoFieldKey,
      type: PlutoColumnType.number(),
      enableContextMenu: false,
      enableDropToResize: false,
      width: 80,
    ),
    PlutoColumn(
      title: LocaleKeys.da_invoice_part_no.tr(),
      field: _kPartNoFieldKey,
      type: PlutoColumnType.text(),
      enableContextMenu: false,
      enableDropToResize: false,
    ),
    PlutoColumn(
      title: LocaleKeys.da_invoice_qty.tr(),
      field: _kQtyFieldKey,
      type: PlutoColumnType.text(),
      enableContextMenu: false,
      enableDropToResize: false,
      width: 150,
    ),
  ];

  List<PlutoRow> rows = [];

  @override
  Widget builder(context, cubit, state) {
    return BlocSelector<DAInvoiceController, DAInvoiceState, DeliveryPlan?>(
      selector: (state) => state.deliveryPlan,
      builder: (context, daInvoice) {
        return Scaffold(
          appBar: AppBar(
            title: Text('${daInvoice?.type} ${daInvoice?.no}'),
            actions: [
              IconButton(
                onPressed: () async {
                  material = '';
                  await cubit.loadDAInvoiceDetail();
                  loadData(state);
                },
                icon: const Icon(Icons.sync),
              ),
              IconButton(
                onPressed: () {
                  showFilterDeliveryPlanDialog(
                    context,
                    onSearch: (material) {
                      this.material = material;
                      loadData(state, material);
                    },
                  );
                },
                icon: const Icon(Icons.filter_alt),
              ),
            ],
          ),
          body: PlutoGrid(
            rowColorCallback: (rowContext) {
              final totalQuantity =
                  daInvoice?.details[rowContext.rowIdx].totalQuantity ?? 0;
              final gredQuantity =
                  daInvoice?.details[rowContext.rowIdx].gredQuantity ?? 0;
              if (gredQuantity >= totalQuantity) {
                return Colors.greenAccent;
              } else if (gredQuantity > 0) {
                return Colors.yellow;
              }

              return Colors.transparent;
            },
            mode: PlutoGridMode.selectWithOneTap,
            columns: columns,
            rows: rows,
            configuration: const PlutoGridConfiguration(
              columnSize: PlutoGridColumnSizeConfig(
                autoSizeMode: PlutoAutoSizeMode.scale,
                resizeMode: PlutoResizeMode.none,
              ),
            ),
            onSelected: (event) {
              final deliveryPlanDetail = getListData(state, material)[event.rowIdx ?? 0];
              showDeliveryPlanDetailDialog(
                context,
                deliveryPlanDetail: deliveryPlanDetail,
                onOpenReceivingCardList: () {
                  context.pushRoute(
                    ReceivingCardListRoute(
                      deliveryPlan: daInvoice!,
                      material: deliveryPlanDetail.material,
                    ),
                  );
                },
              );
            },
            onLoaded: (event) {
              stateManager = event.stateManager;
              stateManager.setSelectingMode(PlutoGridSelectingMode.none);

              loadData(state);
            },
          ),
        );
      },
    );
  }

  void loadData(DAInvoiceState state, [String material = '']) {
    final rows = getListData(state, material)
        .mapIndexed(
          (index, e) => PlutoRow(
            cells: {
              _kNoFieldKey: PlutoCell(value: index + 1),
              _kPartNoFieldKey: PlutoCell(value: e.material),
              _kQtyFieldKey: PlutoCell(
                value: '${e.gredQuantity}/${e.totalQuantity}',
              ),
            },
          ),
        )
        .toList();
    stateManager.refRows.clear();
    stateManager.insertRows(0, rows);
  }

  List<DeliveryPlanDetail> getListData(
    DAInvoiceState state, [
    String material = '',
  ]) {
    final deliveryPlan = state.deliveryPlan;
    if (deliveryPlan == null) {
      return [];
    }
    return deliveryPlan.details
        .where((element) => element.material.contains(material.toUpperCase()))
        .toList();
  }
}
