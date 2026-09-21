import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/enums/receving_card_type.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

class ReceivingCardWidget extends StatelessWidget {
  const ReceivingCardWidget({
    super.key,
    required this.receivingCard,
    // this.rcType = ReceivingCardType.receivingCard,
  });

  final ReceivingCard receivingCard;

  // final ReceivingCardType rcType;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: rootBundle.loadString(Assets.html.receiveCard),
      builder: (context, snapshot) {
        final rcType = receivingCard.rcType;
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return HtmlWidget(
          snapshot.data ?? '',
          rebuildTriggers: [
            receivingCard.totalQuantity,
            receivingCard.receivingCardDate,
            receivingCard.samplingCheck,
            receivingCard.rohsCheck,
          ],
          customStylesBuilder: (element) {
            switch (element.localName) {
              case 'table':
                return {
                  'border': '1px solid black',
                  'border-collapse': 'collapse',
                };
              case 'td':
                return {
                  'border': '1px solid black',
                  'border-collapse': 'collapse',
                  'padding': '2px 4px',
                };
            }
            return null;
          },
          customWidgetBuilder: (element) {
            return switch (element.id) {
              'rc_title' => Text(rcType.text),
              'rc_time' => Text(receivingCard.receivingCardTime ?? ''),
              'rc_barcode' =>
                Assets.images.qrSample.image(width: 32, height: 32),
              'rc_plant' => AppText.title(receivingCard.plant ?? ''),
              'rc_date' => AppText(
                  receivingCard.receivingCardDate?.toText() ?? '',
                  style: const TextStyle(fontSize: 9),
                ),
              'rc_urgent' => AppText.title(
                  receivingCard.urgent ?? '',
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontSize: 9),
                ),
              'rc_ul_coc' => AppText.title(receivingCard.ulcoc ?? ''),
              'rc_material' => AppText.title(
                  receivingCard.material,
                  style: const TextStyle(fontSize: 12),
                ),
              'rc_type' => Text((receivingCard.materialType ?? '') +
                  (receivingCard.items.isNotEmpty ? ' - Box' : '')),
              'rc_frequency' => Text(receivingCard.materialFrequency ?? ''),
              'rc_sloc' => Text(
                  '${receivingCard.sloc} ${receivingCard.category != null ? ' - ${receivingCard.category}' : ''}',
                ),
              'rc_sample' => rcType == ReceivingCardPrinterType.reCheckCard ||
                      receivingCard.samplingCheck
                  ? const SizedBox()
                  : const Text('/'),
              'rc_rohs' => receivingCard.rohsCheck &&
                      rcType != ReceivingCardPrinterType.reCheckCard
                  ? const SizedBox()
                  : const Text('/'),
              'rc_code_date' => const Text(''),
              'rc_quantity' => Text(
                  rcType == ReceivingCardPrinterType.rcConvert
                      ? (receivingCard.currentQuantity != 0
                          ? '${receivingCard.currentQuantity} / ${receivingCard.totalQuantity}'
                          : '${receivingCard.totalQuantity}')
                      : rcType == ReceivingCardPrinterType.reCheckCard ||
                              rcType == ReceivingCardPrinterType.revertKitting
                          ? (receivingCard.currentQuantity != 0
                              ? '${receivingCard.currentQuantity} / ${receivingCard.currentQuantity}'
                              : '0')
                          : '${receivingCard.currentQuantity} ${receivingCard.qtyDAInv != null ? ' / ${receivingCard.qtyDAInv}' : ''}',
                ),
              'rc_invoice_da' => Text(receivingCard.deliveryPlan?.no ?? ''),
              'rc_vendor' => Text(receivingCard.vendorName ?? ''),
              'rc_pl' => Text(receivingCard.pl ?? ''),
              'rc_rohs_detail' => Text(receivingCard.rohs ?? ''),
              _ => null,
            };
          },
          textStyle: const TextStyle(fontSize: 9, fontWeight: FontWeight.w400),
        );
      },
    );
  }
}
