import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/models/request/login_request_model.dart';
import 'package:smart_warehouse/services/models/response/login_response_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/utils/package_info_manager.dart';
import 'package:smart_warehouse/shared/utils/storage_manager.dart';
import 'package:smart_warehouse/views/pages/login/login_controller.dart';

class MockApiService extends Mock implements ApiService {}

class MockStorageManager extends Mock implements StorageManager {}

class MockPackageInfoManager extends Mock implements PackageInfoManager {}

class FakeLoginRequestModel extends Fake implements LoginRequestModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ApiService apiService;
  late StorageManager storageManager;
  late LoginController controller;
  late PackageInfoManager packageInfoManager;

  setUpAll(() {
    apiService = MockApiService();
    storageManager = MockStorageManager();
    packageInfoManager = MockPackageInfoManager();
    controller =
        LoginController(apiService, storageManager, packageInfoManager);
    registerFallbackValue(FakeLoginRequestModel());
  });
  group('Init Data', () {
    test('initData sets version and pageStatus', () async {
      // Arrange
      when(() => packageInfoManager.getVersion())
          .thenAnswer((_) async => '1.0.0');

      // Act
      await controller.initData();

      // Assert
      expect(controller.state.version, '1.0.0');
      expect(controller.state.pageStatus, PageStatus.loaded);
    });
  });

  group('Login', () {
    // Test login method
    test('Login success', () async {
      // Arrange
      const response =
      LoginResponseModel(assessToken: '123456', userFullName: 'Tran Van A');
      when(() => apiService.login(any()))
          .thenAnswer((invocation) async => response);

      // Act
      final result = await controller.login('1111');

      // Assert
      expect(result, true);
      verify(() => storageManager.set(StorageKeys.userFullName, response.userFullName))
          .called(1);
      verify(() => storageManager.set(StorageKeys.accessToken, response.assessToken))
          .called(1);
    });

    test('Login fail', () async {
      // Arrange
      final error = ServerError(message: 'Login Fail');
      when(() => apiService.login(any())).thenThrow(error);

      // Act
      await expectLater(() async => controller.login('1111'), throwsA(isA<ServerError>()));

      // Assert
      expect(controller.state.errorEntity, error);
    });
  });
}
