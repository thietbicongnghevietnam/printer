import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';

import 'check_block_data_controller.dart';
import 'check_block_data_state.dart';

@RoutePage()
class CheckBlockDataPage
    extends BasePage<CheckBlockDataController, CheckBlockDataState> {
  const CheckBlockDataPage({
    super.key,
    required this.blockName,
  });

  final String? blockName;

  @override
  BasePageState createState() => _CheckingBlockDataPageState();
}

class _CheckingBlockDataPageState
    extends BasePageState<CheckBlockDataController, CheckBlockDataState> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
    context.read<CheckBlockDataController>().onLoadData(widget.as<CheckBlockDataPage>()?.blockName ?? '');
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
        title: Text('${LocaleKeys.storing_check_block_data.tr()}: ${widget.as<CheckBlockDataPage>()?.blockName}'),
      ),
      body: _buildBody(cubit),
    );
  }

  Widget _buildBody(CheckBlockDataController cubit) {
    return BlocBuilder<CheckBlockDataController, CheckBlockDataState>(
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
            : Center(
                child: const Text(LocaleKeys.error_do_not_have_data).tr(),
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
