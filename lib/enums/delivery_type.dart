import 'package:collection/collection.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

enum DeliveryPlanType {
  dispatchAdvice(0),
  invoice(1),
  orderPlan(2),
  convert(3),
  reCheck(4),
  revertKitting(5),
  inSystem(6),
  outSystem(7);

  const DeliveryPlanType(this.code);

  final int code;

  static DeliveryPlanType fromCode(int code) {
    return DeliveryPlanType.values.firstWhere(
      (e) => e.code == code,
      orElse: () {
        throw ErrorEntity(message: 'Delivery type invalid');
      },
    );
  }

  String get text => switch (this) {
        dispatchAdvice => 'DA',
        invoice => 'Invoice',
        orderPlan => 'Order Plan',
        convert => 'Convert',
        reCheck => 'ReCheck Card',
        revertKitting => 'Revert Kitting Card',
        inSystem => 'Return Kitting Card',
        outSystem => 'Return Kitting Card',
      };

  @override
  String toString() {
    return switch (this) {
      dispatchAdvice => 'DA:',
      invoice => 'INV:',
      orderPlan => 'OP:',
      convert => 'Convert:',
      reCheck => 'ReCheck Card:',
      revertKitting => 'Revert Kitting Card:',
      inSystem => 'Return Kitting Card:',
      outSystem => 'Return Kitting Card:',
    };
  }
}
