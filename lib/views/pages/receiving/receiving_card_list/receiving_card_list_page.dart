import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/views/widgets/app_drop_down.dart';
import 'package:smart_warehouse/views/widgets/receiving_card_widget.dart';

import 'receiving_card_list_controller.dart';
import 'receiving_card_list_state.dart';

@RoutePage()
class ReceivingCardListPage
    extends BasePage<ReceivingCardListController, ReceivingCardListState> {
  const ReceivingCardListPage({
    super.key,
    this.deliveryPlan,
    this.material,
    this.parentId,
  });

  final DeliveryPlan? deliveryPlan;
  final String? material;
  final int? parentId;

  @override
  ReceivingCardListController buildCubit(BuildContext context) {
    return getIt<ReceivingCardListController>()
      ..deliveryPlan = deliveryPlan
      ..material = material
      ..parentId = parentId;
  }

  @override
  BasePageState createState() => _ReceivingCardListPageState();
}

class _ReceivingCardListPageState
    extends BasePageState<ReceivingCardListController, ReceivingCardListState> {
  final PageController _pageController = PageController();
  int _activePage = 0;

  @override
  Widget builder(context, cubit, state) {
    return Scaffold(
      appBar: AppBar(title: const Text('Receiving Card List')),
      body: BlocSelector<ReceivingCardListController, ReceivingCardListState,
          List<ReceivingCard>>(
        selector: (state) => state.receivingCards,
        builder: (context, receivingCards) {
          if (receivingCards.isEmpty) {
            return const Center(
              child: Text('Mã này chưa in Receiving Card'),
            );
          }
          return Column(
            children: [
              SizedBox(
                height: 250,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      _activePage = page;
                    });
                  },
                  itemCount: receivingCards.length,
                  itemBuilder: (context, index) {
                    return ReceivingCardWidget(
                      receivingCard: receivingCards[index],
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              if (receivingCards.length > 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    receivingCards.length,
                    (index) => Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _activePage == index ? Colors.blue : null,
                        border: _activePage == index ? null : Border.all(),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ).withWidgetBetween(const SizedBox(width: 4)),
                ),
              const SizedBox(height: 16),
              AppDropdown(
                hint: 'Chọn máy in',
                displayStringForOption: (option) => option.id,
                options: cubit.state.printerDevices,
                value: cubit.state.selectedPrinterDevice,
                onChange: cubit.changePrinterDevice,
              ),
            ],
          ).paddingAll(16);
        },
      ),
      bottomNavigationBar: Visibility(
        visible: cubit.state.receivingCards.isNotEmpty,
        child: ElevatedButton(
          onPressed: () async {
            await cubit.printReceivingCard(_activePage);
            await Duration.zero.delay(() async {
              getIt<AppAlertDialog>().show(
                context,
                message: LocaleKeys.dialog_print_success.tr(),
              );
            });
          },
          child: const Text('Print Receiving Card'),
        ).paddingSymmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
