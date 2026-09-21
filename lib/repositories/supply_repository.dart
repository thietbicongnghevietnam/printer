import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/supply.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/models/request/create_trolleykitting_request_model.dart';
import 'package:smart_warehouse/services/models/request/trolley_kitting_move_request_model.dart';
import 'package:smart_warehouse/services/translators/supply_translator.dart';

@injectable
class SupplyRepository {
  SupplyRepository(this._apiService);

  final ApiService _apiService;

  Future<List<Supply>> getSupplyByKittingListId({int kittingListId = 0}) async {
    final response =
        await _apiService.getByKittingListId(kittingListId: kittingListId);
    return response.records.map((e) => e.toEntity()).toList();
  }

  Future<void> inputKittingListLocation({
    List<String> kittingListQR = const [],
    String codeTrolley = '',
  }) async {
    final request = CreateTrolleyKittingRequestModel(
      kittingList: kittingListQR,
      trolley: codeTrolley,
    );
    await _apiService.inputKittingListLocation(request: request);
  }

  Future<void> outKittingListLocation({
    String kittingListQR = '',
  }) async {
    await _apiService.outKittingListLocation(
      kittingListQR: kittingListQR,
    );
  }

  Future<void> moveKittingListLocation({
    required TrolleyKittingMoveRequestModel body,
  }) async {
    await _apiService.moveKittingListLocation(body: body);
  }

  Future<void> confirmSupply({
    String barcode = '',
  }) async {
    await _apiService.confirmSupply(
      barCodeKittingList: barcode,
    );
  }
}
