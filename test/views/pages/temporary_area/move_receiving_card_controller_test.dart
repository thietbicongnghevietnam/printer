import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/models/request/combine_pallet_request_model.dart';
import 'package:smart_warehouse/services/models/request/receiving_card_model.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/views/pages/temporary_area/move_receiving_card/move_pallet_controller.dart';

class MockApiService extends Mock implements ApiService {}

class MoveReceivingCardRequestModel extends Fake
    implements CombinePalletRequestModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ApiService apiService;
  late MovePalletController controller;

  setUp(() {
    apiService = MockApiService();
    controller = MovePalletController(apiService);

    registerFallbackValue(MoveReceivingCardRequestModel());
  });

  group('Update Pallet Source', () {
    test('Update pallet source when pallet valid', () async {
      // Arrange
      controller.emit(controller.state.copyWith(palletSource: 'PL100'));

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
      controller.emit(controller.state.copyWith(palletEnd: 'PL199'));

      // Act
      await expectLater(
        () async => controller.updateBlockSource('PL199'),
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

  group('Create Move Receiving Card', () {
    test('create move receiving card success', () async {
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
    });
  });
}
