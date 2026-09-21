import 'package:smart_warehouse/shared/common/error_entity.dart';

enum KittingOutsideGroupSelect {
  uploadNo(1),
  category(2),
  reason(3),
  noOrder(null);

  static KittingOutsideGroupSelect fromCode(int? code) {
    return switch (code) {
      1 => uploadNo,
      2 => category,
      3 => reason,
      null => noOrder,
      _ => throw ErrorEntity(message: 'Kitting no select')
    };
  }

  final int? code;
  const KittingOutsideGroupSelect(this.code);

  String? get text {
    switch (this) {
      case KittingOutsideGroupSelect.uploadNo:
        return 'Upload No';
      case KittingOutsideGroupSelect.category:
        return 'Category';
      case KittingOutsideGroupSelect.reason:
        return 'Reason';
      case KittingOutsideGroupSelect.noOrder:
        return null;
    }
  }
}
