import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/repositories/inventory_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';

import 'check_rc_on_location_state.dart';

@injectable
class CheckRcOnLocationController extends BaseCubit<CheckRcOnLocationState> {
  CheckRcOnLocationController(this._inventoryRepository)
      : super(CheckRcOnLocationState());

  final InventoryRepository _inventoryRepository;

  PrinterDevice? savePrinterDevice;
  List<PrinterDevice>? printerDevices;

  Future<void> scanBlock(String value) async {
    if (value.isEmpty) {
      return;
    }

    try {
      launch(() async {
        final resRCList = await _inventoryRepository.getRCListInBlock(value);
        if (resRCList.isNotEmpty) {
          emit(state.copyWith(listReCard: resRCList));
        } else {
          throw ValidationError(type: ValidationErrorType.doNotHaveData);
        }
      });
    } catch (e) {
      logger.e(e);
    }
  }
}
