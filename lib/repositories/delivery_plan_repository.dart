import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/barcode/local_barcode.dart';
import 'package:smart_warehouse/entities/barcode/pmd_barcode.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/entities/delivery_plan_filter.dart';
import 'package:smart_warehouse/entities/delivery_plan_item.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/translators/da_invoice_translator.dart';
import 'package:smart_warehouse/services/translators/order_plan_translator.dart';
import 'package:smart_warehouse/services/translators/search_delivery_plan_item_translator.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';

@injectable
class DeliveryPlanRepository {
  DeliveryPlanRepository(this._apiService);

  final ApiService _apiService;

  Future<(int, List<DeliveryPlan>)> _searchInvoiceDA({
    required DeliveryPlanFilter filter,
    int pageNumber = 1,
    int pageSize = Constants.pageLimit,
  }) async {
    final response = await _apiService.searchDAInvoice(
      vendorCode: filter.vendorCode,
      material: filter.material,
      date: filter.date?.toText(DateTimeType.yyyyMMdd),
      type: filter.type?.code,
      daInvNo: filter.daInvNo,
      daInvItem: filter.daInvItem,
      poNo: filter.poNo,
      poItem: filter.poItem,
      globalCode: filter.globalCode,
      quantity: filter.quantity,
      includeGoodReceipt: filter.includeGoodReceipt,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );

    final records = response.records
        .map((e) => e.toEntity())
        .sorted((a, b) => a.createdDate!.isBefore(b.createdDate!) ? 1 : 0)
        .toList();

    return (response.totalRecord, records);
  }

  Future<(int, List<DeliveryPlan>)> _searchPlanOrder({
    required DeliveryPlanFilter filter,
    int pageNumber = 1,
    int pageSize = Constants.pageLimit,
  }) async {
    final response = await _apiService.searchPlanOrder(
      material: filter.material,
      category: filter.category,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );

    return response.records.isNotEmpty
        ? (1, [response.records.toEntity()])
        : (0, <DeliveryPlan>[]);
  }

  Future<(int, List<DeliveryPlan>)> searchDeliveryPlans({
    required DeliveryPlanFilter filter,
    int pageNumber = 1,
    int pageSize = Constants.pageLimit,
  }) async {
    if (filter.type == null) {
      final daInvoiceRes = await _searchInvoiceDA(
        filter: filter,
        pageSize: pageSize,
        pageNumber: pageNumber,
      );

      if (daInvoiceRes.$1 != 0) {
        return daInvoiceRes;
      } else {
        return _searchPlanOrder(
          filter: filter,
          pageNumber: pageNumber,
          pageSize: pageSize,
        );
      }
    } else if (filter.type != DeliveryPlanType.orderPlan) {
      return _searchInvoiceDA(
        filter: filter,
        pageSize: pageSize,
        pageNumber: pageNumber,
      );
    } else {
      return _searchPlanOrder(
        filter: filter,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
    }
  }

  Future<List<(String, DeliveryPlanItem)>> searchDeliveryPlanItemDetails({
    required Barcode barcode,
  }) async {
    final response = await _apiService.searchDAInvoiceItemDetail(
      material: barcode.material,
      type: barcode.deliveryPlanType?.code,
      daInvNo: barcode.deliveryPlan?.no,
      daInvItem: barcode.as<LocalBarcode>()?.daItem,
      poNo: barcode.po,
      poItem: barcode.poItem,
    );

    return response.map((e) => (e.deliveryPlanNo, e.toEntity())).toList();
  }

  Future<DeliveryPlan?> getDeliveryPlanFromBarcode({
    required String barcode,
    String? material,
  }) async {
    final arr = barcode.split(Constants.barcodeSplitCharacter);
    if (arr.length != 2) {
      return null;
    }

    final deliveryPlans = await searchDeliveryPlans(
      filter: DeliveryPlanFilter(
        daInvNo: arr[0],
        vendorCode: arr[1],
        material: material,
      ),
    );

    final deliveryPlan = deliveryPlans.$2.singleOrNull;
    return deliveryPlan != null ? getDeliveryPlanDetail(deliveryPlan) : null;
  }

  //Tuấn Anh thêm
  Future<bool> checkexistBarcode({required String barcode}) async{
       final rs = await _apiService.Checkexistsbarcode(barCode: barcode);
       return rs;
  }




  Future<DeliveryPlan> getDeliveryPlanDetail(
    DeliveryPlan? deliveryPlan, {
    Barcode? barcode,
    bool includeGoodReceipt = false,
  }) async {
    var newDeliveryPlan = deliveryPlan;
    if (barcode != null) {
      final data = await searchDeliveryPlans(
        filter: DeliveryPlanFilter(
          daInvNo: deliveryPlan?.no,
          type: barcode.deliveryPlanType,
          globalCode: deliveryPlan?.globalCode,
          daInvItem: barcode.as<LocalBarcode>()?.daItem,
          poNo: barcode.po,
          poItem: barcode.poItem,
          category: barcode.as<PMDBarcode>()?.category,
          quantity: barcode.totalQuantity ?? barcode.quantity,
          material: barcode.material,
          includeGoodReceipt: includeGoodReceipt,
        ),
      );

      var deliveryPlans = data.$2;

      final lastDate = deliveryPlans
          .fold<DateTime?>(deliveryPlans.firstOrNull?.createdDate, (max, e) {
        return e.createdDate != null && e.createdDate!.isAfter(max!)
            ? e.createdDate
            : max;
      });

      deliveryPlans = deliveryPlans
          .where(
            (element) => element.createdDate?.toText() == lastDate?.toText(),
          )
          .toList();

      if (deliveryPlans.length > 1) {
        throw ValidationError(type: ValidationErrorType.barcodeHaveManyDASame);
      }

      if (deliveryPlans.isEmpty) {
        if (includeGoodReceipt) {
          throw ValidationError(type: ValidationErrorType.daInvoiceNotExist);
        }

        final data = await searchDeliveryPlans(
          filter: DeliveryPlanFilter(
            daInvNo: deliveryPlan?.no,
            type: barcode.deliveryPlanType,
            globalCode: deliveryPlan?.globalCode,
            daInvItem: barcode.as<LocalBarcode>()?.daItem,
            poNo: barcode.po,
            poItem: barcode.poItem,
            category: barcode.as<PMDBarcode>()?.category,
            quantity: barcode.totalQuantity ?? barcode.quantity,
            material: barcode.material,
            includeGoodReceipt: true,
          ),
        );

        if (data.$2.isNotEmpty) {
          throw ValidationError(type: ValidationErrorType.daInvoiceGR);
        } else {
          throw ValidationError(type: ValidationErrorType.daInvoiceNotExist);
        }
      }

      newDeliveryPlan = deliveryPlans.single;
    }

    if (newDeliveryPlan?.type == DeliveryPlanType.orderPlan &&
        newDeliveryPlan != null) {
      return newDeliveryPlan;
    }
      // Tuấn Anh check
    final response = await _apiService.getDAInvoiceDetail(
      id: newDeliveryPlan?.id,
      type: newDeliveryPlan?.type.code ?? 0,
    );
    return response.toEntity();
  }
}

