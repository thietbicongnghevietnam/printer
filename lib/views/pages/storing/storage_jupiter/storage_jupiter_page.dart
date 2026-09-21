import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/enums/storage_scan_recard_error.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/pages/storing/storing_widget/storage_receiving_item.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

import 'storage_jupiter_controller.dart';
import 'storage_jupiter_state.dart';

@RoutePage()
class StorageJupiterPage
    extends BasePage<StorageJupiterController, StorageJupiterState> {
  const StorageJupiterPage({super.key});

  @override
  BasePageState createState() => _StorageJupiterPage();
}

class _StorageJupiterPage
    extends BasePageState<StorageJupiterController, StorageJupiterState> {
  late TextEditingController receivingCardController;
  late ScrollController scrollController;

  late FocusNode receivingCardFocusNode;
  late PdaDevice pdaDevice;

  @override
  void initState() {
    super.initState();

    receivingCardController = TextEditingController();
    scrollController = ScrollController();

    receivingCardFocusNode = FocusNode()..requestFocus();

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) async {
      if (receivingCardFocusNode.hasFocus) {
        context.read<StorageJupiterController>().scanReceivingCard(data);
      }
    });
  }

  @override
  void dispose() {
    receivingCardController.dispose();

    pdaDevice.dispose();
    super.dispose();
  }

  @override
  Widget builder(context, cubit, state) {
    return MultiBlocListener(
      listeners: [
        BlocListener<StorageJupiterController, StorageJupiterState>(
          listenWhen: (prev, current) {
            return prev.listReCard != current.listReCard ||
                prev.currentReCard != current.currentReCard;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();
            receivingCardController.text = state.currentReCard?.barcode ?? '';
          },
        ),
        BlocListener<StorageJupiterController, StorageJupiterState>(
          listenWhen: (prev, current) {
            return prev.storageScanReCardError !=
                current.storageScanReCardError;
          },
          listener: (context, state) {
            if (state.storageScanReCardError != null) {
              switch (state.storageScanReCardError) {
                case StorageScanReCardError.reCardScanned:
                  throw ValidationError(
                      type: ValidationErrorType.receivingCardScanned);
                case StorageScanReCardError.reCardNullTypeFrequency:
                  throw ValidationError(
                      type: ValidationErrorType.reCardNullTypeFrequency);
                case StorageScanReCardError.importSameTypeFrequency:
                  throw ValidationError(
                      type: ValidationErrorType.importSameTypeFrequency);
                case StorageScanReCardError.receivingCardInvalid:
                  throw ValidationError(
                      type: ValidationErrorType.receivingCardInvalid);
                case StorageScanReCardError.receivingCardExistStorage:
                  throw ValidationError(
                      type: ValidationErrorType.receivingCardExistStorage);
                case StorageScanReCardError.plsInputSlocQty:
                  throw ValidationError(
                    type: ValidationErrorType.plsInputSlocQty,
                  );
                case StorageScanReCardError.reCardNullCate:
                  throw ValidationError(
                    type: ValidationErrorType.reCardNullCate,
                  );
                case StorageScanReCardError.rcNotFinishedQC:
                  throw ValidationError(
                    type: ValidationErrorType.rcNotFinishedQC,
                  );
                case null:
                case StorageScanReCardError.outTempRequired:
                case StorageScanReCardError.inTempRequired:
                case StorageScanReCardError.quantityNeedBiggerThanZero:
                // TODO: Handle this case.
              }
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.storing_storing_jupiter).tr(),
        ),
        body: _buildBody(cubit),
        bottomNavigationBar: ElevatedButton(
          child: const Text(LocaleKeys.storing_storing_jupiter).tr(),
          onPressed: () async {
            await cubit.storingJupiter();

            await Duration.zero.delay(() async {
              getIt<AppAlertDialog>().show(
                context,
                message: LocaleKeys.storing_storing_jupiter_success.tr(),
                onConfirm: () {
                  receivingCardController.clear();

                  receivingCardFocusNode.requestFocus();
                },
              );
            });
          },
        ).paddingSymmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildBody(StorageJupiterController cubit) {
    return BlocBuilder<StorageJupiterController, StorageJupiterState>(
      buildWhen: (prev, current) {
        return prev.listReCard != current.listReCard;
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: _buildReCardTextField(cubit),
            ),
            if (state.listReCard.isNotEmpty) ...[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(LocaleKeys.temporary_area_receiving_card_added)
                        .tr(),
                    BlocBuilder<StorageJupiterController, StorageJupiterState>(
                      buildWhen: (prev, current) {
                        return prev.currentReCard != current.currentReCard;
                      },
                      builder: (context, state) {
                        if (state.currentReCard != null &&
                            state.currentReCard?.material != null &&
                            state.currentReCard!.material!.isNotEmpty) {
                          return GestureDetector(
                            onTap: () {
                              context.pushRoute(MaterialSampleRoute(
                                material: state.currentReCard?.material ?? '',
                              ));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1000),
                                border: Border.all(color: Colors.blue),
                              ),
                              child: const Icon(
                                Icons.question_mark_sharp,
                                color: Colors.blue,
                                size: 20,
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
              _buildReCardList(cubit),
            ],
          ],
        );
      },
    );
  }

  Widget _buildReCardTextField(StorageJupiterController cubit) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: const Text(LocaleKeys.temporary_area_re_card).tr(),
        ),
        Expanded(
          child: AppFormField(
            readOnly: true,
            showCursor: true,
            controller: receivingCardController,
            focusNode: receivingCardFocusNode,
            onChanged: cubit.scanReceivingCard,
          ),
        ),
      ],
    );
  }

  Widget _buildReCardList(StorageJupiterController cubit) {
    return BlocBuilder<StorageJupiterController, StorageJupiterState>(
      buildWhen: (prev, current) {
        return prev.listReCard != current.listReCard ||
            prev.currentReCard != current.currentReCard;
      },
      builder: (context, state) {
        return Expanded(
          child: ListView.separated(
            controller: scrollController,
            addRepaintBoundaries: false,
            addAutomaticKeepAlives: false,
            shrinkWrap: true,
            itemCount: state.listReCard.length,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return StorageReceivingItem(
                reCardData: state.listReCard[index],
                onRemoved: () async {
                  final res = await cubit.removeReCard(index);
                  if (res && mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Re-card has been removed'),
                        duration: Duration(
                          milliseconds: 500,
                        ),
                      ),
                    );
                  }
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
}
