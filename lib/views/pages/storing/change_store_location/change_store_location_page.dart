import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/enums/change_location_type.dart';
import 'package:smart_warehouse/enums/change_store_location_error.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/int_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_radio.dart';

import 'change_store_location_controller.dart';
import 'change_store_location_state.dart';

@RoutePage()
class ChangeStoreLocationPage
    extends BasePage<ChangeStoreLocationController, ChangeStoreLocationState> {
  const ChangeStoreLocationPage({super.key});

  @override
  BasePageState createState() => _ChangeStoreLocationPageState();
}

class _ChangeStoreLocationPageState extends BasePageState<
    ChangeStoreLocationController, ChangeStoreLocationState> {
  late TextEditingController receivingCardController;
  late TextEditingController oldOBOController;
  late TextEditingController newOBOController;
  late TextEditingController oldAllController;
  late TextEditingController newAllController;
  late ScrollController scrollController;

  late FocusNode receivingCardFocusNode;
  late FocusNode oldOBOFocusNode;
  late FocusNode newOBOFocusNode;
  late FocusNode oldAllFocusNode;
  late FocusNode newAllFocusNode;

  late PdaDevice pdaDevice;

  @override
  void initState() {
    super.initState();

    receivingCardController = TextEditingController();
    oldOBOController = TextEditingController();
    newOBOController = TextEditingController();
    oldAllController = TextEditingController();
    newAllController = TextEditingController();
    scrollController = ScrollController();

    receivingCardFocusNode = FocusNode()..requestFocus();
    oldOBOFocusNode = FocusNode();
    newOBOFocusNode = FocusNode();
    oldAllFocusNode = FocusNode();
    newAllFocusNode = FocusNode();

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) async {
      if (receivingCardFocusNode.hasFocus) {
        context.read<ChangeStoreLocationController>().addReceivingCard(data);
      } else if (oldOBOFocusNode.hasFocus) {
        context
            .read<ChangeStoreLocationController>()
            .updateOldOBOLocation(data);
      } else if (newOBOFocusNode.hasFocus) {
        context
            .read<ChangeStoreLocationController>()
            .updateNewOBOLocation(data);
      } else if (oldAllFocusNode.hasFocus) {
        context
            .read<ChangeStoreLocationController>()
            .updateOldAllLocation(data);
      } else if (newAllFocusNode.hasFocus) {
        context
            .read<ChangeStoreLocationController>()
            .updateNewAllLocation(data);
      }
    });
  }

  @override
  void dispose() {
    receivingCardController.dispose();
    newOBOController.dispose();
    scrollController.dispose();

    pdaDevice.dispose();
    super.dispose();
  }

  @override
  Widget builder(context, cubit, state) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ChangeStoreLocationController, ChangeStoreLocationState>(
          listenWhen: (prev, current) {
            return prev.changeStoreLocationError !=
                current.changeStoreLocationError;
          },
          listener: (context, state) {
            if (state.changeStoreLocationError != null) {
              Future.delayed(const Duration(milliseconds: 1000), () {
                switch (state.changeStoreLocationError) {
                  case ChangeStoreLocationError.reCardScanned:
                    throw ValidationError(
                        type: ValidationErrorType.receivingCardScanned);
                  case ChangeStoreLocationError.canNotEmpty:
                    throw ValidationError(
                        type: ValidationErrorType.canNotEmpty);
                  case ChangeStoreLocationError.receivingCardInvalid:
                    throw ValidationError(
                        type: ValidationErrorType.receivingCardInvalid);
                  case ChangeStoreLocationError.doNotHaveData:
                    throw ValidationError(
                        type: ValidationErrorType.doNotHaveData);
                  case ChangeStoreLocationError.locationSame:
                    throw ValidationError(
                        type: ValidationErrorType.locationSame);
                  case null:
                }
              });
            }
          },
        ),
        BlocListener<ChangeStoreLocationController, ChangeStoreLocationState>(
          listenWhen: (prev, current) {
            return prev.listReCard != current.listReCard ||
                prev.currentReCard != current.currentReCard;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();
            receivingCardController.text = state.currentReCard ?? '';
            if (state.changeLocationType == ChangeLocationType.oneByOne) {
              oldOBOController.text = state.oldOBOLocation ?? '';
            }
            if (state.listReCard != null && state.listReCard!.isNotEmpty) {
              200.milliseconds.delay(() {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.linear,
                );
              });
            }
          },
        ),
        BlocListener<ChangeStoreLocationController, ChangeStoreLocationState>(
          listenWhen: (prev, current) {
            return prev.newOBOLocation != current.newOBOLocation;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();
            newOBOController.text = state.newOBOLocation ?? '';
          },
        ),
        BlocListener<ChangeStoreLocationController, ChangeStoreLocationState>(
          listenWhen: (prev, current) {
            return prev.oldOBOLocation != current.oldOBOLocation;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();
            oldOBOController.text = state.oldOBOLocation ?? '';
          },
        ),
        BlocListener<ChangeStoreLocationController, ChangeStoreLocationState>(
          listenWhen: (prev, current) {
            return prev.newAllLocation != current.newAllLocation;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();
            newAllController.text = state.newAllLocation ?? '';
          },
        ),
        BlocListener<ChangeStoreLocationController, ChangeStoreLocationState>(
          listenWhen: (prev, current) {
            return prev.oldAllLocation != current.oldAllLocation;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();
            oldAllController.text = state.oldAllLocation ?? '';

            if (oldAllController.text.isNotEmpty) {
              newAllFocusNode.requestFocus();
            }
          },
        ),
        BlocListener<ChangeStoreLocationController, ChangeStoreLocationState>(
          listenWhen: (prev, current) {
            return prev.changeLocationType != current.changeLocationType;
          },
          listener: (context, state) {
            Future.delayed(const Duration(milliseconds: 500), () {
              if (state.changeLocationType == ChangeLocationType.all) {
                oldAllFocusNode.requestFocus();
              } else {
                receivingCardFocusNode.requestFocus();
              }
            });
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.storing_change_store_location).tr(),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        body: _buildBody(cubit),
        bottomNavigationBar: ElevatedButton(
          child: const Text(LocaleKeys.storing_change_store_location).tr(),
          onPressed: () async {
            final res = await cubit.checkDataNewLocation(context);

            if (res) {
              await Duration.zero.delay(() async {
                getIt<AppAlertDialog>().show(
                  context,
                  message: 'Vị trí đã có Receiving Card, vẫn chuyển tới?',
                  type: AppAlertType.confirm,
                  onConfirm: () async {
                    await cubit.changeStoreLocation();

                    await Duration.zero.delay(() async {
                      getIt<AppAlertDialog>().show(
                        context,
                        message: LocaleKeys
                            .storing_change_product_location_success
                            .tr(),
                        onConfirm: () {
                          oldOBOController.text = '';
                          newOBOController.text = '';
                          oldAllController.text = '';
                          newAllController.text = '';
                        },
                      );
                    });
                  },
                );
              });
            } else {
              await cubit.changeStoreLocation();
              await Duration.zero.delay(() async {
                getIt<AppAlertDialog>().show(
                  context,
                  message:
                      LocaleKeys.storing_change_product_location_success.tr(),
                  onConfirm: () {
                    oldOBOController.text = '';
                    newOBOController.text = '';
                    oldAllController.text = '';
                    newAllController.text = '';
                    receivingCardFocusNode.requestFocus();
                  },
                );
              });
            }
          },
        ).paddingSymmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildBody(ChangeStoreLocationController cubit) {
    return BlocBuilder<ChangeStoreLocationController, ChangeStoreLocationState>(
      buildWhen: (prev, current) {
        return prev.listReCard != current.listReCard ||
            prev.changeLocationType != current.changeLocationType;
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRadioButtonChange(cubit),
            const SizedBox(height: 10),
            if (state.changeLocationType == ChangeLocationType.oneByOne) ...[
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: const Text(LocaleKeys.temporary_area_re_card).tr(),
                  ),
                  Expanded(
                    child: AppFormField(
                      readOnly: true,
                      showCursor: true,
                      controller: receivingCardController,
                      focusNode: receivingCardFocusNode,
                      onChanged: cubit.addReceivingCard,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: const Text(LocaleKeys.storing_old_location).tr(),
                  ),
                  BlocBuilder<ChangeStoreLocationController,
                      ChangeStoreLocationState>(
                    buildWhen: (prev, current) {
                      return prev.oldOBOLocation != current.oldOBOLocation;
                    },
                    builder: (context, state) {
                      return Expanded(
                        child: AppFormField(
                          showCursor: true,
                          readOnly: true,
                          enabled: false,
                          controller: oldOBOController,
                          focusNode: oldOBOFocusNode,
                          onChanged: cubit.updateOldOBOLocation,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: const Text(LocaleKeys.storing_new_location).tr(),
                  ),
                  Expanded(
                    child: AppFormField(
                      showCursor: true,
                      readOnly: true,
                      controller: newOBOController,
                      focusNode: newOBOFocusNode,
                      onChanged: cubit.updateNewOBOLocation,
                    ),
                  ),
                ],
              ),
              if (state.listReCard != null && state.listReCard!.isNotEmpty) ...[
                const SizedBox(height: 20),
                const Text(LocaleKeys.temporary_area_receiving_card_added).tr(),
                const SizedBox(height: 15),
                _buildReCardList(cubit),
              ],
            ] else ...[
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: const Text(LocaleKeys.storing_old_location).tr(),
                  ),
                  BlocBuilder<ChangeStoreLocationController,
                      ChangeStoreLocationState>(
                    buildWhen: (prev, current) {
                      return prev.oldAllLocation != current.oldAllLocation;
                    },
                    builder: (context, state) {
                      return Expanded(
                        child: AppFormField(
                          showCursor: true,
                          readOnly: true,
                          controller: oldAllController,
                          focusNode: oldAllFocusNode,
                          onChanged: cubit.updateOldOBOLocation,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: const Text(LocaleKeys.storing_new_location).tr(),
                  ),
                  Expanded(
                    child: AppFormField(
                      showCursor: true,
                      readOnly: true,
                      controller: newAllController,
                      focusNode: newAllFocusNode,
                      onChanged: cubit.updateNewOBOLocation,
                    ),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    ).paddingAll(16);
  }

  Widget _buildRadioButtonChange(ChangeStoreLocationController cubit) {
    return BlocSelector<ChangeStoreLocationController, ChangeStoreLocationState,
        ChangeLocationType>(
      selector: (state) => state.changeLocationType,
      builder: (context, outType) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppRadio(
              title: 'Change one by one',
              value: ChangeLocationType.oneByOne,
              groupValue: outType,
              onChanged: cubit.changeLocationType,
            ),
            AppRadio(
              title: 'Change all',
              value: ChangeLocationType.all,
              groupValue: outType,
              onChanged: cubit.changeLocationType,
            ),
          ],
        );
      },
    );
  }

  Widget _buildReCardList(ChangeStoreLocationController cubit) {
    return BlocBuilder<ChangeStoreLocationController, ChangeStoreLocationState>(
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
            itemCount: state.listReCard!.length,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildReLocationItem(
                reCardMaterial: state.listReCard![index].barCode ?? '',
                currentQty: state.listReCard![index].currentQuantity,
                oldLocation: state.listReCard![index].oldLocation,
                onRemoved: () async {
                  final res = await cubit.removeReCard(index);
                  if (res && mounted) {
                    await Duration.zero.delay(() async {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Re-card has been removed'),
                          duration: Duration(milliseconds: 500),
                        ),
                      );
                    });
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

  Widget _buildReLocationItem({
    String? reCardMaterial,
    String? oldLocation,
    int? currentQty,
    required Function onRemoved,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      LocaleKeys.storing_material,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ).tr(),
                    Expanded(
                      child: Text(
                        ': $reCardMaterial' ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text(
                      LocaleKeys.storing_current_qty,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ).tr(),
                    Expanded(
                      child: Text(
                        ': $currentQty' ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text(
                      LocaleKeys.storing_old_location,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ).tr(),
                    Expanded(
                      child: Text(
                        ': $oldLocation' ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          IconButton(
            onPressed: () {
              onRemoved.call();
            },
            icon: const Icon(
              Icons.highlight_remove_outlined,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
