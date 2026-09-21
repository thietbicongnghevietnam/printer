import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/enums/in_out_type.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/views/pages/temporary_area/out_receiving_card/out_receiving_card_controller.dart';
import 'package:smart_warehouse/views/pages/temporary_area/out_receiving_card/out_receiving_card_state.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/receiving_card_widget.dart';

class OutOneByOneRC extends StatefulWidget {
  const OutOneByOneRC({super.key});

  @override
  State<OutOneByOneRC> createState() => _OutOneByOneRCState();
}

class _OutOneByOneRCState extends State<OutOneByOneRC> {
  late TextEditingController receivingCardController;
  late FocusNode receivingCardFocusNode;

  @override
  void initState() {
    final rc = context.read<OutReceivingCardController>().state.receivingCard;
    receivingCardController = TextEditingController(text: rc ?? '');
    receivingCardFocusNode = FocusNode()..requestFocus();

    super.initState();
  }

  @override
  void dispose() {
    receivingCardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OutReceivingCardController, OutReceivingCardState>(
      listenWhen: (prev, current) =>
          prev.inOutType != current.inOutType &&
              current.inOutType == InOutType.oneByOne ||
          prev.receivingCard != current.receivingCard,
      listener: (context, state) {
        ScaffoldMessenger.of(context).clearSnackBars();
        receivingCardFocusNode.requestFocus();
        receivingCardController.text = state.receivingCard ?? '';
      },
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 80,
                child: const Text(LocaleKeys.storing_re_card).tr(),
              ),
              Expanded(
                child: AppFormField(
                  showCursor: true,
                  readOnly: true,
                  controller: receivingCardController,
                  focusNode: receivingCardFocusNode,
                  onChanged: context
                      .read<OutReceivingCardController>()
                      .updateReceivingCard,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          BlocSelector<OutReceivingCardController, OutReceivingCardState,
              ReceivingCard?>(
            selector: (state) => state.receivingCards.firstOrNull,
            builder: (context, receivingCard) {
              if (receivingCard == null) {
                return const SizedBox();
              }

              return Column(
                children: [
                  ReceivingCardWidget(receivingCard: receivingCard),
                  const SizedBox(height: 16),
                  if (receivingCard.isNG)
                    const Text(
                      'NG',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
