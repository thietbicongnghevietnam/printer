import 'package:smart_warehouse/entities/qty_by_location.dart';
import 'package:smart_warehouse/services/models/response/qty_by_location_response_model.dart';

extension QtyByLocationTranslator on QtyByLocationResponseModel {
  QtyByLocation toEntity() {
    return QtyByLocation(totalQty: totalQty, name: name);
  }
}
