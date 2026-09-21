import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/models/response/da_invoice_detail_response_model.dart';
import 'package:smart_warehouse/services/models/response/da_invoice_item_response_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/views/pages/receiving/da_invoice/da_invoice_controller.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ApiService apiService;
  late DAInvoiceController controller;

  setUpAll(() {
    apiService = MockApiService();
    controller = DAInvoiceController(apiService);
  });
  group('Init Data', () {
    test('initData success', () async {
      // Arrange
      final deliveryPlan = DeliveryPlan(
        no: 'no',
        type: DeliveryPlanType.dispatchAdvice,
      );
      controller.deliveryPlan = deliveryPlan;
      final daItems = DAInvoiceItemResponseModel(
        'daItem',
        11,
        '1',
        '2',
        3,
        4,
      );
      final daDetail = DAInvoiceDetailResponseModel('material', 2, [daItems]);
      when(
        () => apiService.getDAInvoiceDetail(
          no: deliveryPlan.no,
          type: deliveryPlan.type.code,
        ),
      ).thenAnswer((_) async => [daDetail]);

      // Act
      await controller.initData();

      // Assert
      expect(controller.state.deliveryPlan?.no, deliveryPlan.no);
      expect(controller.state.deliveryPlan?.type, deliveryPlan.type);
      expect(controller.state.deliveryPlan?.details.length, 1);
      expect(controller.state.pageStatus, PageStatus.loaded);
    });

    test('initData fail', () async {
      // Arrange
      final deliveryPlan = DeliveryPlan(
        no: 'no',
        type: DeliveryPlanType.dispatchAdvice,
      );
      controller.deliveryPlan = deliveryPlan;
      controller.emit(
        controller.state
            .copyWith(pageStatus: PageStatus.initial, deliveryPlan: null),
      );
      final error = ServerError(message: '123');
      when(
        () => apiService.getDAInvoiceDetail(
          no: deliveryPlan.no,
          type: deliveryPlan.type.code,
        ),
      ).thenThrow(error);

      // Act
      await expectLater(
        () async => controller.initData(),
        throwsA(isA<ServerError>()),
      );

      // Assert
      expect(controller.state.deliveryPlan, isNull);
      expect(controller.state.pageStatus, PageStatus.error);
      expect(controller.state.errorEntity, error);
    });
  });
}
