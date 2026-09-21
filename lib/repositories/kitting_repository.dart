import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/e_map/emap_kiting_suggest.dart';
import 'package:smart_warehouse/entities/e_map/order_block.dart';
import 'package:smart_warehouse/entities/e_map/suggest_path.dart';
import 'package:smart_warehouse/entities/fifo.dart';
import 'package:smart_warehouse/entities/kitting/kitting_card.dart';
import 'package:smart_warehouse/entities/kitting/kitting_detail.dart';
import 'package:smart_warehouse/entities/kitting/kitting_list.dart';
import 'package:smart_warehouse/entities/kitting_request.dart';
import 'package:smart_warehouse/entities/qty_by_location.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/entities/receiving_card_kitting.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/models/request/check_kitting_request_model.dart';
import 'package:smart_warehouse/services/models/request/check_supply_request_model.dart';
import 'package:smart_warehouse/services/models/request/kitting_card_request.dart';
import 'package:smart_warehouse/services/models/request/revert_kitting_request_model.dart';
import 'package:smart_warehouse/services/models/response/kitting_list_trolley_info_response_model.dart';
import 'package:smart_warehouse/services/models/response/suggest_path_response_model.dart';
import 'package:smart_warehouse/services/translators/emap_kitting_suggest_translator.dart';
import 'package:smart_warehouse/services/translators/fifo_translator.dart';
import 'package:smart_warehouse/services/translators/kitting_card_request_translator.dart';
import 'package:smart_warehouse/services/translators/kitting_card_translator.dart';
import 'package:smart_warehouse/services/translators/kitting_detail_translator.dart';
import 'package:smart_warehouse/services/translators/kitting_translator.dart';
import 'package:smart_warehouse/services/translators/qty_by_location_translator.dart';
import 'package:smart_warehouse/services/translators/receiving_card_item_translator.dart';
import 'package:smart_warehouse/services/translators/receiving_card_kitting_translator.dart';
import 'package:smart_warehouse/services/translators/receiving_card_translator.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/shared/utils/storage_manager.dart';
import 'package:smart_warehouse/views/pages/kitting/return_kitting/return_kitting_page.dart';

import '../services/models/request/return_kitting_request_model.dart';

@injectable
class KittingRepository {
  KittingRepository(this._apiService);

  final ApiService _apiService;

  Future<(int, List<KittingDetail>, List<OrderBlock>?, List<SuggestPath>?)>
      getDataKittingDetail({
    int? id,
    String? material,
    String? kittingTimeType,
    int pageNumber = 1,
    int pageSize = 200,
    int? startTime,
    int? endTime,
    bool? isJIT,
    String? model,
    bool? isOnTheHour,
    bool? isKittingEnough,
    String? deliveryDate,
    bool? isUrgent,
    int? kittingType,
    String? startLocation,
    String? uploadNo,
    String? category,
    String? reason,
    String? picUser,
    bool? isDay,
    bool isDownstairs = false,
    String? location,
    bool isSub = false,
  }) async {
    if (deliveryDate != null) {
      getIt<StorageManager>().set(StorageKeys.kittingDate, deliveryDate);
    } else {
      deliveryDate ??=
          DateTime.now().add(const Duration(days: 1)).toString().split(' ')[0];
    }
    final response = await _apiService.getKittingDetail(
      kittingListId: id,
      pageNumber: pageNumber,
      material: material,
      kittingTimeType: kittingTimeType,
      pageSize: pageSize,
      startTime: startTime,
      endTime: endTime,
      isJIT: isJIT,
      model: model,
      isOnTheHour: isOnTheHour,
      isKittingEnough: isKittingEnough,
      deliveryDate: deliveryDate,
      isUrgent: isUrgent,
      kittingType: kittingType,
      startLocation: startLocation,
      uploadno: uploadNo,
      reason: reason,
      category: category,
      picuser: picUser,
      isDownstairs: isDownstairs,
      isDay: isDay,
      location: location,
    );

    var records = response.records;

    if (isSub) {
      records = records
          .where((element) => element.locationName?.toUpperCase() == 'SUB')
          .toList();
    }
    return (
      response.totalRecord,
      records.map((e) => e.toEntity()).toList(),
      response.orderBlock.map((e) => e.toEntity()).toList(),
      response.suggestPath.map((e) => e.toEntity()).toList(),
    );
  }
  Future<KittingCard> getKittingCard(int id) async {
    final response = await _apiService.getKittingCard(id);
    if (response == null) {
      throw ValidationError(type: ValidationErrorType.kittingCardInvalid);
    }
    return response.toEntity();
  }
  Future<List<KittingCard>> createKittingCard({
    List<KittingRequest>? kittingCardRequests,
    bool? isPreview,
    String? material,
    bool isSub = false,
  }) async {
    final requestModel =
        kittingCardRequests?.map((e) => e.toRequestModel()).toList();
    final kittingRequest = KittingCardRequest(
      kittingCardsRequests: requestModel,
      isPreview: isPreview,
      material: material,
      isSub: isSub,
    );
    final response = await _apiService.createKittingCard(kittingRequest);
    return response.map((e) => e.toEntity()).toList();
  }

  Future<void> checkKittingList({
    int? id,
    int? status,
    List<String>? barcodes,
  }) async {
    final request = CheckKittingRequestModel(
      id: id,
      status: status,
      barcode: barcodes,
    );

    await _apiService.checkKittingList(request);
  }

  Future<List<ReceivingCardItem>> getReceivingCardItemByRcId({
    int? rcId,
  }) async {
    final response = await _apiService.getReceivingCardItemByRcId(rcId: rcId);
    final result = response.map((e) => e.toEntity()).toList();
    return result;
  }

  Future<List<ReceivingCardItem>> getReceivingCardItem({
    String barcode = '',
    String? material,
  }) async {
    final response = await _apiService.getReceivingCardItemByBarCodeForKitting(
      barcode: barcode,
      material: material,
    );
    return response.map((e) => e.toEntity()).toList();
  }

  Future<List<ReceivingCard>> getReceivingCard({
    int? id,
    String? material,
  }) async {
    final response = await _apiService.getReceivingCardForKitting(
      receivingCardId: id,
      material: material,
    );
    return response.map((element) => element.toEntity()).toList();
  }

  Future<KittingListTrolleyInfoResponsesModel?> getKittingListWithTrolley(
    int kittingCardId,
  ) async {
    final response = await _apiService.getKittingListWithTrolley(
      kittingCardId: kittingCardId,
    );
    return response;
  }

  Future<KittingList?> getDataKittingList({
    String? barcode,
    int? id,
  }) async {
    final response = await _apiService.getDataKittingList(
      barcode: barcode,
      id: id,
    );
    return response?.toEntity();
  }

  Future<ReceivingCard> revertKitting({
    required List<String> barcodes,
    bool isPreview = true,
  }) async {
    final request =
        RevertKittingRequestModel(barcode: barcodes, isPreview: isPreview);
    final response = await _apiService.revertKitting(request);
    return response.toEntity();
  }

  Future<ReceivingCard?> returnKitting({
    required List<String> barcodes,
    required ReturnKittingType returnKittingType,
    required String material,
    required String plant,
    required String sloc,
    required String category,
    int? quantity,
    bool isPreview = true,
  }) async {
    final request = ReturnKittingRequestModel(
      barcode: barcodes,
      quantity: quantity,
      material: material,
      plant: plant,
      sloc: sloc,
      category: category,
      returnKittingType: returnKittingType.code,
      isPreview: isPreview,
    );
    final response = await _apiService.returnKitting(request);
    return response?.toEntity();
  }

  Future<void> checkReprintForRevertKittingCard({
    required String barcode,
  }) async {
    await _apiService.checkReprintForRevertKittingCard(
      barcode: barcode,
    );
  }

  Future<void> checkSupply({
    required int kittingListId,
    bool isSupplyLack = false,
  }) async {
    final request = CheckSupplyRequestModel(
        isSupplyLack: isSupplyLack, kittingListId: kittingListId);
    await _apiService.checkSupply(request);
  }

  Future<List<ReceivingCardKitting>> getReceivingCardByKittingCard({
    required String barcode,
  }) async {
    final response =
        await _apiService.getReceivingCardByKittingCard(barcode: barcode);
    return response.map((element) => element.toEntity()).toList();
  }

  Future<Fifo> getFifo({
    required String material,
  }) async {
    final response = await _apiService.getFifo(material: material);
    return response.toEntity();
  }

  Future<List<KittingCard>> getKittingCardByKittingListDetailId({
    int? id,
  }) async {
    final response = await _apiService.getKittingCardByKittingListDetailId(
        kittingListDetailId: id);
    return response.map((element) => element.toEntity()).toList();
  }

  Future<List<String>> getUploadNo({
    String? deliveryDate,
    int? kittingType,
  }) async {
    final response = await _apiService.getUploadNo(
        deliveryDate: deliveryDate, kittingType: kittingType);
    return response;
  }

  Future<EMapKittingSuggest> getDataSuggestMap({
    required List<String> locations,
  }) async {
    final response = await _apiService.getDataSuggestMap(locations: locations);
    return response.toEntity();
  }

  Future<ReceivingCard> getReceivingCardByPartCardId({
    int? partCardId,
  }) async {
    final response =
        await _apiService.getReceivingCardByPartCardId(partCardId: partCardId);
    return response.toEntity();
  }

  Future<QtyByLocation> getQtyByLocation({
    int? receivingCardId,
  }) async {
    final response =
        await _apiService.getQtyByLocation(receivingCardId: receivingCardId);
    return response.toEntity();
  }

  Future<List<KittingDetail>> getKittingDetailByKittingListId({
    int? kittingListId,
    int pageNumber = 1,
    int pageSize = 200,
  }) async {
    final response = await _apiService.getKittingDetailByKittingListId(
      kittingListId: kittingListId,
      pageSize: pageSize,
      pageNumber: pageNumber,
    );
    return response.records.map((e) => e.toEntity()).toList();
  }
}
