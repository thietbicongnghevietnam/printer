import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/e_map/order_block.dart';
import 'package:smart_warehouse/entities/e_map/suggest_path.dart';
import 'package:smart_warehouse/entities/kitting/kitting_detail.dart';
import 'package:smart_warehouse/entities/storage_card.dart';
import 'package:smart_warehouse/enums/kitting_time_type.dart';
import 'package:smart_warehouse/enums/kitting_type.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/int_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/dialogs/list_barcode_kitting_dialog.dart';
import 'package:smart_warehouse/views/pages/kitting/kitting/components/kitting_filter_drawer.dart';
import 'package:smart_warehouse/views/pages/kitting/kitting/components/list_kitting_detail_widget.dart';
import 'package:smart_warehouse/views/pages/kitting/kitting/components/list_kitting_filter_widget.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/kitting_card_dialog.dart';

import 'kitting_controller.dart';
import 'kitting_state.dart';

@RoutePage()
class KittingPage extends BasePage<KittingController, KittingState> {
  const KittingPage({super.key, this.kittingType});

  final KittingType? kittingType;

  @override
  KittingController buildCubit(BuildContext context) {
    return getIt<KittingController>()..kittingType = kittingType;
  }

  @override
  BasePageState createState() => _KittingPageState();
}

class _KittingPageState extends BasePageState<KittingController, KittingState> {
  KittingTimeType kittingTimeType = KittingTimeType.total;
  late TextEditingController _materialController;
  late TextEditingController _BlockController;

  bool isBlock(String code) {
    final arr = code.split('.');

    // Tuấn Anh sửa
    //return arr.length == 4;
    return arr.length == 4 && code.length < 15;
  }

  @override
  void initState() {
    final cubit = context.read<KittingController>();

    _materialController = TextEditingController();
    _BlockController = TextEditingController();
    getIt<PdaDevice>().listen(context, (data) {
      if (isBlock(data)) {
        //Tuấn Anh sửa
        cubit.updateFilter(cubit.state.kittingFilter.copyWith(location: data));
        //cubit.UpdateBlock(data);
        //_BlockController.text = data;
      } else {
        cubit.scanCard(data);
      }
    });
    super.initState();
  }

  @override
  void handleError(BuildContext context, Object? error,
      [StackTrace? stackTrace]) {
    final cubit = context.read<KittingController>();
    if (error is ValidationError &&
        error.type == ValidationErrorType.firstLotRequired) {
      getIt<AppAlertDialog>().show(
        context,
        type: AppAlertType.confirm,
        message: error.message,
        barrierDismissible: true,
        onConfirm: () {
          cubit.scanCard(cubit.savedBarcode ?? '', skipCheckFirstLot: true);
        },
      );
    } else {
      super.handleError(context, error, stackTrace);
    }
  }

  @override
  Widget builder(context, cubit, state) {
    return BlocListener<KittingController, KittingState>(
      listenWhen: (pre, state) => pre.scanningItem != state.scanningItem,
      listener: (context, state) {
        _materialController.text = state.scanningItem?.material ?? '';
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Kitting ${cubit.kittingType?.text ?? 'FA'}'),
          actions: [
            BlocSelector<KittingController, KittingState,
                (List<KittingDetail>, List<OrderBlock>, List<SuggestPath>)>(
              selector: (state) =>
                  (state.kittingDetails, state.orderBlocks, state.suggestPaths),
              builder: (context, data) {
                return IconButton(
                  icon: const Icon(Icons.map_outlined),
                  onPressed: () {
                    context.pushRoute(
                      EmapKittingRoute(
                        listKittingDetails: data.$1,
                        selectedLocations: const [],
                        orderBlocks: data.$2,
                        suggestPaths: data.$3,
                      ),
                    );
                  },
                );
              },
            ),
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                );
              },
            ),
          ],
        ),
        endDrawer: const KittingFilterDrawer(),
        body: Column(
          children: [
            const SizedBox(height: 8),
            //Tuấn Anh thêm
            // Row(
            //   children: [
            //     const Text('Block:'),
            //     const SizedBox(width: 5),
            //     Expanded(
            //       child: AppFormField(
            //         readOnly: true,
            //         autoFocus: true,
            //         controller: _BlockController,
            //         onClear: () => cubit.clearData(),
            //       ),
            //     ),
            //
            //   ],
            // ),
            // const SizedBox(height: 8),
            Row(
              children: [
                const Text('Mã: '),
                const SizedBox(width: 16),
                Expanded(
                  child: AppFormField(
                    readOnly: true,
                    autoFocus: true,
                    controller: _materialController,
                    onClear: () => cubit.clearData(),
                    onTap: () => cubit.updateSelectedKittingDetails([]),
                  ),
                ),
                BlocSelector<KittingController, KittingState,
                    List<StorageCard>>(
                  selector: (state) => state.kittingBoxScanned,
                  builder: (context, kittingBoxScanned) {
                    return IconButton(
                      onPressed: () {
                        if (kittingBoxScanned.isEmpty) {
                          getIt<AppAlertDialog>()
                              .show(context, message: 'Vui lòng quét Barcode');
                        } else {
                          showListBarcodeKittingDialog(
                            context,
                            kittingScannedList: kittingBoxScanned,
                            onUpdate: (item) => cubit.updateCard(item),
                            onDelete: (item) => cubit.deleteCard(item),
                          );
                        }
                      },
                      icon: Badge(
                        offset: const Offset(8, -4),
                        isLabelVisible: kittingBoxScanned.isNotEmpty,
                        label: Text(kittingBoxScanned.length.toString()),
                        child: const Icon(Icons.format_list_bulleted),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),



            BlocBuilder<KittingController, KittingState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text.rich(
                        TextSpan(
                          text: 'Đã Kitting: ',
                          children: [
                            TextSpan(
                              text: '${cubit.pickedItem}/${cubit.totalItem}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (state.scanningItem != null)
                      Expanded(
                        flex: 3,
                        child: Text.rich(
                          TextSpan(
                            text: 'Đã Quét: ',
                            children: [
                              TextSpan(
                                text:
                                    '${cubit.pickedQuantity}/${cubit.totalQuantity}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: cubit.pickedQuantity >=
                                          cubit.totalQuantity
                                      ? Colors.green
                                      : Colors.black,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' (${cubit.pickedQuantity - cubit.totalQuantity})',
                                style: const TextStyle(color: Colors.orange),
                              )
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            const ListKittingFilterWidget(),
            Expanded(
              child: BlocSelector<KittingController, KittingState,
                  (List<KittingDetail>, StorageCard?)>(
                selector: (state) => (state.kittingDetails, state.scanningItem),
                builder: (context, data) {
                  return ListKittingDetailWidget(
                    kittingDetails: cubit.getKittingDetailFilter(),
                    scanningCard: data.$2,
                  );
                },
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
        bottomNavigationBar: ElevatedButton(
          onPressed: () async {
            if (cubit.state.scanningItem == null) {
              getIt<AppAlertDialog>()
                  .show(context, message: 'Vui lòng quét barcode');
              return;
            }

            final selectedKittingDetails = cubit.state.selectedKittingDetails
                .map(
                  (e) => state.kittingDetails
                      .firstWhere((element) => element.id == e),
                )
                .toList();

            final kittingDetails = selectedKittingDetails.isNotEmpty
                ? selectedKittingDetails
                : cubit.getKittingDetailFilter();
            final kittingCards = await cubit.createKittingCard(
              kittingDetails: kittingDetails,
              isPreview: true,
            );

            0.seconds.delay(() {
              if (cubit.state.kittingFilter.isSub) {
                getIt<AppAlertDialog>().show(
                  context,
                  barrierDismissible: true,
                  message: 'Xác nhận chuyển hàng lên sản xuất',
                  confirmText: 'Xác nhận',
                  onConfirm: () async {
                    await cubit.createKittingCard(
                      kittingDetails: kittingDetails,
                    );
                    0.seconds.delay(() {
                      getIt<AppAlertDialog>().show(
                        context,
                        message: 'Kitting thành công',
                        onConfirm: () {
                          cubit.clearData();
                          200.milliseconds.delay(() {
                            cubit.loadKittingListItems();
                          });
                        },
                      );
                    });
                  },
                );
              } else {
                createKittingCardDialog(
                  context,
                  kittingCards: kittingCards,
                  onConfirm: (printerDevice, kittingCard) async {
                    await cubit.confirmCreateKittingCard(
                      kittingDetails: kittingDetails,
                      printerDevice: printerDevice,
                    );
                    0.seconds.delay(() {
                      getIt<AppAlertDialog>().show(
                        context,
                        message: 'In Kitting Cards thành công',
                        onConfirm: () {
                          cubit.clearData();
                          200.milliseconds.delay(() {
                            cubit.loadKittingListItems();
                          });
                        },
                      );
                    });
                  },
                  printerDevices: cubit.printerDevices ?? [],
                  previousPrinterDevice: cubit.savedPrinterDevice,
                );
              }
            });
          },
          child: const Text('Tạo Kitting Card'),
        ).paddingSymmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
