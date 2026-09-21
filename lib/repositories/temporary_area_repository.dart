import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/models/request/combine_pallet_request_model.dart';
import 'package:smart_warehouse/services/models/request/input_location_request_model.dart';
import 'package:smart_warehouse/services/models/request/move_receiving_card_request_model.dart';
import 'package:smart_warehouse/services/models/request/out_pallet_request_model.dart';
import 'package:smart_warehouse/services/models/request/out_receiving_card_request_model.dart';
import 'package:smart_warehouse/services/models/request/receiving_card_model.dart';

@injectable
class TemporaryAreaRepository {
  TemporaryAreaRepository(this._apiService);

  final ApiService _apiService;

  Future<void> inputLocation(String pallet, List<int> receivingCardIds) async {
    final request = InputLocationRequestModel(
      temporaryAreaCode: pallet,
      receivingCardIds: receivingCardIds,
    );

    await _apiService.createInputLocation(request);
  }

  Future<List<ReceivingCardModel>> combinePallet({
    String? temporaryAreaCodeOld,
    required String temporaryAreaCodeNew,
    required List<int> receivingCardIds,
  }) async {
    final request = CombinePalletRequestModel(
      receivingCardIds: receivingCardIds,
      temporaryAreaCodeNew: temporaryAreaCodeNew,
    );
    return _apiService.createCombinePallet(request);
  }

  Future<void> movePallet(
      {required String palletSource, required String palletEnd}) {
    final request = MoveReceivingCardRequestModel(
      temporaryAreaCodeOld: palletSource,
      temporaryAreaCodeNew: palletEnd,
    );
    return _apiService.createMoveReceivingCard(request);
  }

  Future<void> outReceivingCard({required String barcode}) {
    final request = OutReceivingCardRequestModel(barcode: barcode);
    return _apiService.outReceivingCard(request);
  }

  Future<void> outPallet({required String pallet}) {
    final request = OutPalletRequestModel(temporaryAreaCode: pallet);
    return _apiService.outPallet(request);
  }
}
