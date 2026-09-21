import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_warehouse/entities/ta_re_card_item.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/models/request/input_location_request_model.dart';
import 'package:smart_warehouse/services/models/request/receiving_card_model.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/views/pages/temporary_area/input_location/input_location_controller.dart';

class MockApiService extends Mock implements ApiService {}

class FakeInputLocationRequestModel extends Fake
    implements InputLocationRequestModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ApiService apiService;
  late InputLocationController controller;

  setUp(() {
    apiService = MockApiService();
    controller = InputLocationController(apiService);

    registerFallbackValue(FakeInputLocationRequestModel());
  });

  group('Update Pallet', () {
    test('Update pallet when pallet valid', () async {
      // Arrange
      controller.emit(controller.state.copyWith(palletData: 'PL100'));

      // Act
      await controller.updatePallet('PL199');

      // Assert
      expect(controller.state.palletData, 'PL199');
    });

    test('Update pallet when pallet invalid', () async {
      // Arrange

      // Act
      await expectLater(
        () async => controller.updatePallet('1111'),
        throwsA(isA<ValidationError>()),
      );

      // Assert
    });
  });

  group('Added Receiving Card', () {
    test('add Receiving card when re_card valid', () async {
      // Arrange
      final currentReCard =
          List<CustomReCardItem>.from(controller.state.listReCard ?? []);
      String reCard =
          '1;0;;;1;0;0;0;VV01;11:54:14;;;TPD5ZA00431;;;string;K231114006;;;;11/23/2023 12:00:00 AM;VE090;THIÊN QUANG;;;;0;11/23/2023 11:54:14 AM;2012757;;';
      final splitPDAValue = reCard.split(';');
      final receivingId = int.parse(splitPDAValue[0]);

      final receivingMaterial = splitPDAValue[12];
      final receivingCardID = int.parse(splitPDAValue[0]);

      final item = CustomReCardItem(
        material: receivingMaterial,
        id: receivingCardID,
      );

      currentReCard.insert(0, item);

      controller.emit(controller.state.copyWith(
          listReCard: currentReCard,
          receivingCardData:
              '1;0;;;1;0;0;0;VV01;11:54:14;;;TPD5ZA00431;;;string;K231114006;;;;11/23/2023 12:00:00 AM;VE090;THIÊN QUANG;;;;0;11/23/2023 11:54:14 AM;2012757;;'));

      // Act
      await controller.addReceivingCard(
          '1;0;;;1;0;0;0;VV01;11:54:14;;;TPD5ZA00431;;;string;K231114006;;;;11/23/2023 12:00:00 AM;VE090;THIÊN QUANG;;;;0;11/23/2023 11:54:14 AM;2012757;;');

      // Assert
      expect(controller.state.receivingCardData,
          '1;0;;;1;0;0;0;VV01;11:54:14;;;TPD5ZA00431;;;string;K231114006;;;;11/23/2023 12:00:00 AM;VE090;THIÊN QUANG;;;;0;11/23/2023 11:54:14 AM;2012757;;');
      expect(controller.state.listReCard, isNotNull);
    });

    test('add Receiving card when re_card invalid', () async {
      // Arrange

      // Act
      await expectLater(
        () async => controller.addReceivingCard('1111'),
        throwsA(isA<ValidationError>()),
      );

      // Assert
    });
  });

  group('Create Input Location', () {
    test('create combine pallet success', () async {
      // Arrange
      final response = [
        ReceivingCardModel(),
        ReceivingCardModel(),
      ];

      when(() => apiService.createInputLocation(any()))
          .thenAnswer((invocation) async => response);

      // Act

      // Assert
      expect(controller.state.palletData, isNull);
      expect(controller.state.listReCard, isNull);
      expect(controller.state.receivingCardData, isNull);
    });
  });

  group('Clear Data', () {
    test('clear all', () {
      // Arrange

      // Act
      controller.clearData();

      // Assert
      expect(controller.state.palletData, isNull);
      expect(controller.state.listReCard, isNull);
      expect(controller.state.receivingCardData, isNull);
    });
  });
}
