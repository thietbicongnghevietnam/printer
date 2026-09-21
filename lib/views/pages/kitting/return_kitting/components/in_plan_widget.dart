import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smart_warehouse/entities/kitting/kitting_card.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/views/dialogs/view_kitting_card_dialog.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

import '../return_kitting_controller.dart';
import '../return_kitting_state.dart';

class InPlanWidget extends StatefulWidget {
  const InPlanWidget({super.key});

  @override
  State<InPlanWidget> createState() => _InPlanWidgetState();
}

class _InPlanWidgetState extends State<InPlanWidget> {
  late TextEditingController _codeController;

  @override
  void initState() {
    _codeController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReturnKittingController>();
    return BlocListener<ReturnKittingController, ReturnKittingState>(
      listenWhen: (preState, state) => preState.material != state.material,
      listener: (context, state) {
        _codeController.text = state.material ?? '';
      },
      child: Column(
        children: [
          Row(
            children: [
              AppText.title('Kitting Card:'),
              const SizedBox(width: 8),
              Expanded(
                child: AppFormField(
                  readOnly: true,
                  autoFocus: true,
                  controller: _codeController,
                  onClear: () => cubit.clearData(),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 10, vertical: 8),
          const Divider(),
          Expanded(
            child: BlocSelector<ReturnKittingController,
                ReturnKittingState,
                List<KittingCard>>(
              selector: (state) => state.kittingCards,
              builder: (context, kittingCards) {
                if (kittingCards.isEmpty) {
                  return AppText.header('Vui lòng quét Kitting Card');
                }

                return Column(
                  children: [
                    AppText.header('Danh sách Kitting Card'),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 8,
                        ),
                        itemCount: kittingCards.length,
                        itemBuilder: (context, index) {
                          final kittingCard = kittingCards[index];
                          final quantity = kittingCard.quantity?.toInt() ?? 0;
                          final qtyTotal = kittingCard.qtyTotal?.toInt() ?? 0;
                          return Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) =>
                                      cubit.deleteKittingCard(kittingCard),
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Xóa',
                                ),
                              ],
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                onTap: () {
                                  viewKittingCardDialog(
                                    context,
                                    kittingCards: [kittingCard],
                                  );
                                },
                                minLeadingWidth: 0,
                                horizontalTitleGap: 8,
                                leading: Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Text(
                                    '#${kittingCard.id}',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                title:
                                Text('Material: ${kittingCard.material}'),
                                subtitle: Text(
                                  'Date: ${kittingCard.kittingDate
                                      ?.toText()} ${kittingCard.kittingHour ??
                                      ''}',
                                ),
                                trailing: Text(
                                  quantity == qtyTotal
                                      ? qtyTotal.toString()
                                      : '$quantity/$qtyTotal',
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
