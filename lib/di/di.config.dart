// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:smart_warehouse/di/flavor_module.dart' as _i435;
import 'package:smart_warehouse/di/network_module.dart' as _i843;
import 'package:smart_warehouse/di/storage_module.dart' as _i1012;
import 'package:smart_warehouse/flavor_settings.dart' as _i796;
import 'package:smart_warehouse/repositories/app_repository.dart' as _i747;
import 'package:smart_warehouse/repositories/auth_repository.dart' as _i31;
import 'package:smart_warehouse/repositories/barcode_repository.dart' as _i823;
import 'package:smart_warehouse/repositories/delivery_plan_repository.dart'
    as _i200;
import 'package:smart_warehouse/repositories/emap_repository.dart' as _i289;
import 'package:smart_warehouse/repositories/inventory_repository.dart'
    as _i798;
import 'package:smart_warehouse/repositories/kitting_repository.dart' as _i706;
import 'package:smart_warehouse/repositories/master_repository.dart' as _i53;
import 'package:smart_warehouse/repositories/material_repository.dart' as _i518;
import 'package:smart_warehouse/repositories/receiving_card_item_repository.dart'
    as _i1000;
import 'package:smart_warehouse/repositories/receiving_card_repository.dart'
    as _i679;
import 'package:smart_warehouse/repositories/storing_repository.dart' as _i390;
import 'package:smart_warehouse/repositories/supply_repository.dart' as _i682;
import 'package:smart_warehouse/repositories/temporary_area_repository.dart'
    as _i1053;
import 'package:smart_warehouse/services/api_service.dart' as _i812;
import 'package:smart_warehouse/shared/utils/alert.dart' as _i975;
import 'package:smart_warehouse/shared/utils/camera_manager.dart' as _i850;
import 'package:smart_warehouse/shared/utils/map_asset_icons.dart' as _i833;
import 'package:smart_warehouse/shared/utils/package_info_manager.dart'
    as _i986;
import 'package:smart_warehouse/shared/utils/plant_master_data.dart' as _i451;
import 'package:smart_warehouse/shared/utils/storage_manager.dart' as _i617;
import 'package:smart_warehouse/subsystem/pda/pda.dart' as _i101;
import 'package:smart_warehouse/subsystem/pda/zebra_pda.dart' as _i399;
import 'package:smart_warehouse/subsystem/printer/printer.dart' as _i238;
import 'package:smart_warehouse/subsystem/printer/sato_printer.dart' as _i453;
import 'package:smart_warehouse/views/pages/emap/floor_detail/floor_detail_controller.dart'
    as _i1057;
import 'package:smart_warehouse/views/pages/emap/new_map_floor/new_map_floor_controller.dart'
    as _i773;
import 'package:smart_warehouse/views/pages/emap/new_map_zone/new_map_zone_controller.dart'
    as _i212;
import 'package:smart_warehouse/views/pages/emap/pallet_detail/pallet_detail_controller.dart'
    as _i30;
import 'package:smart_warehouse/views/pages/emap/rack_detail/rack_detail_controller.dart'
    as _i766;
import 'package:smart_warehouse/views/pages/emap/trolley_map_html/trolley_map_html_controller.dart'
    as _i826;
import 'package:smart_warehouse/views/pages/emap/zone_detail/zone_detail_controller.dart'
    as _i544;
import 'package:smart_warehouse/views/pages/home/home_controller.dart'
    as _i1050;
import 'package:smart_warehouse/views/pages/inventory/balance_all/balance_all_controller.dart'
    as _i278;
import 'package:smart_warehouse/views/pages/inventory/balance_rc/balance_rc_controller.dart'
    as _i90;
import 'package:smart_warehouse/views/pages/inventory/check_rc_on_location/check_rc_on_location_controller.dart'
    as _i999;
import 'package:smart_warehouse/views/pages/kitting/check_list_kitting/components/check_list_kitting_detail_controller.dart'
    as _i460;
import 'package:smart_warehouse/views/pages/kitting/components/barcode_scanned_controller.dart'
    as _i840;
import 'package:smart_warehouse/views/pages/kitting/emap_kitting/emap_kitting_controller.dart'
    as _i49;
import 'package:smart_warehouse/views/pages/kitting/find_kitting_list/find_kitting_list_controller.dart'
    as _i578;
import 'package:smart_warehouse/views/pages/kitting/kitting/kitting_controller.dart'
    as _i747;
import 'package:smart_warehouse/views/pages/kitting/kitting_model/kitting_model_controller.dart'
    as _i849;
import 'package:smart_warehouse/views/pages/kitting/kitting_trolley/change_trolley/change_trolley_controller.dart'
    as _i849;
import 'package:smart_warehouse/views/pages/kitting/kitting_trolley/check_trolley/check_trolley_controller.dart'
    as _i972;
import 'package:smart_warehouse/views/pages/kitting/kitting_trolley/input_trolley/input_trolley_controller.dart'
    as _i981;
import 'package:smart_warehouse/views/pages/kitting/kitting_trolley/out_trolley/out_trolley_controller.dart'
    as _i949;
import 'package:smart_warehouse/views/pages/kitting/return_kitting/return_kitting_controller.dart'
    as _i28;
import 'package:smart_warehouse/views/pages/kitting/revert_kitting/revert_kitting_controller.dart'
    as _i818;
import 'package:smart_warehouse/views/pages/kitting/supply_kitting/supply_kitting_controller.dart'
    as _i880;
import 'package:smart_warehouse/views/pages/login/login_controller.dart'
    as _i770;
import 'package:smart_warehouse/views/pages/one_for_all/one_for_all_controller.dart'
    as _i206;
import 'package:smart_warehouse/views/pages/receiving/check_barcode_lack/check_barcode_lack_controller.dart'
    as _i573;
import 'package:smart_warehouse/views/pages/receiving/da_invoice/da_invoice_controller.dart'
    as _i178;
import 'package:smart_warehouse/views/pages/receiving/have_barcode/gr_have_barcode_controller.dart'
    as _i408;
import 'package:smart_warehouse/views/pages/receiving/list_box_card/list_box_card_controller.dart'
    as _i1040;
import 'package:smart_warehouse/views/pages/receiving/no_barcode/gr_no_barcode_controller.dart'
    as _i417;
import 'package:smart_warehouse/views/pages/receiving/open_good_receipt/open_good_receipt_controller.dart'
    as _i319;
import 'package:smart_warehouse/views/pages/receiving/receiving_card_list/receiving_card_list_controller.dart'
    as _i220;
import 'package:smart_warehouse/views/pages/receiving/reprint_barcode_ng/reprint_barcode_ng_controller.dart'
    as _i867;
import 'package:smart_warehouse/views/pages/receiving/reprint_receiving_card/reprint_receiving_card_controller.dart'
    as _i828;
import 'package:smart_warehouse/views/pages/receiving/select_da_invoice/select_da_invoice_controller.dart'
    as _i488;
import 'package:smart_warehouse/views/pages/storing/change_store_location/change_store_location_controller.dart'
    as _i846;
import 'package:smart_warehouse/views/pages/storing/check_block_data/check_block_data_controller.dart'
    as _i1012;
import 'package:smart_warehouse/views/pages/storing/check_last_lot/check_last_lot_controller.dart'
    as _i925;
import 'package:smart_warehouse/views/pages/storing/check_material/check_material_in_store_controller.dart'
    as _i1028;
import 'package:smart_warehouse/views/pages/storing/find_barcode_lost/find_barcode_lost_controller.dart'
    as _i941;
import 'package:smart_warehouse/views/pages/storing/iqc_borrow_receiving_card/iqc_borrow_receiving_card_controller.dart'
    as _i865;
import 'package:smart_warehouse/views/pages/storing/list_borrow_item/list_borrow_item_controller.dart'
    as _i359;
import 'package:smart_warehouse/views/pages/storing/material_history_transition/material_history_transition_controller.dart'
    as _i923;
import 'package:smart_warehouse/views/pages/storing/out_storage/out_storage_controller.dart'
    as _i153;
import 'package:smart_warehouse/views/pages/storing/position/material_position_controller.dart'
    as _i915;
import 'package:smart_warehouse/views/pages/storing/reprint_rc_convert/reprint_rc_convert_controller.dart'
    as _i810;
import 'package:smart_warehouse/views/pages/storing/sample/material_sample_controller.dart'
    as _i803;
import 'package:smart_warehouse/views/pages/storing/split_receiving_card/split_receiving_card_controller.dart'
    as _i1012;
import 'package:smart_warehouse/views/pages/storing/stock_to_receiving_card/stock_to_receiving_card_controller.dart'
    as _i1055;
import 'package:smart_warehouse/views/pages/storing/storage/storage_rc_card_controller.dart'
    as _i675;
import 'package:smart_warehouse/views/pages/storing/storage_borrow_item/storage_borrow_item_controller.dart'
    as _i332;
import 'package:smart_warehouse/views/pages/storing/storage_jupiter/storage_jupiter_controller.dart'
    as _i219;
import 'package:smart_warehouse/views/pages/temporary_area/input_location/input_location_controller.dart'
    as _i700;
import 'package:smart_warehouse/views/pages/temporary_area/move_receiving_card/move_receiving_card_controller.dart'
    as _i810;
import 'package:smart_warehouse/views/pages/temporary_area/out_receiving_card/out_receiving_card_controller.dart'
    as _i96;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final flavorModule = _$FlavorModule();
    final storageModule = _$StorageModule();
    final networkModule = _$NetworkModule();
    await gh.factoryAsync<_i796.FlavorSettings>(
      () => flavorModule.getFlavorSettings(),
      preResolve: true,
    );
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => storageModule.getSharedPreferences,
      preResolve: true,
    );
    gh.factory<_i840.BarcodeScannedController>(
        () => _i840.BarcodeScannedController());
    gh.factory<_i972.CheckTrolleyController>(
        () => _i972.CheckTrolleyController());
    gh.factory<_i1040.ListBoxCardController>(
        () => _i1040.ListBoxCardController());
    gh.singleton<_i361.Dio>(() => networkModule.getDio());
    gh.singleton<_i975.AppAlertDialog>(() => _i975.AppAlertDialog());
    gh.singleton<_i850.CameraManager>(() => _i850.CameraManager());
    gh.singleton<_i833.MapAssetIcons>(() => _i833.MapAssetIcons());
    gh.singleton<_i986.PackageInfoManager>(() => _i986.PackageInfoManager());
    gh.singleton<_i451.PlantMasterData>(() => _i451.PlantMasterData());
    gh.factory<_i101.PdaDevice>(() => _i399.ZebraPda());
    gh.singleton<_i238.Printer>(() => _i453.SatoPrinter());
    gh.singleton<_i812.ApiService>(() => networkModule.getService(
          gh<_i361.Dio>(),
          gh<_i796.FlavorSettings>(),
        ));
    gh.singleton<_i617.StorageManager>(
        () => _i617.StorageManager(gh<_i460.SharedPreferences>()));
    gh.singleton<_i31.AuthRepository>(() => _i31.AuthRepository(
          gh<_i812.ApiService>(),
          gh<_i617.StorageManager>(),
        ));
    gh.singleton<_i53.MasterRepository>(() => _i53.MasterRepository(
          gh<_i812.ApiService>(),
          gh<_i617.StorageManager>(),
        ));
    gh.factory<_i823.BarCodeRepository>(
        () => _i823.BarCodeRepository(gh<_i812.ApiService>()));
    gh.factory<_i200.DeliveryPlanRepository>(
        () => _i200.DeliveryPlanRepository(gh<_i812.ApiService>()));
    gh.factory<_i289.EMapRepository>(
        () => _i289.EMapRepository(gh<_i812.ApiService>()));
    gh.factory<_i706.KittingRepository>(
        () => _i706.KittingRepository(gh<_i812.ApiService>()));
    gh.factory<_i518.MaterialRepository>(
        () => _i518.MaterialRepository(gh<_i812.ApiService>()));
    gh.factory<_i1000.ReceivingCardItemRepository>(
        () => _i1000.ReceivingCardItemRepository(gh<_i812.ApiService>()));
    gh.factory<_i679.ReceivingCardRepository>(
        () => _i679.ReceivingCardRepository(gh<_i812.ApiService>()));
    gh.factory<_i390.StoringRepository>(
        () => _i390.StoringRepository(gh<_i812.ApiService>()));
    gh.factory<_i682.SupplyRepository>(
        () => _i682.SupplyRepository(gh<_i812.ApiService>()));
    gh.factory<_i1053.TemporaryAreaRepository>(
        () => _i1053.TemporaryAreaRepository(gh<_i812.ApiService>()));
    gh.factory<_i1012.CheckBlockDataController>(
        () => _i1012.CheckBlockDataController(gh<_i812.ApiService>()));
    gh.factory<_i925.CheckLastLotController>(
        () => _i925.CheckLastLotController(gh<_i812.ApiService>()));
    gh.factory<_i700.InputLocationController>(
        () => _i700.InputLocationController(
              gh<_i679.ReceivingCardRepository>(),
              gh<_i1053.TemporaryAreaRepository>(),
            ));
    gh.factory<_i810.MoveReceivingCardController>(
        () => _i810.MoveReceivingCardController(
              gh<_i679.ReceivingCardRepository>(),
              gh<_i1053.TemporaryAreaRepository>(),
            ));
    gh.singleton<_i747.AppRepository>(() => _i747.AppRepository(
          gh<_i986.PackageInfoManager>(),
          gh<_i812.ApiService>(),
        ));
    gh.factory<_i460.CheckListKittingDetailController>(() =>
        _i460.CheckListKittingDetailController(gh<_i706.KittingRepository>()));
    gh.factory<_i798.InventoryRepository>(
        () => _i798.InventoryRepository(gh<_i812.ApiService>()));
    gh.factory<_i849.ChangeTrolleyController>(
        () => _i849.ChangeTrolleyController(gh<_i682.SupplyRepository>()));
    gh.factory<_i981.InputTrolleyController>(
        () => _i981.InputTrolleyController(gh<_i682.SupplyRepository>()));
    gh.factory<_i949.OutTrolleyController>(
        () => _i949.OutTrolleyController(gh<_i682.SupplyRepository>()));
    gh.factory<_i867.ReprintBarcodeNGController>(
        () => _i867.ReprintBarcodeNGController(
              gh<_i53.MasterRepository>(),
              gh<_i823.BarCodeRepository>(),
            ));
    gh.factory<_i865.IQCBorrowReceivingCardController>(
        () => _i865.IQCBorrowReceivingCardController(
              gh<_i679.ReceivingCardRepository>(),
              gh<_i390.StoringRepository>(),
            ));
    gh.factory<_i220.ReceivingCardListController>(
        () => _i220.ReceivingCardListController(
              gh<_i679.ReceivingCardRepository>(),
              gh<_i53.MasterRepository>(),
            ));
    gh.factory<_i828.ReprintReceivingCardController>(
        () => _i828.ReprintReceivingCardController(
              gh<_i679.ReceivingCardRepository>(),
              gh<_i53.MasterRepository>(),
            ));
    gh.factory<_i810.RePrintRcConvertController>(
        () => _i810.RePrintRcConvertController(
              gh<_i679.ReceivingCardRepository>(),
              gh<_i53.MasterRepository>(),
            ));
    gh.factory<_i206.OneForAllController>(() => _i206.OneForAllController(
          gh<_i679.ReceivingCardRepository>(),
          gh<_i706.KittingRepository>(),
        ));
    gh.factory<_i999.CheckRcOnLocationController>(() =>
        _i999.CheckRcOnLocationController(gh<_i798.InventoryRepository>()));
    gh.factory<_i573.CheckBarcodeLackController>(() =>
        _i573.CheckBarcodeLackController(gh<_i679.ReceivingCardRepository>()));
    gh.factory<_i49.EmapKittingController>(() => _i49.EmapKittingController(
          gh<_i706.KittingRepository>(),
          gh<_i289.EMapRepository>(),
          gh<_i53.MasterRepository>(),
        ));
    gh.factory<_i941.FindBarcodeLostController>(
        () => _i941.FindBarcodeLostController(
              gh<_i53.MasterRepository>(),
              gh<_i823.BarCodeRepository>(),
              gh<_i679.ReceivingCardRepository>(),
            ));
    gh.factory<_i818.RevertKittingController>(
        () => _i818.RevertKittingController(
              gh<_i706.KittingRepository>(),
              gh<_i53.MasterRepository>(),
            ));
    gh.factory<_i773.NewMapFloorController>(() => _i773.NewMapFloorController(
          gh<_i289.EMapRepository>(),
          gh<_i706.KittingRepository>(),
        ));
    gh.factory<_i1050.HomeController>(() => _i1050.HomeController(
          gh<_i31.AuthRepository>(),
          gh<_i53.MasterRepository>(),
          gh<_i747.AppRepository>(),
        ));
    gh.factory<_i1028.CheckMaterialInStoreController>(
        () => _i1028.CheckMaterialInStoreController(
              gh<_i390.StoringRepository>(),
              gh<_i679.ReceivingCardRepository>(),
            ));
    gh.factory<_i675.StorageRCCardController>(
        () => _i675.StorageRCCardController(
              gh<_i390.StoringRepository>(),
              gh<_i679.ReceivingCardRepository>(),
            ));
    gh.factory<_i747.KittingController>(() => _i747.KittingController(
          gh<_i706.KittingRepository>(),
          gh<_i679.ReceivingCardRepository>(),
          gh<_i53.MasterRepository>(),
          gh<_i390.StoringRepository>(),
        ));
    gh.factory<_i408.GRHaveBarcodeController>(
        () => _i408.GRHaveBarcodeController(
              gh<_i679.ReceivingCardRepository>(),
              gh<_i200.DeliveryPlanRepository>(),
              gh<_i53.MasterRepository>(),
              gh<_i518.MaterialRepository>(),
              gh<_i823.BarCodeRepository>(),
            ));
    gh.factory<_i880.SupplyKittingController>(
        () => _i880.SupplyKittingController(
              gh<_i682.SupplyRepository>(),
              gh<_i706.KittingRepository>(),
            ));
    gh.factory<_i1012.SplitReceivingCardController>(
        () => _i1012.SplitReceivingCardController(
              gh<_i679.ReceivingCardRepository>(),
              gh<_i798.InventoryRepository>(),
              gh<_i53.MasterRepository>(),
            ));
    gh.factory<_i488.SelectDAInvoiceController>(
        () => _i488.SelectDAInvoiceController(
              gh<_i53.MasterRepository>(),
              gh<_i200.DeliveryPlanRepository>(),
            ));
    gh.factory<_i417.GRNoBarcodeController>(() => _i417.GRNoBarcodeController(
          gh<_i679.ReceivingCardRepository>(),
          gh<_i200.DeliveryPlanRepository>(),
          gh<_i53.MasterRepository>(),
          gh<_i518.MaterialRepository>(),
        ));
    gh.factory<_i28.ReturnKittingController>(() => _i28.ReturnKittingController(
          gh<_i706.KittingRepository>(),
          gh<_i390.StoringRepository>(),
          gh<_i679.ReceivingCardRepository>(),
          gh<_i53.MasterRepository>(),
        ));
    gh.factory<_i846.ChangeStoreLocationController>(() =>
        _i846.ChangeStoreLocationController(gh<_i390.StoringRepository>()));
    gh.factory<_i359.ListBorrowItemController>(
        () => _i359.ListBorrowItemController(gh<_i390.StoringRepository>()));
    gh.factory<_i923.MaterialHistoryTransitionController>(() =>
        _i923.MaterialHistoryTransitionController(
            gh<_i390.StoringRepository>()));
    gh.factory<_i153.OutStorageController>(
        () => _i153.OutStorageController(gh<_i390.StoringRepository>()));
    gh.factory<_i915.MaterialPositionController>(
        () => _i915.MaterialPositionController(gh<_i390.StoringRepository>()));
    gh.factory<_i803.MaterialSampleController>(
        () => _i803.MaterialSampleController(gh<_i390.StoringRepository>()));
    gh.factory<_i332.StorageBorrowItemController>(
        () => _i332.StorageBorrowItemController(gh<_i390.StoringRepository>()));
    gh.factory<_i766.RackDetailController>(
        () => _i766.RackDetailController(gh<_i289.EMapRepository>()));
    gh.factory<_i826.TrolleyMapHTMLController>(
        () => _i826.TrolleyMapHTMLController(gh<_i289.EMapRepository>()));
    gh.factory<_i96.OutReceivingCardController>(
        () => _i96.OutReceivingCardController(
              gh<_i1053.TemporaryAreaRepository>(),
              gh<_i679.ReceivingCardRepository>(),
            ));
    gh.factory<_i319.OpenGoodReceiptController>(
        () => _i319.OpenGoodReceiptController(
              gh<_i679.ReceivingCardRepository>(),
              gh<_i53.MasterRepository>(),
              gh<_i518.MaterialRepository>(),
            ));
    gh.factory<_i770.LoginController>(() => _i770.LoginController(
          gh<_i31.AuthRepository>(),
          gh<_i747.AppRepository>(),
        ));
    gh.factory<_i578.FindKittingListController>(
        () => _i578.FindKittingListController(gh<_i706.KittingRepository>()));
    gh.factory<_i849.KittingModelController>(() => _i849.KittingModelController(
          gh<_i706.KittingRepository>(),
          gh<_i53.MasterRepository>(),
          gh<_i798.InventoryRepository>(),
        ));
    gh.factory<_i278.BalanceAllController>(() => _i278.BalanceAllController(
          gh<_i798.InventoryRepository>(),
          gh<_i679.ReceivingCardRepository>(),
        ));
    gh.factory<_i90.BalanceRcController>(() => _i90.BalanceRcController(
          gh<_i798.InventoryRepository>(),
          gh<_i679.ReceivingCardRepository>(),
        ));
    gh.factory<_i1055.StockToReceivingCardController>(
        () => _i1055.StockToReceivingCardController(
              gh<_i390.StoringRepository>(),
              gh<_i53.MasterRepository>(),
            ));
    gh.factory<_i178.DAInvoiceController>(
        () => _i178.DAInvoiceController(gh<_i200.DeliveryPlanRepository>()));
    gh.factory<_i219.StorageJupiterController>(
        () => _i219.StorageJupiterController(
              gh<_i679.ReceivingCardRepository>(),
              gh<_i390.StoringRepository>(),
            ));
    gh.factory<_i1057.FloorDetailController>(
        () => _i1057.FloorDetailController(gh<_i289.EMapRepository>()));
    gh.factory<_i212.NewMapZoneController>(
        () => _i212.NewMapZoneController(gh<_i289.EMapRepository>()));
    gh.factory<_i30.PalletDetailController>(
        () => _i30.PalletDetailController(gh<_i289.EMapRepository>()));
    gh.factory<_i544.ZoneDetailController>(
        () => _i544.ZoneDetailController(gh<_i289.EMapRepository>()));
    return this;
  }
}

class _$FlavorModule extends _i435.FlavorModule {}

class _$StorageModule extends _i1012.StorageModule {}

class _$NetworkModule extends _i843.NetworkModule {}
