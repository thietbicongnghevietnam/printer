import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/enums/in_out_type.dart';
import 'package:smart_warehouse/views/dialogs/view_receiving_card_dialog.dart';
import 'package:smart_warehouse/views/pages/temporary_area/out_receiving_card/out_receiving_card_controller.dart';
import 'package:smart_warehouse/views/pages/temporary_area/out_receiving_card/out_receiving_card_state.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

class OutPallet extends StatefulWidget {
  const OutPallet({super.key});

  @override
  State<OutPallet> createState() => _OutPalletState();
}

class _OutPalletState extends State<OutPallet> {
  late TextEditingController palletController;
  late FocusNode palletFocusNode;

  @override
  void initState() {
    final pallet = context.read<OutReceivingCardController>().state.pallet;
    palletController = TextEditingController(text: pallet);
    palletFocusNode = FocusNode()..requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    palletController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OutReceivingCardController, OutReceivingCardState>(
      listenWhen: (prev, current) =>
          prev.inOutType != current.inOutType &&
              current.inOutType == InOutType.oneByOne ||
          prev.pallet != current.pallet,
      listener: (context, state) {
        ScaffoldMessenger.of(context).clearSnackBars();
        palletFocusNode.requestFocus();
        palletController.text = state.pallet ?? '';
      },
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 80, child: Text('Pallet')),
              Expanded(
                child: AppFormField(
                  showCursor: true,
                  readOnly: true,
                  controller: palletController,
                  focusNode: palletFocusNode,
                  onChanged:
                      context.read<OutReceivingCardController>().updatePallet,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocSelector<OutReceivingCardController,
                OutReceivingCardState, List<ReceivingCard>>(
              selector: (state) => state.receivingCards,
              builder: (context, receivingCards) {
                return ListView.separated(
                  itemCount: receivingCards.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final rc = receivingCards[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: rc.isNG
                            ? Colors.redAccent.withOpacity(0.75)
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(2, 0),
                          ),
                        ],
                      ),
                      child: ListTile(
                        dense: true,
                        onTap: () {
                          showViewReceivingCardDialog(
                            context,
                            receivingCard: rc,
                          );
                        },
                        titleTextStyle: rc.isNG
                            ? const TextStyle(color: Colors.white)
                            : null,
                        title: Text(rc.material),
                        trailing: Visibility(
                          visible: rc.isNG,
                          child: const Text(
                            'NG',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
