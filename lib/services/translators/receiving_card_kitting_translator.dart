import 'package:smart_warehouse/entities/receiving_card_kitting.dart';
import 'package:smart_warehouse/services/models/response/receiving_card_kitting_response_model.dart';

extension ReceivingCardKittingTranslator on ReceivingCardKittingResponsesModel {
  ReceivingCardKitting toEntity() {
    return ReceivingCardKitting(
        rcid: rcid, material: material, locationName: locationName);
  }
}
