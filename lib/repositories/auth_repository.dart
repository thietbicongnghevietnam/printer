import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/enums/role.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/models/request/login_request_model.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/shared/utils/storage_manager.dart';

@singleton
class AuthRepository {
  AuthRepository(this._apiService, this._storageManager);

  final ApiService _apiService;
  final StorageManager _storageManager;

  Future<bool> login(String id) async {
    final response = await _apiService.login(LoginRequestModel(userId: id));
    _storageManager.set(StorageKeys.userFullName, response.userFullName);
    _storageManager.set(StorageKeys.accessToken, response.assessToken);
    _storageManager.set(StorageKeys.roles, response.pdaRole);
    _storageManager.set<bool>(StorageKeys.isAdmin, response.positionUserID == 1);
    _storageManager.set(StorageKeys.id, response.userID);
    return true;
  }

  Future<void> logout() async {
    try {
      await _apiService.logout();
    } catch (_) {
      rethrow;
    } finally {
      _storageManager.invoke(StorageKeys.accessToken);
      _storageManager.invoke(StorageKeys.userFullName);
      _storageManager.invoke(StorageKeys.roles);
    }
  }

  Future<String> getUsername() async {
    return _storageManager.get<String>(StorageKeys.userFullName) ?? '';
  }
  //2026
  Future<String> getUserID() async {
    return _storageManager.get<String>(StorageKeys.id) ?? '';
  }

  Future<List<Role>> getRoles() async {
    final roles = _storageManager.get<String>(StorageKeys.roles) ?? '';
    final isAdmin = _storageManager.get<bool>(StorageKeys.isAdmin) ?? false;
    return isAdmin ? Role.values : roles.split(';').where((e) => e != '').map((e) => Role.fromCode(e)).toList();
  }
}
