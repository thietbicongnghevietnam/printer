import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/views/pages/kitting/components/barcode_scanned_controller.dart';
import 'package:smart_warehouse/views/pages/kitting/components/barcode_scanned_state.dart';

typedef RemoveReceivingCardCallBack = void Function(
  ReceivingCard? receivingCard,
);

typedef RemovePartCardCallBack = void Function(
  ReceivingCardItem? partCard,
);

typedef BackToScreen = void Function(
    );

@RoutePage()
class BarCodeScannedPage
    extends BasePage<BarcodeScannedController, BarcodeScannedState> {
  const BarCodeScannedPage(
      {required this.removeReceivingCardCallBack,
        required  this.backToScreen,
      required this.removePartCardCallBack,
      this.receivingCards,
      this.receivingCardItems,
      super.key,});

  final List<ReceivingCard>? receivingCards;
  final List<ReceivingCardItem>? receivingCardItems;
  final RemoveReceivingCardCallBack removeReceivingCardCallBack;
  final RemovePartCardCallBack removePartCardCallBack;
  final BackToScreen backToScreen;

  @override
  BasePageState createState() => _BarCodeScannedPageState();
}

class _BarCodeScannedPageState
    extends BasePageState<BarcodeScannedController, BarcodeScannedState> {
  @override
  void initState() {
    final controller = context.read<BarcodeScannedController>();
    final receivingCards = widget.as<BarCodeScannedPage>()?.receivingCards;
    final receivingCardItems =
        widget.as<BarCodeScannedPage>()?.receivingCardItems;
    controller.loadData(receivingCards, receivingCardItems);
    super.initState();
  }
  @override
  Widget builder(
    BuildContext context,
    BarcodeScannedController cubit,
    BarcodeScannedState state,
  ) {

    return Scaffold(
      appBar: AppBar(
        title: Text('BarCode da quet'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.maybePop();
            widget.as<BarCodeScannedPage>()?.backToScreen();
          },
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('ReceivingCard'),
          BlocBuilder<BarcodeScannedController, BarcodeScannedState>(
            buildWhen: (pre, current) => pre.receivingCards != current.receivingCards,
            builder: (context, state) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.receivingCards?.length,
                  itemBuilder: (context, index) {
                    final item = state.receivingCards?[index];
                    return ListTile(
                      title: Text('Material: ${item?.material}'),
                      subtitle: Text('Qty: ${item?.currentQuantity}'),
                      trailing: IconButton(
                        onPressed: () async {
                          await cubit.updateListReceivingCard(item);
                          widget.as<BarCodeScannedPage>()?.removeReceivingCardCallBack(item);
                        },
                        icon: const Icon(Icons.delete_forever),
                      ),
                    );
                  },
                  shrinkWrap: true,
                ),
              );
            },
          ),
          const Divider(),
          const Text('PartCard'),
          BlocBuilder<BarcodeScannedController, BarcodeScannedState>(
            buildWhen: (pre, current) => pre.receivingCardItems != current.receivingCardItems,
            builder: (context, state) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.receivingCardItems?.length,
                  itemBuilder: (context, index) {
                    final item = state.receivingCardItems?[index];
                    return ListTile(
                      title: Text('Material: ${item?.material}'),
                      subtitle: Text('Qty: ${item?.currentQuantity}'),
                      trailing: IconButton(
                        onPressed: () async {
                          await cubit.updateListPartCard(item);
                          widget.as<BarCodeScannedPage>()?.removePartCardCallBack(item);
                        },
                        icon: const Icon(Icons.delete_forever),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
