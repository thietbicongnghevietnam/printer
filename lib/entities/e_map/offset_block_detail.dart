import 'package:flutter/material.dart';

class OffsetBlockDetail {
  OffsetBlockDetail({
    required this.offset,
    required this.blockId,
    this.location,
    this.lastLot,
    this.lastLotName,
    this.isStored = false,
  });

  final Offset offset;

  final int blockId;
  final int? lastLot;

  final String? location;
  final String? lastLotName;

  final bool isStored;
}
