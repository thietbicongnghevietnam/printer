import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

import 'check_material_in_store_controller.dart';
import 'check_material_in_store_state.dart';

@RoutePage()
class CheckMaterialInStorePage extends BasePage<CheckMaterialInStoreController,
    CheckMaterialInStoreState> {
  const CheckMaterialInStorePage({
    super.key,
    this.positionOrRc,
  });

  final String? positionOrRc;

  @override
  CheckMaterialInStoreController buildCubit(BuildContext context) {
    return getIt<CheckMaterialInStoreController>()..positionOrRc = positionOrRc;
  }

  @override
  BasePageState createState() => _CheckMaterialInStorePageState();
}

class _CheckMaterialInStorePageState extends BasePageState<
    CheckMaterialInStoreController, CheckMaterialInStoreState> {
  _CheckMaterialInStorePageState();

  late TextEditingController receivingCardController;

  late FocusNode receivingCardFocusNode;

  late PdaDevice pdaDevice;

  @override
  void initState() {
    receivingCardController = TextEditingController();

    receivingCardFocusNode = FocusNode()..requestFocus();

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) async {
      if (receivingCardFocusNode.hasFocus) {
        await context
            .read<CheckMaterialInStoreController>()
            .scanReceivingCard(data);
      }
    });

    super.initState();
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
        BlocListener<CheckMaterialInStoreController, CheckMaterialInStoreState>(
          listenWhen: (prev, current) {
            return prev.currentReCard != current.currentReCard;
          },
          listener: (context, state) async {
            ScaffoldMessenger.of(context).clearSnackBars();

            if (state.currentReCard != null &&
                state.currentReCard?.material != null &&
                state.currentReCard!.material!.isNotEmpty) {
              await Duration.zero.delay(() async {
                final res = await context.pushRoute(
                  MaterialHistoryTransitionRoute(
                    material: state.currentReCard?.material ?? '',
                    sloc: state.currentReCard?.sloc ?? '',
                  ),
                );

                if (res != null && res is String) {
                  await Duration.zero.delay(() async {
                    cubit.scanReceivingCard(res);
                  });
                }
              });
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.storing_check_material_in_store).tr(),
        ),
        body: _buildBody(cubit),
      ),
    );
  }

  Widget _buildBody(CheckMaterialInStoreController cubit) {
    return BlocBuilder<CheckMaterialInStoreController,
        CheckMaterialInStoreState>(
      buildWhen: (prev, current) {
        return prev.position != current.position ||
            prev.materialList != current.materialList;
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppFormField(
              showCursor: true,
              readOnly: false,
              controller: receivingCardController,
              focusNode: receivingCardFocusNode,
              onChanged: cubit.scanReceivingCard,
              decoration: const InputDecoration(
                hintText: 'Barcode or Location',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(0xff868D95),
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              '${LocaleKeys.storing_position.tr()}: ${state.position}',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (state.materialList.isNotEmpty) ...[
              const SizedBox(height: 8),
              _buildTableTitle(),
              _buildListMaterial(cubit, state),
            ],
          ],
        );
      },
    ).paddingAll(16);
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
              color: Colors.yellow.withOpacity(0.5),
            ),
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
          flex: 4,
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
                'Material',
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
    CheckMaterialInStoreController cubit,
    CheckMaterialInStoreState state,
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
            onTap: () async {

              final res = await context.pushRoute(
                MaterialHistoryTransitionRoute(
                  material: state.materialList[i].material ?? '',
                  sloc: state.materialList[i].sloc ?? '',
                ),
              );

              if (res != null && res is String) {
                await Duration.zero.delay(() async {
                  cubit.scanReceivingCard(res);
                });
              }
            },
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(),
                        bottom: BorderSide(),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(),
                        bottom: BorderSide(),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      left: 2,
                      top: 3,
                      bottom: 3,
                    ),
                    child: Text(
                      state.materialList[i].material ?? '',
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
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
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      left: 2,
                      top: 3,
                      bottom: 3,
                    ),
                    child: Text(
                      '${state.materialList[i].totalCurrentQuantity ?? 0}',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
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
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      left: 2,
                      top: 3,
                      bottom: 3,
                    ),
                    child: Text(
                      formattedDateStore,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
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
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      left: 2,
                      top: 3,
                      bottom: 3,
                    ),
                    child: Text(
                      formattedDateRC,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
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
