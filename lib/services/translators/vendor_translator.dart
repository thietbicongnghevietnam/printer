import 'package:smart_warehouse/entities/vendor.dart';
import 'package:smart_warehouse/services/models/response/vendor_response_model.dart';

extension VendorTranslator on VendorResponseModel {
  Vendor toEntity() {
    return Vendor(
      vendorCode: vendorCode ?? '',
      vendorName: vendorName ?? '',
      vendorNameShort: vendorNameShort ?? '',
    );
  }
}
