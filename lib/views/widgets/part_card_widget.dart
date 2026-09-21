import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

class PartCardWidget extends StatefulWidget {
  const PartCardWidget({super.key, this.partCard});

  final Barcode? partCard;

  @override
  State<PartCardWidget> createState() => PartCardWidgetState();
}

class PartCardWidgetState extends State<PartCardWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: rootBundle.loadString(Assets.html.receiveCard),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }
        return HtmlWidget(
          snapshot.data ?? '',
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
              'rc_title' => const Text('Receiving Card'),
              'rc_time' => Row(
                children: [
                  const SizedBox(width: 4),
                  Text(DateTime.now().toText(DateTimeType.time)),
                  const VerticalDivider(color: Colors.black),
                  const Text(
                    LocaleKeys.dialog_print_receiving_card,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ).tr(),
                ],
              ),
              'rc_barcode' =>
                  Assets.images.qrSample.image(width: 32, height: 32),
              'rc_material' => AppText.title(
                widget.partCard?.material ?? '-',
                style: const TextStyle(fontSize: 12),
              ),
              'rc_sample' => const Text('/'),
              'rc_rohs' => const Text('/'),
              'rc_code_date' => const Text('-'),
              'rc_quantity' => Text(widget.partCard!.quantity.toString()),
              'rc_invoice_da' => Text(widget.partCard?.deliveryPlan?.no ?? '-'),
              _ => null,
            };
          },
        );
      },
    );
  }
}
