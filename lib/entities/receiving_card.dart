import 'package:collection/collection.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/entities/storage_card.dart';
import 'package:smart_warehouse/enums/receiving_card_reason.dart';
import 'package:smart_warehouse/enums/receving_card_type.dart';
import 'package:smart_warehouse/services/models/response/info_last_lot_response_model.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/utils/copyable.dart';
import 'package:sprintf/sprintf.dart';

class ReceivingCard extends StorageCard implements Copyable<ReceivingCard> {
  ReceivingCard({
    this.qtyDAInv,
    required this.haveBarcode,
    required super.id,
    required this.samplingCheck,
    required this.rohsCheck,
    required this.totalQuantity,
    required this.currentQuantity,
    this.plant,
    this.receivingCardTime,
    this.urgent,
    this.ulcoc,
    required super.material,
    this.materialType,
    this.materialFrequency,
    this.codeDate,
    this.deliveryPlan,
    this.reason,
    this.pl,
    this.rohs,
    this.receivingCardDate,
    this.vendorCode,
    this.vendorName,
    this.sloc,
    required super.barcode,
    this.temporaryAreaCode,
    this.category,
    this.box,
    this.daInvDetailId,
    this.items = const [],
    this.daInvNoFromStock,
    this.isSpecial = false,
    this.inforLastLot,
    this.isNG = false,
    this.location,
    this.isOverdue = false,
    this.receivingType,
    this.balanceQty = 0,
    this.rcType = ReceivingCardPrinterType.receivingCard,
  }) : super(
          quantity: currentQuantity,
          rcId: id,
          receivingDate: receivingCardDate,
        );

  final bool samplingCheck;
  final bool rohsCheck;
  final int totalQuantity;
  final int currentQuantity;
  final String? plant;
  final String? receivingCardTime;
  final String? urgent;
  final String? ulcoc;
  final String? materialType;
  final String? materialFrequency;
  final String? codeDate;
  final DeliveryPlan? deliveryPlan;
  final ReceivingCardReason? reason;
  final String? pl;
  final String? rohs;
  final DateTime? receivingCardDate;
  final String? vendorCode;
  final String? vendorName;
  final String? sloc;
  final String? temporaryAreaCode;
  final String? category;
  final bool haveBarcode;
  final int? qtyDAInv;
  int? box;
  final int? daInvDetailId;
  bool isSpecial;
  bool isNG;
  InfoLastLotResponseModel? inforLastLot;
  final String? location;
  final bool isOverdue;

  // Special Case Convert Stock Card to Receiving Card
  final String? daInvNoFromStock;
  ReceivingCardPrinterType rcType;

  // Balance Function
  int balanceQty;

  List<ReceivingCardItem> items;
  final int? receivingType;

  static int getReceivingCardID(String barcode) {
    final arr = barcode.split(Constants.receivingCardSplitCharacter);
    if (arr.length != 7) {
      throw ValidationError(type: ValidationErrorType.receivingCardInvalid);
    }
    return arr.first.toInt();
  }

  static bool validate(String barcode) {
    final arr = barcode.split(Constants.receivingCardSplitCharacter);
    return arr.length == 7;
  }

  String get command {
    final sbplCommand = switch ((samplingCheck, rohsCheck)) {
      (false, false) => Constants.sbplNoCheck,
      (false, true) => Constants.sbplRohsCheck,
      (true, false) => Constants.sbplSamplingCheck,
      (true, true) => Constants.sbplBothCheck,
    };

    final name = vendorName?.splitString(14);
    final ulString = ulcoc?.replaceAll('|', ' ');
    final ul = ulString?.splitString(5);

    final array = items.map((e) => e.currentQuantity).toList()..sort();
    final gr = groupBy(array.reversed, (p0) => p0);
    final boxString = items.isNotEmpty
        ? '(${gr.values.map((e) => '${e.length}x${e.first}').join('+')})'
        : '';

    return sprintf(
      sbplCommand,
      [
        rcType.text,
        name?.$1,
        plant ?? '',
        material,
        codeDate ?? '',
        if ((rcType == ReceivingCardPrinterType.rcConvert ||
                rcType == ReceivingCardPrinterType.reCheckCard) &&
            currentQuantity != 0)
          '$currentQuantity${'/$totalQuantity'} $boxString'
        else if (qtyDAInv != null && qtyDAInv! > 0)
          '$totalQuantity${'/$qtyDAInv'} $boxString'
        else
          '$totalQuantity $boxString',
        '$sloc${category != null ? ' - $category' : ''}',
        if (daInvNoFromStock != null)
          daInvNoFromStock
        else
          deliveryPlan?.no ?? '',
        pl ?? '',
        materialFrequency ?? '',
        receivingCardDate?.toText() ?? '',
        urgent ?? '',
        barcode.length,
        barcode,
        receivingCardTime ?? '',
        ul?.$1 ?? '',
        (materialType ?? '') + (items.isNotEmpty ? ' - Box' : ''),
        rohs ?? '',
        name?.$2,
        ul?.$2 ?? '',
      ],
    );
  }

  @override
  ReceivingCard copyWith({
    int? quantity,
    int? stockQuantity,
    String? sloc,
    int? rcId,
    ReceivingCardPrinterType? rcCurrentType,
    List<ReceivingCardItem>? items,
    bool isCurrentDate = false,
    bool? samplingCheck,
    bool? roshCheck,
  }) {
    return ReceivingCard(
      haveBarcode: haveBarcode,
      id: id,
      items: items ?? this.items,
      samplingCheck: samplingCheck ?? this.samplingCheck,
      rohsCheck: roshCheck ?? rohsCheck,
      totalQuantity: quantity ?? totalQuantity,
      currentQuantity: stockQuantity ?? currentQuantity,
      plant: plant,
      receivingCardTime: receivingCardTime,
      urgent: urgent,
      ulcoc: ulcoc,
      material: material,
      materialType: materialType,
      materialFrequency: materialFrequency,
      codeDate: codeDate,
      deliveryPlan: deliveryPlan,
      reason: reason,
      pl: pl,
      rohs: rohs,
      receivingCardDate: isCurrentDate ? DateTime.now() : receivingCardDate,
      vendorCode: vendorCode,
      vendorName: vendorName,
      sloc: sloc ?? this.sloc,
      barcode: barcode,
      temporaryAreaCode: temporaryAreaCode,
      qtyDAInv: qtyDAInv,
      daInvDetailId: daInvDetailId,
      category: category,
      box: box,
      location: location,
      isOverdue: isOverdue,
      isNG: isNG,
      rcType: rcCurrentType ?? rcType,
    );
  }
}
