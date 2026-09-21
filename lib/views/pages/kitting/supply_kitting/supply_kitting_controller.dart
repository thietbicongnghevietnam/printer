import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/kitting/kitting_list.dart';
import 'package:smart_warehouse/enums/kitting_type.dart';
import 'package:smart_warehouse/repositories/kitting_repository.dart';
import 'package:smart_warehouse/repositories/supply_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/views/pages/kitting/supply_kitting/supply_kitting_state.dart';

@injectable
class SupplyKittingController extends BaseCubit<SupplyKittingState> {
  SupplyKittingController(this.supplyRepository, this.kittingRepository)
      : super(SupplyKittingState());

  final SupplyRepository supplyRepository;
  final KittingRepository kittingRepository;

  late KittingType? kittingType;

  Future<void> scanCode(String barcode) {
    return launch(() async {
      final kittingListId = KittingList.getKittingListId(barcode);
      final response =
          await kittingRepository.getDataKittingList(id: kittingListId);
      emit(state.copyWith(kittingList: response, barcode: barcode));
    });
  }

  Future<void> scanLine(String line) {
    return launch(() async {
      final kittingLine = 'LINE-${state.kittingList?.line}';
      print(kittingLine);
      if (line.trim() != kittingLine) {
        throw ValidationError(type: ValidationErrorType.lineNotSame);
      }
      emit(state.copyWith(line: line));
    });
  }

  Future<void> confirmSupply({bool isLackSupply = false}) {
    return launch(() async {
      final barcode = state.kittingList?.barcode;
      final kittingLine = 'LINE-${state.kittingList?.line}';
      final line = state.line;

      if (kittingType != KittingType.dip) {
        if (line == null) {
          throw ValidationError(type: ValidationErrorType.plsScanLine);
        }
        if (line.trim() != kittingLine.trim()) {
          throw ValidationError(type: ValidationErrorType.lineNotSame);
        }
      }

      if (barcode == null) {
        throw ValidationError(type: ValidationErrorType.plsScanPartCard);
      }

      await checkSupply(isLackSupply: isLackSupply);
      await supplyRepository.confirmSupply(barcode: barcode);
    });
  }

  Future<void> checkSupply({bool isLackSupply = false}) {
    return launch(() async {
      await kittingRepository.checkSupply(
          kittingListId: state.kittingList?.id ?? 0,
          isSupplyLack: isLackSupply);
    });
  }

  Future<void> loadData() {
    return launch(() async {
      emit(state.copyWith(kittingList: null, barcode: '', line: ''));
    });
  }
}

