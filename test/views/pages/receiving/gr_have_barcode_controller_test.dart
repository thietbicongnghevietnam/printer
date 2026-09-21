import 'dart:ui';

import 'package:easy_localization/src/localization.dart';
import 'package:easy_localization/src/translations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/enums/scan_type.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/models/response/da_invoice_detail_response_model.dart';
import 'package:smart_warehouse/services/models/response/da_invoice_item_response_model.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/views/pages/receiving/have_barcode/gr_have_barcode_controller.dart';

class MockApiService extends Mock implements ApiService {}

class TranslationsMock extends Mock implements Translations {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ApiService apiService;
  late GRHaveBarcodeController controller;

  setUpAll(() {
    apiService = MockApiService();
    controller = GRHaveBarcodeController(apiService);

    final translations = TranslationsMock();

    when(() => translations.get('error.part_card_not_have_da'))
        .thenReturn('Test');

    Localization.load(const Locale('en'), translations: translations);
  });
  group('Update Scan Type', () {
    test('Update Scan Type: Scan By Box', () async {
      // Arrange

      // Act
      controller.updateScanType(ScanType.scanByBox);

      // Assert
      expect(controller.state.scanType, ScanType.scanByBox);
    });

    test('Update Scan Type: Scan By Lot', () async {
      // Arrange

      // Act
      controller.updateScanType(ScanType.scanByLot);

      // Assert
      expect(controller.state.scanType, ScanType.scanByLot);
    });
  });

  group('Load DA Invoice Info', () {
    test('Load DA Invoice Info success', () async {
      // Arrange
      final daItems = DAInvoiceItemResponseModel(
        'daItem',
        11,
        '1',
        '2',
        3,
        4,
      );
      final daDetail = DAInvoiceDetailResponseModel('material', 2, [daItems]);
      final deliveryPlan =
          DeliveryPlan(no: 'no', type: DeliveryPlanType.dispatchAdvice);
      controller.newBarcode =
          Barcode.fromBarcode('4500194999;16;EEE0JA221WP;10000;;');
      when(
        () => apiService.getDAInvoiceDetail(
          no: deliveryPlan.no,
          type: deliveryPlan.type.code,
        ),
      ).thenAnswer((_) async => [daDetail]);

      // Act
      await controller.loadDeliveryPlan(
        deliveryPlan: deliveryPlan,
      );

      // Assert
      expect(controller.state.deliveryPlan?.no, deliveryPlan.no);
      expect(controller.state.deliveryPlan?.type, deliveryPlan.type);
      expect(controller.state.deliveryPlan?.details.length, 1);
    });

    test('Load DA Invoice Info fail', () async {
      // Arrange
      controller.emit(controller.state.copyWith(deliveryPlan: null));
      final deliveryPlan =
          DeliveryPlan(no: 'no', type: DeliveryPlanType.dispatchAdvice);
      controller.newBarcode =
          Barcode.fromBarcode('4500194999;16;EEE0JA221WP;10000;;');
      final error = ServerError(message: 'message');
      when(
        () => apiService.getDAInvoiceDetail(
          no: deliveryPlan.no,
          type: deliveryPlan.type.code,
        ),
      ).thenThrow(error);

      // Act
      await expectLater(
        () async => controller.loadDeliveryPlan(
          deliveryPlan: deliveryPlan,
        ),
        throwsA(isA<ServerError>()),
      );

      // Assert
      expect(controller.state.deliveryPlan, isNull);
    });
  });

  group('Scan PartCard', () {
    test('Scan standard part card', () async {
      // Arrange
      const partCard = '4500194999;16;EEE0JA221WP;10000;;';
      controller.emit(controller.state.copyWith(deliveryPlan: null));

      // Act
      await expectLater(
        () async => controller.scanPartCard(partCard),
        throwsA(isA<ValidationError>()),
      );

      // Assert
      expect(
        controller.state.errorEntity?.message,
        ValidationErrorType.barcodeHaveManyDASame.toString(),
      );
    });

    test('Scan oversea part card', () async {
      // Arrange
      const partCard = '4500187577;122;D1BB6813A012;35000;35000;1;;00001';
      controller.emit(controller.state.copyWith(deliveryPlan: null));

      // Act
      await expectLater(
        () async => controller.scanPartCard(partCard),
        throwsA(isA<ValidationError>()),
      );

      // Assert
      expect(
        controller.state.errorEntity?.message,
        ValidationErrorType.barcodeHaveManyDASame.toString(),
      );
    });
  });
}
