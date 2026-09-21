// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:smart_warehouse/entities/receiving_card.dart';
// import 'package:smart_warehouse/gen/assets.gen.dart';
// import 'package:smart_warehouse/services/models/request/receiving_card_model.dart';
// import 'package:smart_warehouse/services/models/response/receiving_card_response_model.dart';
// import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
// import 'package:smart_warehouse/views/widgets/app_text.dart';
//
// class NewReceivingCardFromStockWidget extends StatelessWidget {
//   const NewReceivingCardFromStockWidget({
//     super.key, required this.receivingCard,
//
//   });
//
//   final ReceivingCardModel receivingCard;
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: rootBundle.loadString(Assets.html.receiveCard),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         return HtmlWidget(
//           snapshot.data ?? '',
//           rebuildTriggers: [receivingCard.currentQuantity],
//           customStylesBuilder: (element) {
//             switch (element.localName) {
//               case 'table':
//                 return {
//                   'border': '1px solid black',
//                   'border-collapse': 'collapse',
//                 };
//               case 'td':
//                 return {
//                   'border': '1px solid black',
//                   'border-collapse': 'collapse',
//                   'padding': '2px 4px',
//                 };
//             }
//             return null;
//           },
//           customWidgetBuilder: (element) {
//             return switch (element.id) {
//               'rc_time' => Text(DateTime.now().toText(DateTimeType.time)),
//               'rc_barcode' =>
//                   Assets.images.qrSample.image(width: 32, height: 32),
//               'rc_plant' => AppText.title(plant ?? ''),
//               'rc_date' => AppText(
//                 receivingCardDate ?? '',
//                 style: const TextStyle(fontSize: 9),
//               ),
//               'rc_urgent' => AppText.title(
//                 urgent ?? '',
//                 textAlign: TextAlign.end,
//                 style: const TextStyle(fontSize: 9),
//               ),
//               'rc_ul_coc' => AppText.title(ulcoc ?? ''),
//               'rc_material' => AppText.title(
//                 material,
//                 style: const TextStyle(fontSize: 12),
//               ),
//               'rc_type' => Text(materialType ?? ''),
//               'rc_frequency' => Text(materialFrequency ?? ''),
//               'rc_sloc' => Text(
//                 '$sloc ${category.isNotEmpty ? ' - $category' : ''}',
//               ),
//               'rc_sample' => samplingCheck ? const SizedBox() : const Text('/'),
//               'rc_rohs' => rohsCheck ? const SizedBox() : const Text('/'),
//               'rc_code_date' => const Text(''),
//               'rc_quantity' => Text(
//                 totalQty,
//               ),
//               'rc_invoice_da' => Text(daInvoiceNo ?? ''),
//               'rc_vendor' => Text(vendorName ?? ''),
//               'rc_pl' => Text(pl ?? ''),
//               'rc_rohs_detail' => Text(rohs ?? ''),
//               _ => null,
//             };
//           },
//           textStyle: const TextStyle(fontSize: 9, fontWeight: FontWeight.w400),
//         );
//       },
//     );
//   }
// }
