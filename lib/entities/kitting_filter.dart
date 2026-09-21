import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/enums/kitting_time_type.dart';
import 'package:smart_warehouse/enums/kitting_type.dart';

part 'kitting_filter.freezed.dart';

@freezed
class KittingFilter with _$KittingFilter {
  const KittingFilter._(); // Bắt buộc phải thêm constructor private này để dùng được các method trong Freezed

  const factory KittingFilter({
    required KittingType kittingType,
    int? kittingListId,
    String? material,
    @Default(KittingTimeType.total) KittingTimeType kittingTimeType,
    @Default(1) int pageNumber,
    @Default(200) int pageSize,
    int? startTime,
    int? endTime,
    @Default(false) bool isJIT,
    String? model,
    @Default([]) List<String> models,
    bool? isOnTheHour,
    @Default(false) bool isKittingEnough,
    DateTime? deliveryDate,
    @Default(null) bool? isUrgent,
    @Default(false) bool isDownstairs,
    String? startLocation,
    String? category,
    String? reason,
    String? uploadNo,
    String? picUser,
    @Default(false) bool isDay,
    @Default(false) bool isSub,
    String? location,
  }) = _KittingFilter;

  // Hàm bổ sung
  String getTimeKittingFormatted() {
    if (isOnTheHour ?? true) {
      if (startTime == 6 && endTime == 8) {
        return '6h, 8h';
      }
      return List.generate(endTime! - startTime! + 1, (index) => '${index + startTime!}h').join(', ');
    } else if (isOnTheHour == false) {
      return '${startTime}h -> ${endTime}h';
    }
    return '';
  }
}
