
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/translators/receiving_card_item_translator.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

@injectable
class ReceivingCardItemRepository {
  ReceivingCardItemRepository(this._apiService);

  final ApiService _apiService;
  Future<List<ReceivingCardItem>> getReceivingCardItem({
    String barcode = '',
  }) async {
    final response = await _apiService.getReceivingCardItem(barcode);
    return response.map((e) => e.toEntity()).toList();
  }
}
