import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/utils/storage_manager.dart';
import 'package:smart_warehouse/views/pages/home/home_controller.dart';

class MockApiService extends Mock implements ApiService {}

class MockStorageManager extends Mock implements StorageManager {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ApiService apiService;
  late StorageManager storageManager;
  late HomeController controller;

  setUpAll(() {
    apiService = MockApiService();
    storageManager = MockStorageManager();
    controller = HomeController(storageManager, apiService);
  });
  group('Init Data', () {
    test('initData sets username and pageStatus', () async {
      // Arrange
      when(() => storageManager.get<String>(StorageKeys.userFullName))
          .thenReturn('Nguyen Van A');

      // Act
      await controller.initData();

      // Assert
      expect(controller.state.userId, 'Nguyen Van A');
      expect(controller.state.pageStatus, PageStatus.loaded);
    });
  });

  group('Logout', () {
    test('Logout success', () async {
      // Arrange
      when(() => apiService.logout()).thenAnswer((_) async {});

      // Act
      await controller.logout();

      // Assert
      verify(() => apiService.logout()).called(1);
      verify(() => storageManager.invoke(StorageKeys.accessToken)).called(1);
    });

    test('Logout: Call api logout fail', () async {
      // Arrange
      when(() => apiService.logout()).thenThrow(ServerError(message: 'Not have token'));

      // Act
      await expectLater(() async => controller.logout(), throwsA(isA<ServerError>()));

      // Assert
      verify(() => apiService.logout()).called(1);
      verify(() => storageManager.invoke(StorageKeys.accessToken)).called(1);
      expect(controller.state.errorEntity, null);
    });
  });
}
