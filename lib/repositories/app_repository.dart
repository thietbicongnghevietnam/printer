import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/utils/package_info_manager.dart';

@singleton
class AppRepository {
  AppRepository(this._packageInfoManager, this._apiService);

  final ApiService _apiService;

  final PackageInfoManager _packageInfoManager;

  Future<String> getVersion() => _packageInfoManager.getVersion();

  Future<String?> checkVersion() {
    return _apiService.getVersionApp();
  }
}
