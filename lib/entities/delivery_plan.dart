import 'package:collection/collection.dart';
import 'package:smart_warehouse/entities/barcode/local_barcode.dart';
import 'package:smart_warehouse/entities/delivery_plan_item.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'barcode/barcode.dart';
import 'delivery_plan_detail.dart';

/// Dispatch Advice or Invoice
class DeliveryPlan {
  const DeliveryPlan({
    this.id,
    required this.no,
    required this.type,
    this.globalCode,
    this.deliveryDate,
    this.createdDate,
    this.vendorCode,
    this.quantity,
    this.details = const [],
  });

  final int? id;
  final String no;
  final DeliveryPlanType type;
  final String? globalCode;
  final DateTime? deliveryDate;
  final DateTime? createdDate;
  final String? vendorCode;
  final int? quantity;
  final List<DeliveryPlanDetail> details;

  DeliveryPlanDetail getDeliveryPlanDetail({required Barcode barcode}) {
    final material = barcode.material.trim();
    final quantity = barcode.quantity;
    final po = barcode.po;
    final poItem = barcode.poItem;
    final daInvItem = barcode.as<LocalBarcode>()?.daItem;

    var details = this.details.where((element) => element.material == material).toList();

    if (barcode.deliveryPlanType != DeliveryPlanType.orderPlan) {
      details =
          details.where((element) => element.totalQuantity - (element.gredQuantity ?? 0) >= quantity).toList();
    }



    if (po != null || poItem != null) {
      details = details.where(
        (element) => element.items.any(
          (item) =>
              item.poNo == po &&
              item.poItem.toInt() == poItem.toInt() &&
              (daInvItem == null || item.daInvoiceItem == daInvItem),
        ),
      ).toList();
    }

    if (details.isEmpty) {
      throw ValidationError(type: ValidationErrorType.barcodeNotExistedDA);
    }

    if (details.length > 1) {
      throw ValidationError(type: ValidationErrorType.barcodeHaveManyPlantSame);
    }

    return details.single;
  }

  DeliveryPlanItem? getDeliveryPlanItem({required Barcode barcode}) {
    final material = barcode.material;
    final po = barcode.po;
    final poItem = barcode.poItem;
    final daInvItem = barcode.as<LocalBarcode>()?.daItem;
    final details = this.details.where(
          (element) => element.material == material,
        );

    final items = details.expand((element) => element.items);

    if (po == null && poItem == null) {
      return items.firstOrNull;
    }

    return items.firstWhereOrNull(
      (e) =>
          e.poNo == po &&
          e.poItem.toInt() == poItem.toInt() &&
          (e.daInvoiceItem == daInvItem || daInvItem == null),
    );
  }

  bool compare(DeliveryPlan? other) {
    return type == other?.type && no == other?.no;
  }
}
