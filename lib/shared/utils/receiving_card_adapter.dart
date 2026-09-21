import 'package:hive/hive.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/entities/draft_receiving_card.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';

class DraftReceivingCardAdapter extends TypeAdapter<DraftReceivingCard> {
  @override
  int get typeId => 0;

  @override
  DraftReceivingCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DraftReceivingCard(
      material: fields[0] as String,
      deliveryPlan: DeliveryPlan(
        no: fields[1] as String,
        id: fields[2] as int?,
        type: DeliveryPlanType.fromCode(fields[3] as int),
      ),
      barcodes: (fields[4] as String).split('\n'),
      deliveryPlanDetailId: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, DraftReceivingCard obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.material)
      ..writeByte(1)
      ..write(obj.deliveryPlan.no)
      ..writeByte(2)
      ..write(obj.deliveryPlan.id)
      ..writeByte(3)
      ..write(obj.deliveryPlan.type.code)
      ..writeByte(4)
      ..write(obj.barcodes.join('\n'))
      ..writeByte(5)
      ..write(obj.deliveryPlanDetailId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DraftReceivingCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
