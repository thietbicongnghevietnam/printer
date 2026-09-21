import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_warehouse/entities/ta_re_card_item.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/models/request/combine_pallet_request_model.dart';
import 'package:smart_warehouse/services/models/request/receiving_card_model.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/views/pages/temporary_area/combine_recard/move_receiving_card_controller.dart';

class MockApiService extends Mock implements ApiService {}

class FakeCombinePalletRequestModel extends Fake
    implements CombinePalletRequestModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ApiService apiService;
  late CombinePalletController controller;

  setUp(() {
    apiService = MockApiService();
    controller = CombinePalletController(apiService);

    registerFallbackValue(FakeCombinePalletRequestModel());
  });

  group('Update Pallet Source', () {
    test('Update pallet source when pallet valid', () async {
      // Arrange
      controller.emit(controller.state.copyWith(palletEnd: 'PL100'));

      // Act
      await controller.updateBlockSource('PL199');

      // Assert
      expect(controller.state.palletSource, 'PL199');
    });

    test('Update pallet source when pallet invalid', () async {
      // Arrange

      // Act
      await expectLater(
        () async => controller.updateBlockSource('1111'),
        throwsA(isA<ValidationError>()),
      );

      // Assert
    });

    test('Update pallet source same with pallet end', () async {
      // Arrange
      controller.emit(controller.state.copyWith(palletSource: 'PL199'));

      // Act
      await expectLater(
        () async => controller.updateBlockEnd('PL199'),
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
      final receivingMaterial = splitPDAValue[12];
      final receivingCardID = int.parse(splitPDAValue[0]);

      final item = CustomReCardItem(
        material: receivingMaterial,
        id: receivingCardID,
      );

      currentReCard.insert(0, item);

      controller.emit(controller.state.copyWith(
          listReCard: currentReCard,
          currentReCard:
              '1;0;;;1;0;0;0;VV01;11:54:14;;;TPD5ZA00431;;;string;K231114006;;;;11/23/2023 12:00:00 AM;VE090;THIÊN QUANG;;;;0;11/23/2023 11:54:14 AM;2012757;;'));

      // Act
      await controller.scanReceivingCard(
          '1;0;;;1;0;0;0;VV01;11:54:14;;;TPD5ZA00431;;;string;K231114006;;;;11/23/2023 12:00:00 AM;VE090;THIÊN QUANG;;;;0;11/23/2023 11:54:14 AM;2012757;;');

      // Assert
      expect(controller.state.currentReCard,
          '1;0;;;1;0;0;0;VV01;11:54:14;;;TPD5ZA00431;;;string;K231114006;;;;11/23/2023 12:00:00 AM;VE090;THIÊN QUANG;;;;0;11/23/2023 11:54:14 AM;2012757;;');
      expect(controller.state.listReCard, isNotNull);
    });

    test('add Receiving card when re_card invalid', () async {
      // Arrange

      // Act
      await expectLater(
        () async => controller.scanReceivingCard('1111'),
        throwsA(isA<ValidationError>()),
      );

      // Assert
    });
  });

  group('Added Pallet End', () {
    test('Update pallet end when pallet valid', () async {
      // Arrange
      controller.emit(controller.state.copyWith(palletEnd: 'PL100'));

      // Act
      await controller.updateBlockEnd('PL199');

      // Assert
      expect(controller.state.palletEnd, 'PL199');
    });

    test('Update pallet source when pallet invalid', () async {
      // Arrange

      // Act
      await expectLater(
        () async => controller.updateBlockEnd('1111'),
        throwsA(isA<ValidationError>()),
      );

      // Assert
    });

    test('Update pallet end same with pallet source', () async {
      // Arrange
      controller.emit(controller.state.copyWith(palletSource: 'PL199'));

      // Act
      await expectLater(
        () async => controller.updateBlockEnd('PL199'),
        throwsA(isA<ValidationError>()),
      );

      // Assert
    });
  });

  group('Create Combine Pallet', () {
    test('create combine pallet success', () async {
      // Arrange
      final response = [
        ReceivingCardModel(),
        ReceivingCardModel(),
      ];

      when(() => apiService.createCombinePallet(any()))
          .thenAnswer((invocation) async => response);

      // Act

      // Assert
      expect(controller.state.palletSource, isNull);
      expect(controller.state.palletEnd, isNull);
      expect(controller.state.listReCard, isNull);
      expect(controller.state.currentReCard, isNull);
    });
  });

  group('Clear Data', () {
    test('clear all', () {
      // Arrange

      // Act
      controller.clearData();

      // Assert
      expect(controller.state.palletSource, isNull);
      expect(controller.state.palletEnd, isNull);
      expect(controller.state.listReCard, isNull);
      expect(controller.state.currentReCard, isNull);
    });
  });
}
