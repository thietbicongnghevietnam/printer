import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';

import 'check_last_lot_controller.dart';
import 'check_last_lot_state.dart';

@RoutePage()
class CheckLastLotPage
    extends BasePage<CheckLastLotController, CheckLastLotState> {
  const CheckLastLotPage({
    super.key,
    required this.blockId,
  });

  final int blockId;

  @override
  BasePageState createState() => _CheckingLastLotPageState(blockId: blockId);
}

class _CheckingLastLotPageState
    extends BasePageState<CheckLastLotController, CheckLastLotState> {
  _CheckingLastLotPageState({
    required this.blockId,
  });

  late ScrollController scrollController;

  final int blockId;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
    context.read<CheckLastLotController>().onLoadData(blockId);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget builder(context, cubit, state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.storing_check_last_lot).tr(),
      ),
      body: _buildBody(cubit),
    );
  }

  Widget _buildBody(CheckLastLotController cubit) {
    return BlocBuilder<CheckLastLotController, CheckLastLotState>(
      buildWhen: (prev, current) =>
          prev.listReceivingCard != current.listReceivingCard ||
          prev.pageStatus != current.pageStatus,
      builder: (context, state) {
        return state.listReceivingCard.isNotEmpty
            ? ListView.separated(
                controller: scrollController,
                itemCount: state.listReceivingCard.length,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _buildReceivingCardItem(
                    barCode: state.listReceivingCard[index].barCode ?? '',
                    currentQuantity:
                        '${state.listReceivingCard[index].currentQuantity ?? ''}',
                    createdDate:
                        state.listReceivingCard[index].createdDate ?? '',
                    updatedDate:
                        state.listReceivingCard[index].updatedDate ?? '',
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 20);
                },
              )
            : const Center(
                child: Text(LocaleKeys.error_do_not_have_data),
              );
      },
    );
  }

  Widget _buildReceivingCardItem({
    required String barCode,
    required String currentQuantity,
    required String createdDate,
    required String updatedDate,
  }) {
    final splitPDAValue = barCode.split(';');
    final material = splitPDAValue[1];
    DateTime createDate = DateTime.parse(createdDate);
    DateTime updateDate = DateTime.parse(updatedDate);
    String createDateFormat =
        DateFormat(DateTimeType.dateFUll2.dateFormat).format(createDate);
    String updateDateFormat =
        DateFormat(DateTimeType.dateFUll2.dateFormat).format(updateDate);
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 0.5,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${LocaleKeys.storing_barcode.tr()}: $barCode'),
            const SizedBox(height: 8),
            Text('${LocaleKeys.storing_material.tr()}: $material'),
            const SizedBox(height: 8),
            Text('${LocaleKeys.storing_current_quantity.tr()}: $currentQuantity')
                .tr(),
            const SizedBox(height: 8),
            Text('${LocaleKeys.storing_store_time.tr()}: $createDateFormat')
                .tr(),
            const SizedBox(height: 8),
            Text('${LocaleKeys.storing_update_time.tr()}: $updateDateFormat')
                .tr(),
          ],
        ));
  }
}
