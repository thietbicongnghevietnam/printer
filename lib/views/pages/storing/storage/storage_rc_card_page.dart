import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/enums/storage_scan_recard_error.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/int_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/pages/storing/storing_widget/storage_receiving_item.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

import 'storage_rc_card_controller.dart';
import 'storage_rc_card_state.dart';

@RoutePage()
class StorageRCCardPage
    extends BasePage<StorageRCCardController, StorageRCCardState> {
  const StorageRCCardPage({
    super.key,
    this.rcBarcode,
  });

  final String? rcBarcode;

  @override
  BasePageState createState() => _StorageProductPageState();
}

class _StorageProductPageState
    extends BasePageState<StorageRCCardController, StorageRCCardState> {
  late TextEditingController receivingCardController;
  late TextEditingController locationController;
  late ScrollController scrollController;

  late FocusNode receivingCardFocusNode;
  late FocusNode locationFocusNode;
  late PdaDevice pdaDevice;

  @override
  void initState() {
    super.initState();

    receivingCardController = TextEditingController();
    locationController = TextEditingController();
    scrollController = ScrollController();

    receivingCardFocusNode = FocusNode()..requestFocus();
    locationFocusNode = FocusNode();

    final rc = (widget as StorageRCCardPage).rcBarcode;
    if (rc != null) {
      1.seconds.delay(() {
        context.read<StorageRCCardController>().scanReceivingCard(rc);
      });
    }

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) async {
      if (receivingCardFocusNode.hasFocus) {
        context.read<StorageRCCardController>().scanReceivingCard(data);
      } else if (locationFocusNode.hasFocus) {
        context.read<StorageRCCardController>().updateLocation(data);
      }
    });
  }

  @override
  void dispose() {
    receivingCardController.dispose();
    locationController.dispose();
    scrollController.dispose();

    pdaDevice.dispose();
    super.dispose();
  }

  @override
  Widget builder(context, cubit, state) {
    return MultiBlocListener(
      listeners: [
        BlocListener<StorageRCCardController, StorageRCCardState>(
          listenWhen: (prev, current) {
            return prev.listReCard != current.listReCard ||
                prev.currentReCard != current.currentReCard;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();
            receivingCardController.text = state.currentReCard?.barcode ?? '';
            locationFocusNode.requestFocus();
          },
        ),
        BlocListener<StorageRCCardController, StorageRCCardState>(
          listenWhen: (prev, current) {
            return prev.location != current.location;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();
            locationController.text = state.location ?? '';
          },
        ),
        BlocListener<StorageRCCardController, StorageRCCardState>(
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
                case null:
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
                case StorageScanReCardError.outTempRequired:
                  throw ValidationError(
                    type: ValidationErrorType.outTempRequired,
                  );
                case StorageScanReCardError.inTempRequired:
                  throw ValidationError(
                    type: ValidationErrorType.inTempRequired,
                  );
                case StorageScanReCardError.quantityNeedBiggerThanZero:
                  throw ValidationError(
                    type: ValidationErrorType.quantityNeedBiggerThanZero,
                  );
              }
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.storing_storing_receiving).tr(),
        ),
        body: _buildBody(cubit),
        bottomNavigationBar: ElevatedButton(
          child: const Text(LocaleKeys.storing_storing_receiving).tr(),
          onPressed: () async {
            await cubit.storingReceivingCard();

            await Duration.zero.delay(() async {
              getIt<AppAlertDialog>().show(
                context,
                message: LocaleKeys.storing_storing_product_success.tr(),
                onConfirm: () {
                  locationController.clear();
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

  Widget _buildBody(StorageRCCardController cubit) {
    return BlocBuilder<StorageRCCardController, StorageRCCardState>(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: _buildLocationTextField(cubit),
            ),
            if (state.listReCard.isNotEmpty) ...[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(LocaleKeys.temporary_area_receiving_card_added)
                        .tr(),
                    BlocBuilder<StorageRCCardController, StorageRCCardState>(
                      buildWhen: (prev, current) {
                        return prev.currentReCard != current.currentReCard;
                      },
                      builder: (context, state) {
                        if (state.currentReCard != null &&
                            state.currentReCard?.material != null &&
                            state.currentReCard!.material!.isNotEmpty) {
                          return GestureDetector(
                            onTap: () {
                              context.pushRoute(
                                MaterialSampleRoute(
                                  material: state.currentReCard?.material ?? '',
                                ),
                              );
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
//Tuấn Anh
  Widget _buildReCardTextField(StorageRCCardController cubit) {
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

  Widget _buildLocationTextField(StorageRCCardController cubit) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: const Text(LocaleKeys.storing_location).tr(),
        ),
        Flexible(
          flex: 2,
          child: AppFormField(
            showCursor: true,
            readOnly: true,
            controller: locationController,
            focusNode: locationFocusNode,
            onChanged: (value) {
              cubit.updateLocation(value);
            },
          ),
        ),
        const SizedBox(width: 10),
        BlocBuilder<StorageRCCardController, StorageRCCardState>(
          buildWhen: (prev, current) => prev.listReCard != current.listReCard,
          builder: (context, state) {
            return state.listReCard.length >= 2
                ? ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Assets.images.icFindLocation.image(
                      width: 50,
                      height: 50,
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      cubit.checkNavigate(context);
                    },
                    child: Assets.images.icFindLocation.image(
                      width: 50,
                      height: 50,
                    ),
                  );
          },
        ),
      ],
    );
  }

  Widget _buildReCardList(StorageRCCardController cubit) {
    return BlocBuilder<StorageRCCardController, StorageRCCardState>(
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
                        duration: Duration(milliseconds: 500),
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
