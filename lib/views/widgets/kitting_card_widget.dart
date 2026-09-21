import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:smart_warehouse/entities/kitting/kitting_card.dart';
import 'package:smart_warehouse/enums/kitting_time_type.dart';
import 'package:smart_warehouse/enums/kitting_type.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

class KittingCardWidget extends StatelessWidget {
  const KittingCardWidget({super.key, required this.kittingCard});

  final KittingCard kittingCard;

  @override
  Widget build(BuildContext context) {
    final String htmlFile;
    if (kittingCard.kittingType == KittingType.fa.code ||
        kittingCard.kittingType == KittingType.dip.code) {
      htmlFile = Assets.html.kittingCard;
    } else if (kittingCard.kittingType == KittingType.outside.code) {
      htmlFile = Assets.html.kittingCardOutside;
    } else {
      htmlFile = Assets.html.kittingCardSubcon;
    }
    return FutureBuilder(
      future: rootBundle.loadString(htmlFile),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
          child: HtmlWidget(
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
              final quantity = kittingCard.quantity?.toInt() ?? 0;
              final totalQuantity = kittingCard.qtyTotal?.toInt() ?? 0;

              return switch (element.id) {
                'kt-timeType' => Text(
                    getTextKittingTimeType(kittingCard.kittingTimeType ?? '') ??
                        ''),
                'qr-code' =>
                  Assets.images.qrSample.image(width: 32, height: 32),
                'pic' => Text(kittingCard.pic ?? ''),
                'plant' => Text(kittingCard.plant ?? ''),
                'pos-mcs' => Text(kittingCard.posMcs ?? ''),
                'pos-fa' => Text(kittingCard.posFA ?? ''),
                'material' => Text(kittingCard.material ?? ''),
                'model' => Text(kittingCard.model ?? ''),
                'qty' => Text(quantity < totalQuantity
                    ? '$quantity/$totalQuantity'
                    : quantity.toString()),
                'date' => Text(kittingCard.kittingDate?.toText() ?? ''),
                'time' => Text(kittingCard.kittingHour ?? ''),
                'line' => Text(kittingCard.line ?? ''),
                'sloc' => Text(kittingCard.sloc ?? ''),
                'pl' => Text(kittingCard.pl ?? ''),
                'kittingFrom' => Text(kittingCard.kittingFrom ?? ''),
                'category' => Text('Cate- ${kittingCard.category ?? ''}'),
                'uln' => Text('ULN: ${kittingCard.pullID ?? ''}'),
                'repSloc' => Text('RepLoc: ${kittingCard.receiptSloc ?? ''}'),
                'date-outside' => Text('Req.Date: ${kittingCard.kittingDate?.toText() ?? ''}'),
                'isl' => Text('ISL: ${kittingCard.sloc ?? ''}'),
                'reason' => Text(kittingCard.reason ?? ''),
                'remark' => Text(kittingCard.remark ?? ''),
                'lineOutside' => Text('Line: ${kittingCard.line ?? ''}'),
                'qtyOutside' => Text('Req Qty: ${kittingCard.quantity ?? ''}'),
              'qty-subcon' => Text('$totalQuantity'),
              'plant-outside' => Text('Plant ${kittingCard.plant ?? ''}'),
                _ => null,
              };
            },
            textStyle:
                const TextStyle(fontSize: 9, fontWeight: FontWeight.w400),
          ),
        );
      },
    );
  }

  String getTextKittingTimeType(String type) {
    switch (type) {
      case '1':
        return 'One Time';
      case '2':
        return 'Prepare';
      case 'N1' || 'N2' || 'N3':
        return 'N Time';
    }
    return '';
  }
}
