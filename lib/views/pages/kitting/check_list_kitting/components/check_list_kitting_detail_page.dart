import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/kitting/kitting_detail.dart';
import 'package:smart_warehouse/enums/kitting_time_type.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/int_extensions.dart';
import 'package:smart_warehouse/shared/extensions/table_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/pages/kitting/check_list_kitting/components/check_list_kitting_detail_controller.dart';
import 'package:smart_warehouse/views/pages/kitting/check_list_kitting/components/check_list_kitting_detail_state.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

@RoutePage()
class CheckListKittingDetailPage extends BasePage<
    CheckListKittingDetailController, CheckListKittingDetailState> {
  const CheckListKittingDetailPage({super.key});

  @override
  BasePageState createState() => _CheckListKittingDetailPageState();
}

class _CheckListKittingDetailPageState extends BasePageState<
    CheckListKittingDetailController, CheckListKittingDetailState> {
  late TextEditingController _kittingCardCodeController;
  late TextEditingController _kittingListCodeController;
  late FocusNode _kittingCardFocusNode;
  late FocusNode _kittingListFocusNode;
  final List<PlutoRow> rows = [];
  late List<PlutoColumn> columns = [];
  late PdaDevice pdaDevice;

  late PlutoGridStateManager stateManager;

  @override
  void initState() {
    initColumn();
    final controller = context.read<CheckListKittingDetailController>();
    pdaDevice = getIt<PdaDevice>();
    _kittingCardCodeController = TextEditingController();
    _kittingListCodeController = TextEditingController();
    _kittingCardFocusNode = FocusNode();
    _kittingListFocusNode = FocusNode()..requestFocus();

    pdaDevice.listen(context, (data) {
      if (_kittingListFocusNode.hasFocus) {
        controller.scanKittingList(data);
        _kittingListCodeController.text = data;
        _kittingCardFocusNode.requestFocus();
      } else if (_kittingCardFocusNode.hasFocus) {
        controller.scanKittingCard(data, stateManager);
        _kittingCardCodeController.text = data;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _kittingCardCodeController.dispose();
    _kittingListCodeController.dispose();
    _kittingCardFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget builder(
    BuildContext context,
    CheckListKittingDetailController cubit,
    CheckListKittingDetailState state,
  ) {
    return BlocListener<CheckListKittingDetailController,
        CheckListKittingDetailState>(
      listenWhen: (current, pre) =>
          current.kittingDetails != pre.kittingDetails,
      listener: (context, state) {
        _kittingListCodeController.text = state.barcodeKittingList ?? '';
        cubit.createPlutoRow(state.kittingDetails, stateManager);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Check Kitting List Detail',
          ),
        ),
        body: Column(
          children: [
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FixedColumnWidth(100),
                1: FlexColumnWidth(),
              },
              children: [
                TableRow(
                  children: [
                    const Text('Kitting List:'),
                    AppFormField(
                      readOnly: true,
                      showCursor: true,
                      controller: _kittingListCodeController,
                      focusNode: _kittingListFocusNode,
                      onClear: () {
                        cubit.clearData();
                        stateManager.removeAllRows();
                      },
                    ),
                  ],
                ),
                TableRow(children: [
                  const Text('Kitting Card:'),
                  AppFormField(
                    readOnly: true,
                    showCursor: true,
                    showClear: false,
                    controller: _kittingCardCodeController,
                    focusNode: _kittingCardFocusNode,
                  ),
                ])
              ].withSpaceBetween(20),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: PlutoGrid(
                mode: PlutoGridMode.readOnly,
                columns: columns,
                rows: rows,
                onLoaded: (event) {
                  stateManager = event.stateManager;
                  cubit.initDataPluto(stateManager);
                },
                rowColorCallback: (rowColorContext) {
                  return cubit.setColorForPlutoRow(rowColorContext);
                },
              ),
            )
            // if (state.kittingList != null)
            //
            // else
            //   const SizedBox(
            //     child: Center(
            //       child: Text(
            //         'Vui Lòng Quét Kitting List',
            //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //   ),
          ],
        ).paddingSymmetric(horizontal: 8, vertical: 8),
      ),
    );
  }

  void initColumn() {
    columns = [
      PlutoColumn(
        title: 'Part',
        field: Constants.kPartFieldKey,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
      ),
      PlutoColumn(
        title: 'Quantity',
        field: Constants.kQuantityFieldKey,
        type: PlutoColumnType.number(),
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        width: 80,
      ),
      PlutoColumn(
        title: 'PickedQuantity',
        field: Constants.kPickedQuantityFieldKey,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        width: 80,
      ),
      PlutoColumn(
        title: 'Model',
        field: Constants.kModelFieldKey,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
      ),
      PlutoColumn(
        title: 'Location',
        field: Constants.kLocationFieldKey,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        width: 140,
      ),
      PlutoColumn(
        title: 'Time',
        field: Constants.kTimeFieldKey,
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        width: 80,
      ),
      // PlutoColumn(
      //   title: 'Status',
      //   field: Constants.kKittingStatusFieldKey,
      //   type: PlutoColumnType.text(),
      //   enableContextMenu: false,
      //   enableDropToResize: false,
      //   enableColumnDrag: false,
      //   width: 40,
      // ),
    ];
  }

  String getKittingTimeType(String type) {
    switch (type) {
      case '1':
        return KittingTimeType.oneTime.name.toUpperCase();
      case '2':
        return KittingTimeType.prepare.name.toUpperCase();
      case 'N1':
        return KittingTimeType.nTime.name.toUpperCase();
    }
    return '';
  }
}
