import 'package:smart_warehouse/entities/kitting/kitting_list.dart';
import 'package:smart_warehouse/services/models/response/kitting_response_model.dart';

extension KittingFaTranslator on KittingResponseModel {
  KittingList toEntity() {
   return KittingList(
     id: id,
     status: status,
     barcode: barcode,
     deliveryDate: deliverydate,
     updateBy: updateBy,
     updatedDate: updatedDate,
     createdBy: createdBy,
     createdDate: createdDate,
     line: line,
     time: time,
     modelQuantity: modelQuantity,
     category: category,
     quantity: quantity,
     kittingType: kittingType,
     kittingTimeType: kittingTimeType,
     reservationNo: reservationNo,
     plant: plant,
     model: model,
   );
  }
}
