import 'dart:core';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/services/models/response/receiving_card_response_model.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';

class StorageReceivingItem extends StatelessWidget {
  const StorageReceivingItem({
    super.key,
    required this.reCardData,
    this.onRemoved,
    this.onEditQty,
    this.hasRemove = true,
    this.hasEdit = false,
    this.fromBalance = false,
    this.isMinimalData = false,
  });

  final bool hasRemove;
  final bool hasEdit;
  final bool fromBalance;
  final bool isMinimalData;

  final ReceivingCard reCardData;

  final Function? onRemoved;
  final Function? onEditQty;

  @override
  Widget build(BuildContext context) {
    final zoneLastNode = reCardData.inforLastLot?.zoneLastLot?.lastLot ?? '';
    final rackLastNode =
        reCardData.inforLastLot?.zoneLastLot?.rackLastLot?.lastLot ?? '';
    final blockLastNode = reCardData
            .inforLastLot?.zoneLastLot?.rackLastLot?.blockLastLot?.lastLot ??
        '';

    final isSpecial = reCardData.isSpecial;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
        image: const DecorationImage(
          image: AssetImage('assets/images/ic_receiving_card_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration:BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        LocaleKeys.storing_material,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ).tr(),
                      Expanded(
                        child: Text(
                          ': ${reCardData.material}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text(
                        LocaleKeys.storing_current_qty,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ).tr(),
                      Expanded(
                        child: Text(
                          ': ${reCardData.currentQuantity}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  if (!isMinimalData &&
                      fromBalance &&
                      reCardData.balanceQty != 0) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          LocaleKeys.inventory_qty_balance,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ).tr(),
                        Expanded(
                          child: Text(
                            ': ${reCardData.balanceQty}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.orange,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                  if (!isMinimalData) ...[
                    Row(
                      children: [
                        const Text(
                          'Total DA/Inv',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ).tr(),
                        Expanded(
                          child: Text(
                            ': ${reCardData.qtyDAInv ?? 0}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 4),
                  if (!fromBalance) ...[
                    Row(
                      children: [
                        const Text(
                          LocaleKeys.storing_frequency,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ).tr(),
                        Expanded(
                          child: Text(
                            ': ${reCardData.materialFrequency}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          LocaleKeys.storing_box_type,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ).tr(),
                        Expanded(
                          child: Text(
                            ': ${reCardData.materialType}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                  if (!isMinimalData) ...[
                    Row(
                      children: [
                        const Text(
                          LocaleKeys.storing_category,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ).tr(),
                        Expanded(
                          child: Text(
                            ': ${reCardData.category}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          LocaleKeys.storing_receiving_time,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ).tr(),
                        Expanded(
                          child: Text(
                            ': ${reCardData.receivingCardTime}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          LocaleKeys.storing_receiving_date,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ).tr(),
                        Expanded(
                          child: Text(
                            ': ${reCardData.receivingCardDate}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (isSpecial && !fromBalance) ...[
                    const SizedBox(height: 4),
                    const Text(
                      'Special Part',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ).tr(),
                  ],
                  if (blockLastNode.isNotEmpty && !fromBalance && !isMinimalData) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          LocaleKeys.storing_block_last_node,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ).tr(),
                        Expanded(
                          child: Text(
                            ': $blockLastNode',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (hasRemove) ...[
            IconButton(
              onPressed: () {
                onRemoved?.call();
              },
              icon: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(1000),
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  Icons.highlight_remove_outlined,
                  color: Colors.red,
                ),
              ),
            ),
          ],
          if (hasEdit) ...[
            IconButton(
              onPressed: () {
                onEditQty?.call();
              },
              icon: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(1000),
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
