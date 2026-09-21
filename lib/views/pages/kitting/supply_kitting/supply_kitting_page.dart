import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/kitting/kitting_list.dart';
import 'package:smart_warehouse/enums/kitting_type.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/table_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/pages/kitting/supply_kitting/supply_kitting_controller.dart';
import 'package:smart_warehouse/views/pages/kitting/supply_kitting/supply_kitting_state.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

@RoutePage()
class SupplyKittingPage
    extends BasePage<SupplyKittingController, SupplyKittingState> {
  const SupplyKittingPage({super.key, this.kittingType});

  final KittingType? kittingType;

  @override
  SupplyKittingController buildCubit(BuildContext context) {
    return getIt<SupplyKittingController>()..kittingType = kittingType;
  }

  @override
  BasePageState createState() => _SupplyKittingPageState();
}

class _SupplyKittingPageState
    extends BasePageState<SupplyKittingController, SupplyKittingState> {
  late PdaDevice pdaDevice;
  late TextEditingController _codeController;
  late TextEditingController _lineController;
  late TextEditingController _picController;
  late FocusNode _codeFocusNode;
  late FocusNode _lineFocusNode;
  late FocusNode _picFocusNode;

  @override
  void initState() {
    final controller = context.read<SupplyKittingController>();
    _codeController = TextEditingController();
    _lineController = TextEditingController();
    _picController = TextEditingController();
    _codeFocusNode = FocusNode();
    _lineFocusNode = FocusNode();
    _picFocusNode = FocusNode();
    pdaDevice = getIt<PdaDevice>();

    pdaDevice.listen(context, (data) async {
      if (_codeFocusNode.hasFocus) {
        await controller.scanCode(data);
        _codeController.text = data;
        if (controller.kittingType != KittingType.dip) {
          _lineFocusNode.requestFocus();
        } else {
          _picFocusNode.requestFocus();
        }
      } else if (_lineFocusNode.hasFocus) {
        await controller.scanLine(data);
        _lineController.text = data;
        _picFocusNode.requestFocus();
      } else {
        _picController.text = data;
      }
    });

    super.initState();
  }

  @override
  void handleError(
    BuildContext context,
    Object? error, [
    StackTrace? stackTrace,
  ]) {
    final cubit = context.read<SupplyKittingController>();
    if (error is ServerError) {
      if (error.type == ServerErrorType.supplyNotEnough) {
        getIt<AppAlertDialog>().show(
          context,
          type: AppAlertType.confirm,
          barrierDismissible: true,
          message: 'Kitting List còn thiếu hàng, bạn có muốn supply không?',
          onConfirm: () async {
            await cubit.confirmSupply(isLackSupply: true);
            await loadData(cubit);
          },
        );
        return;
      }
    }
    super.handleError(context, error, stackTrace);
  }

  @override
  Widget builder(
    BuildContext context,
    SupplyKittingController cubit,
    SupplyKittingState state,
  ) {
    return BlocListener<SupplyKittingController, SupplyKittingState>(
      listenWhen: (pre, current) => pre.barcode != current.barcode,
      listener: (context, state) {
        ScaffoldMessenger.of(context).clearSnackBars();
        _codeController.text = state.barcode ?? '';
        _lineController.text = state.line ?? '';
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Supply Kitting')),
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
                    const Text('Scan Code:'),
                    AppFormField(
                      readOnly: true,
                      autoFocus: true,
                      controller: _codeController,
                      focusNode: _codeFocusNode,
                    ),
                  ],
                ),
                if (cubit.kittingType != KittingType.dip)
                  TableRow(
                    children: [
                      const Text('Line:'),
                      AppFormField(
                        readOnly: true,
                        controller: _lineController,
                        focusNode: _lineFocusNode,
                      ),
                    ],
                  ),
                TableRow(
                  children: [
                    const Text('PIC:'),
                    AppFormField(
                      readOnly: true,
                      controller: _picController,
                      focusNode: _picFocusNode,
                    ),
                  ],
                ),
              ].withSpaceBetween(5),
            ).paddingSymmetric(horizontal: 10, vertical: 10),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            if (state.kittingList != null)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.greenAccent.shade100,
                ),
                child: BlocSelector<SupplyKittingController, SupplyKittingState,
                    KittingList?>(
                  selector: (state) => state.kittingList,
                  builder: (context, kittingList) {
                    final dateFormat = kittingList?.createdDate?.toText();
                    return Column(
                      children: [
                        Center(
                          child: Text(
                            getTextKittingTimeType(
                              kittingList?.kittingTimeType ?? '',
                            ),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Text('Category:'),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              '${kittingList?.category}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: const {
                            0: FixedColumnWidth(80),
                            1: FixedColumnWidth(140),
                            2: FixedColumnWidth(60),
                            3: FixedColumnWidth(60),
                          },
                          children: [
                            TableRow(
                              children: [
                                const Text('Model No:'),
                                Text(
                                  '${kittingList?.model}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text('Quantity:'),
                                Text(
                                  '${kittingList?.modelQuantity}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Text('Plant:'),
                                Text(
                                  '${kittingList?.plant}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text('Line:'),
                                Text(
                                  '${kittingList?.line}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Text('Req Date:'),
                                Text(
                                  dateFormat ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text('Time:'),
                                Text(
                                  '${kittingList?.time}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ].withSpaceBetween(10),
                        ),
                      ],
                    ).paddingSymmetric(vertical: 10);
                  },
                ),
              ).paddingSymmetric(horizontal: 20, vertical: 10)
            else
              const SizedBox(
                child: Center(
                  child: Text(
                    'Vui Lòng Quét Kitting List',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
        bottomNavigationBar: ElevatedButton(
          onPressed: () async {
            await cubit.confirmSupply();
            await loadData(cubit);
          },
          child: const Text('Supply'),
        ).paddingSymmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Future<void> loadData(SupplyKittingController cubit) async {
    Duration.zero.delay(() async {
      getIt<AppAlertDialog>().show(
        context,
        message: 'Supply Thành Công!',
        onConfirm: () async {
          await cubit.loadData();
          _codeFocusNode.requestFocus();
        },
      );
    });
  }

  String getTextKittingTimeType(String type) {
    switch (type) {
      case '1':
        return 'One Time';
      case '2':
        return 'Prepare';
      case 'N1':
        return 'N Time';
    }
    return '';
  }
}
