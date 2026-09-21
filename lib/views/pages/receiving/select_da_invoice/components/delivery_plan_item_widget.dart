import 'package:flutter/material.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/shared/extensions/context_extensions.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';

class DeliveryItemWidget extends StatelessWidget {
  const DeliveryItemWidget({
    super.key,
    required this.daInvoice,
    required this.onPressed,
  });

  final DeliveryPlan daInvoice;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(2, 1), // changes position of shadow
          ),
        ],
      ),
      child: daInvoice.type != DeliveryPlanType.orderPlan
          ? ListTile(
              dense: true,
              title: Text('${daInvoice.type} ${daInvoice.no}${daInvoice.quantity != null ? ' - Qty: ${daInvoice.quantity}' : ''}'),
              titleTextStyle: context.theme.textTheme.bodyMedium,
              subtitle: daInvoice.type != DeliveryPlanType.orderPlan
                  ? Text('Vendor code: ${daInvoice.vendorCode}')
                  : null,
              trailing: Text('${daInvoice.deliveryDate?.toText()}'),
              onTap: onPressed,
            )
          : ListTile(
              dense: true,
              title: Text('${daInvoice.type} ${daInvoice.no}'),
              titleTextStyle: context.theme.textTheme.bodyMedium,
              onTap: onPressed,
            ),
    );
  }
}
