// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i65;
import 'package:flutter/material.dart' as _i68;
import 'package:smart_warehouse/entities/barcode/barcode.dart' as _i66;
import 'package:smart_warehouse/entities/delivery_plan.dart' as _i67;
import 'package:smart_warehouse/entities/e_map/emap_zone.dart' as _i76;
import 'package:smart_warehouse/entities/e_map/order_block.dart' as _i72;
import 'package:smart_warehouse/entities/e_map/suggest_path.dart' as _i73;
import 'package:smart_warehouse/entities/kitting/kitting_detail.dart' as _i71;
import 'package:smart_warehouse/entities/receiving_card.dart' as _i69;
import 'package:smart_warehouse/entities/receiving_card_item.dart' as _i70;
import 'package:smart_warehouse/enums/delivery_type.dart' as _i78;
import 'package:smart_warehouse/enums/emap_navigate_funciton.dart' as _i74;
import 'package:smart_warehouse/enums/kitting_type.dart' as _i75;
import 'package:smart_warehouse/enums/rack_type.dart' as _i77;
import 'package:smart_warehouse/views/pages/emap/floor_detail/floor_detail_page.dart'
    as _i19;
import 'package:smart_warehouse/views/pages/emap/new_map_floor/new_map_floor_page.dart'
    as _i38;
import 'package:smart_warehouse/views/pages/emap/new_map_zone/new_map_zone_page.dart'
    as _i39;
import 'package:smart_warehouse/views/pages/emap/pallet_detail/pallet_detail_page.dart'
    as _i45;
import 'package:smart_warehouse/views/pages/emap/rack_detail/rack_detail_page.dart'
    as _i46;
import 'package:smart_warehouse/views/pages/emap/trolley_map_html/trolley_map_html_page.dart'
    as _i63;
import 'package:smart_warehouse/views/pages/emap/zone_detail/zone_detail_page.dart'
    as _i64;
import 'package:smart_warehouse/views/pages/home/home_page.dart' as _i22;
import 'package:smart_warehouse/views/pages/inventory/balance_all/balance_all_page.dart'
    as _i1;
import 'package:smart_warehouse/views/pages/inventory/balance_rc/balance_rc_page.dart'
    as _i2;
import 'package:smart_warehouse/views/pages/inventory/check_rc_on_location/check_rc_on_location_page.dart'
    as _i12;
import 'package:smart_warehouse/views/pages/inventory/inventory_page.dart'
    as _i27;
import 'package:smart_warehouse/views/pages/iqc/iqc_menu_page.dart' as _i24;
import 'package:smart_warehouse/views/pages/kitting/check_list_kitting/components/check_list_kitting_detail_page.dart'
    as _i10;
import 'package:smart_warehouse/views/pages/kitting/components/barcode_scanned_page.dart'
    as _i3;
import 'package:smart_warehouse/views/pages/kitting/emap_kitting/emap_kitting_page.dart'
    as _i16;
import 'package:smart_warehouse/views/pages/kitting/find_kitting_list/find_kitting_list_page.dart'
    as _i18;
import 'package:smart_warehouse/views/pages/kitting/index/kitting_index_page.dart'
    as _i28;
import 'package:smart_warehouse/views/pages/kitting/kitting/kitting_page.dart'
    as _i30;
import 'package:smart_warehouse/views/pages/kitting/kitting_model/kitting_model_page.dart'
    as _i29;
import 'package:smart_warehouse/views/pages/kitting/kitting_trolley/change_trolley/change_trolley_page.dart'
    as _i6;
import 'package:smart_warehouse/views/pages/kitting/kitting_trolley/check_trolley/check_trolley_page.dart'
    as _i13;
import 'package:smart_warehouse/views/pages/kitting/kitting_trolley/input_trolley/input_trolley_page.dart'
    as _i26;
import 'package:smart_warehouse/views/pages/kitting/kitting_trolley/out_trolley/out_trolley_page.dart'
    as _i44;
import 'package:smart_warehouse/views/pages/kitting/return_kitting/return_kitting_page.dart'
    as _i52;
import 'package:smart_warehouse/views/pages/kitting/revert_kitting/revert_kitting_page.dart'
    as _i53;
import 'package:smart_warehouse/views/pages/kitting/supply_kitting/supply_kitting_page.dart'
    as _i61;
import 'package:smart_warehouse/views/pages/login/login_page.dart' as _i33;
import 'package:smart_warehouse/views/pages/one_for_all/one_for_all_page.dart'
    as _i40;
import 'package:smart_warehouse/views/pages/receiving/check_barcode_lack/check_barcode_lack_page.dart'
    as _i7;
import 'package:smart_warehouse/views/pages/receiving/da_invoice/da_invoice_page.dart'
    as _i14;
import 'package:smart_warehouse/views/pages/receiving/have_barcode/gr_have_barcode_page.dart'
    as _i20;
import 'package:smart_warehouse/views/pages/receiving/index/receiving_page.dart'
    as _i49;
import 'package:smart_warehouse/views/pages/receiving/list_box_card/list_box_card_page.dart'
    as _i32;
import 'package:smart_warehouse/views/pages/receiving/no_barcode/gr_no_barcode_page.dart'
    as _i21;
import 'package:smart_warehouse/views/pages/receiving/open_good_receipt/open_good_receipt_page.dart'
    as _i41;
import 'package:smart_warehouse/views/pages/receiving/receiving_card_list/receiving_card_list_page.dart'
    as _i48;
import 'package:smart_warehouse/views/pages/receiving/reprint_barcode_ng/reprint_barcode_ng_page.dart'
    as _i50;
import 'package:smart_warehouse/views/pages/receiving/reprint_receiving_card/reprint_receiving_card_page.dart'
    as _i51;
import 'package:smart_warehouse/views/pages/receiving/select_da_invoice/select_da_invoice_page.dart'
    as _i54;
import 'package:smart_warehouse/views/pages/storing/change_store_location/change_store_location_page.dart'
    as _i5;
import 'package:smart_warehouse/views/pages/storing/check_block_data/check_block_data_page.dart'
    as _i8;
import 'package:smart_warehouse/views/pages/storing/check_last_lot/check_last_lot_page.dart'
    as _i9;
import 'package:smart_warehouse/views/pages/storing/check_material/check_material_in_store_page.dart'
    as _i11;
import 'package:smart_warehouse/views/pages/storing/find_barcode_lost/find_barcode_lost_page.dart'
    as _i17;
import 'package:smart_warehouse/views/pages/storing/iqc_borrow_receiving_card/iqc_borrow_receiving_card_page.dart'
    as _i23;
import 'package:smart_warehouse/views/pages/storing/list_borrow_item/list_borrow_item_page.dart'
    as _i31;
import 'package:smart_warehouse/views/pages/storing/material_history_transition/material_history_transition_page.dart'
    as _i34;
import 'package:smart_warehouse/views/pages/storing/out_storage/out_storage_page.dart'
    as _i43;
import 'package:smart_warehouse/views/pages/storing/position/material_position_page.dart'
    as _i35;
import 'package:smart_warehouse/views/pages/storing/reprint_rc_convert/reprint_rc_convert_page.dart'
    as _i47;
import 'package:smart_warehouse/views/pages/storing/sample/material_sample_page.dart'
    as _i36;
import 'package:smart_warehouse/views/pages/storing/split_receiving_card/split_receiving_card_page.dart'
    as _i55;
import 'package:smart_warehouse/views/pages/storing/stock_to_receiving_card/stock_to_receiving_card_page.dart'
    as _i56;
import 'package:smart_warehouse/views/pages/storing/storage/storage_rc_card_page.dart'
    as _i59;
import 'package:smart_warehouse/views/pages/storing/storage_borrow_item/storage_borrow_item_page.dart'
    as _i57;
import 'package:smart_warehouse/views/pages/storing/storage_jupiter/storage_jupiter_page.dart'
    as _i58;
import 'package:smart_warehouse/views/pages/storing/storing_page.dart' as _i60;
import 'package:smart_warehouse/views/pages/temporary_area/input_location/input_location_page.dart'
    as _i25;
import 'package:smart_warehouse/views/pages/temporary_area/move_receiving_card/move_receiving_card_page.dart'
    as _i37;
import 'package:smart_warehouse/views/pages/temporary_area/out_receiving_card/out_receiving_card_page.dart'
    as _i42;
import 'package:smart_warehouse/views/pages/temporary_area/temporary_area_page.dart'
    as _i62;
import 'package:smart_warehouse/views/sub_pages/camera_capture_page.dart'
    as _i4;
import 'package:smart_warehouse/views/sub_pages/display_text_picture_page.dart'
    as _i15;

abstract class $AuthGuard extends _i65.RootStackRouter {
  $AuthGuard({super.navigatorKey});

  @override
  final Map<String, _i65.PageFactory> pagesMap = {
    BalanceAllRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i1.BalanceAllPage()),
      );
    },
    BalanceRcRoute.name: (routeData) {
      final args = routeData.argsAs<BalanceRcRouteArgs>(
          orElse: () => const BalanceRcRouteArgs());
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i2.BalanceRcPage(
          key: args.key,
          rcBarcode: args.rcBarcode,
        )),
      );
    },
    BarCodeScannedRoute.name: (routeData) {
      final args = routeData.argsAs<BarCodeScannedRouteArgs>();
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i3.BarCodeScannedPage(
          removeReceivingCardCallBack: args.removeReceivingCardCallBack,
          backToScreen: args.backToScreen,
          removePartCardCallBack: args.removePartCardCallBack,
          receivingCards: args.receivingCards,
          receivingCardItems: args.receivingCardItems,
          key: args.key,
        )),
      );
    },
    CameraCaptureRoute.name: (routeData) {
      return _i65.AutoRoutePage<String>(
        routeData: routeData,
        child: const _i4.CameraCapturePage(),
      );
    },
    ChangeStoreLocationRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i5.ChangeStoreLocationPage()),
      );
    },
    ChangeTrolleyRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i6.ChangeTrolleyPage()),
      );
    },
    CheckBarcodeLackRoute.name: (routeData) {
      final args = routeData.argsAs<CheckBarcodeLackRouteArgs>(
          orElse: () => const CheckBarcodeLackRouteArgs());
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i7.CheckBarcodeLackPage(
          key: args.key,
          barcode: args.barcode,
          scanningBarcode: args.scanningBarcode,
        )),
      );
    },
    CheckBlockDataRoute.name: (routeData) {
      final args = routeData.argsAs<CheckBlockDataRouteArgs>();
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i8.CheckBlockDataPage(
          key: args.key,
          blockName: args.blockName,
        )),
      );
    },
    CheckLastLotRoute.name: (routeData) {
      final args = routeData.argsAs<CheckLastLotRouteArgs>();
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i9.CheckLastLotPage(
          key: args.key,
          blockId: args.blockId,
        )),
      );
    },
    CheckListKittingDetailRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child:
            _i65.WrappedRoute(child: const _i10.CheckListKittingDetailPage()),
      );
    },
    CheckMaterialInStoreRoute.name: (routeData) {
      final args = routeData.argsAs<CheckMaterialInStoreRouteArgs>(
          orElse: () => const CheckMaterialInStoreRouteArgs());
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i11.CheckMaterialInStorePage(
          key: args.key,
          positionOrRc: args.positionOrRc,
        )),
      );
    },
    CheckRcOnLocationRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i12.CheckRcOnLocationPage()),
      );
    },
    CheckTrolleyRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i13.CheckTrolleyPage()),
      );
    },
    DAInvoiceRoute.name: (routeData) {
      final args = routeData.argsAs<DAInvoiceRouteArgs>();
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i14.DAInvoicePage(
          key: args.key,
          deliveryPlan: args.deliveryPlan,
        )),
      );
    },
    DisplayTextPictureRoute.name: (routeData) {
      final args = routeData.argsAs<DisplayTextPictureRouteArgs>();
      return _i65.AutoRoutePage<String>(
        routeData: routeData,
        child: _i15.DisplayTextPicturePage(
          key: args.key,
          imagePath: args.imagePath,
        ),
      );
    },
    EmapKittingRoute.name: (routeData) {
      final args = routeData.argsAs<EmapKittingRouteArgs>();
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i16.EmapKittingPage(
          args.listKittingDetails,
          args.selectedLocations,
          orderBlocks: args.orderBlocks,
          suggestPaths: args.suggestPaths,
          key: args.key,
        )),
      );
    },
    FindBarcodeLostRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i17.FindBarcodeLostPage()),
      );
    },
    FindKittingListRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i18.FindKittingListPage()),
      );
    },
    FloorDetailRoute.name: (routeData) {
      final args = routeData.argsAs<FloorDetailRouteArgs>();
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i19.FloorDetailPage(
          key: args.key,
          receivingCardId: args.receivingCardId,
          eMapNavigateFunction: args.eMapNavigateFunction,
        )),
      );
    },
    GRHaveBarcodeRoute.name: (routeData) {
      final args = routeData.argsAs<GRHaveBarcodeRouteArgs>(
          orElse: () => const GRHaveBarcodeRouteArgs());
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i20.GRHaveBarcodePage(
          key: args.key,
          receivingCard: args.receivingCard,
        )),
      );
    },
    GRNoBarcodeRoute.name: (routeData) {
      final args = routeData.argsAs<GRNoBarcodeRouteArgs>();
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i21.GRNoBarcodePage(
          key: args.key,
          receivingCard: args.receivingCard,
          material: args.material,
          deliveryPlan: args.deliveryPlan,
          isOffsetGoods: args.isOffsetGoods,
        )),
      );
    },
    HomeRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i22.HomePage()),
      );
    },
    IQCBorrowReceivingCardRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child:
            _i65.WrappedRoute(child: const _i23.IQCBorrowReceivingCardPage()),
      );
    },
    IQCMenuRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.IQCMenuPage(),
      );
    },
    InputLocationRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i25.InputLocationPage()),
      );
    },
    InputTrolleyRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i26.InputTrolleyPage()),
      );
    },
    InventoryRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.InventoryPage(),
      );
    },
    KittingIndexRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i28.KittingIndexPage(),
      );
    },
    KittingModelRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i29.KittingModelPage()),
      );
    },
    KittingRoute.name: (routeData) {
      final args = routeData.argsAs<KittingRouteArgs>(
          orElse: () => const KittingRouteArgs());
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i30.KittingPage(
          key: args.key,
          kittingType: args.kittingType,
        )),
      );
    },
    ListBorrowItemRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i31.ListBorrowItemPage()),
      );
    },
    ListBoxCardRoute.name: (routeData) {
      final args = routeData.argsAs<ListBoxCardRouteArgs>();
      return _i65.AutoRoutePage<List<_i66.Barcode>>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i32.ListBoxCardPage(
          key: args.key,
          barcodes: args.barcodes,
          totalQuantity: args.totalQuantity,
        )),
      );
    },
    LoginRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i33.LoginPage()),
      );
    },
    MaterialHistoryTransitionRoute.name: (routeData) {
      final args = routeData.argsAs<MaterialHistoryTransitionRouteArgs>();
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i34.MaterialHistoryTransitionPage(
          key: args.key,
          material: args.material,
          sloc: args.sloc,
        )),
      );
    },
    MaterialPositionRoute.name: (routeData) {
      final args = routeData.argsAs<MaterialPositionRouteArgs>();
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i35.MaterialPositionPage(
          key: args.key,
          material: args.material,
          currentSloc: args.currentSloc,
        )),
      );
    },
    MaterialSampleRoute.name: (routeData) {
      final args = routeData.argsAs<MaterialSampleRouteArgs>();
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i36.MaterialSamplePage(
          key: args.key,
          material: args.material,
        )),
      );
    },
    MoveReceivingCardRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i37.MoveReceivingCardPage()),
      );
    },
    NewMapFloorRoute.name: (routeData) {
      final args = routeData.argsAs<NewMapFloorRouteArgs>(
          orElse: () => const NewMapFloorRouteArgs());
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i38.NewMapFloorPage(
          key: args.key,
          receivingCardId: args.receivingCardId,
          material: args.material,
          eMapNavigateFunction: args.eMapNavigateFunction,
          plant: args.plant,
          sloc: args.sloc,
          category: args.category,
          startTime: args.startTime,
          endTime: args.endTime,
          qtyKitting: args.qtyKitting,
          blockLocations: args.blockLocations,
        )),
      );
    },
    NewMapZoneRoute.name: (routeData) {
      final args = routeData.argsAs<NewMapZoneRouteArgs>(
          orElse: () => const NewMapZoneRouteArgs());
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i39.NewMapZonePage(
          key: args.key,
          receivingCardId: args.receivingCardId,
          eMapNavigateFunction: args.eMapNavigateFunction,
          zoneData: args.zoneData,
          totalTempQty: args.totalTempQty,
          totalStoreQty: args.totalStoreQty,
          lastLotName: args.lastLotName,
        )),
      );
    },
    OneForAllRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i40.OneForAllPage()),
      );
    },
    OpenGoodReceiptRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i41.OpenGoodReceiptPage()),
      );
    },
    OutReceivingCardRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i42.OutReceivingCardPage()),
      );
    },
    OutStorageRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i43.OutStoragePage()),
      );
    },
    OutTrolleyRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i44.OutTrolleyPage()),
      );
    },
    PalletDetailRoute.name: (routeData) {
      final args = routeData.argsAs<PalletDetailRouteArgs>();
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i45.PalletDetailPage(
          key: args.key,
          rackId: args.rackId,
          receivingCardId: args.receivingCardId,
          eMapNavigateFunction: args.eMapNavigateFunction,
        )),
      );
    },
    RackDetailRoute.name: (routeData) {
      final args = routeData.argsAs<RackDetailRouteArgs>();
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i46.RackDetailPage(
          key: args.key,
          rackId: args.rackId,
          receivingCardId: args.receivingCardId,
          eMapNavigateFunction: args.eMapNavigateFunction,
          lastNodeName: args.lastNodeName,
          rackType: args.rackType,
        )),
      );
    },
    RePrintRcConvertRoute.name: (routeData) {
      final args = routeData.argsAs<RePrintRcConvertRouteArgs>();
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i47.RePrintRcConvertPage(
          key: args.key,
          stockBarcode: args.stockBarcode,
        )),
      );
    },
    ReceivingCardListRoute.name: (routeData) {
      final args = routeData.argsAs<ReceivingCardListRouteArgs>(
          orElse: () => const ReceivingCardListRouteArgs());
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i48.ReceivingCardListPage(
          key: args.key,
          deliveryPlan: args.deliveryPlan,
          material: args.material,
          parentId: args.parentId,
        )),
      );
    },
    ReceivingRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i49.ReceivingPage(),
      );
    },
    ReprintBarcodeNGRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i50.ReprintBarcodeNGPage()),
      );
    },
    ReprintReceivingCardRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i51.ReprintReceivingCardPage()),
      );
    },
    ReturnKittingRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i52.ReturnKittingPage()),
      );
    },
    RevertKittingRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i53.RevertKittingPage()),
      );
    },
    SelectDAInvoiceRoute.name: (routeData) {
      final args = routeData.argsAs<SelectDAInvoiceRouteArgs>();
      return _i65.AutoRoutePage<_i67.DeliveryPlan>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i54.SelectDAInvoicePage(
          key: args.key,
          material: args.material,
          po: args.po,
          poItem: args.poItem,
          deliveryPlanNo: args.deliveryPlanNo,
          deliveryPlanType: args.deliveryPlanType,
          quantity: args.quantity,
          includeGoodReceipt: args.includeGoodReceipt,
          onSelect: args.onSelect,
        )),
      );
    },
    SplitReceivingRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i55.SplitReceivingPage()),
      );
    },
    StockToReceivingCardRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i56.StockToReceivingCardPage()),
      );
    },
    StorageBorrowItemRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i57.StorageBorrowItemPage()),
      );
    },
    StorageJupiterRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(child: const _i58.StorageJupiterPage()),
      );
    },
    StorageRCCardRoute.name: (routeData) {
      final args = routeData.argsAs<StorageRCCardRouteArgs>(
          orElse: () => const StorageRCCardRouteArgs());
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i59.StorageRCCardPage(
          key: args.key,
          rcBarcode: args.rcBarcode,
        )),
      );
    },
    StoringRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i60.StoringPage(),
      );
    },
    SupplyKittingRoute.name: (routeData) {
      final args = routeData.argsAs<SupplyKittingRouteArgs>(
          orElse: () => const SupplyKittingRouteArgs());
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i61.SupplyKittingPage(
          key: args.key,
          kittingType: args.kittingType,
        )),
      );
    },
    TemporaryAreaRoute.name: (routeData) {
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i62.TemporaryAreaPage(),
      );
    },
    TrolleyMapHTMLRoute.name: (routeData) {
      final args = routeData.argsAs<TrolleyMapHTMLRouteArgs>();
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i63.TrolleyMapHTMLPage(
          key: args.key,
          trolleyCode: args.trolleyCode,
          kittingListId: args.kittingListId,
        )),
      );
    },
    ZoneDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ZoneDetailRouteArgs>();
      return _i65.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.WrappedRoute(
            child: _i64.ZoneDetailPage(
          key: args.key,
          receivingCardId: args.receivingCardId,
          zoneId: args.zoneId,
          eMapNavigateFunction: args.eMapNavigateFunction,
        )),
      );
    },
  };
}

/// generated route for
/// [_i1.BalanceAllPage]
class BalanceAllRoute extends _i65.PageRouteInfo<void> {
  const BalanceAllRoute({List<_i65.PageRouteInfo>? children})
      : super(
          BalanceAllRoute.name,
          initialChildren: children,
        );

  static const String name = 'BalanceAllRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i2.BalanceRcPage]
class BalanceRcRoute extends _i65.PageRouteInfo<BalanceRcRouteArgs> {
  BalanceRcRoute({
    _i68.Key? key,
    String? rcBarcode,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          BalanceRcRoute.name,
          args: BalanceRcRouteArgs(
            key: key,
            rcBarcode: rcBarcode,
          ),
          initialChildren: children,
        );

  static const String name = 'BalanceRcRoute';

  static const _i65.PageInfo<BalanceRcRouteArgs> page =
      _i65.PageInfo<BalanceRcRouteArgs>(name);
}

class BalanceRcRouteArgs {
  const BalanceRcRouteArgs({
    this.key,
    this.rcBarcode,
  });

  final _i68.Key? key;

  final String? rcBarcode;

  @override
  String toString() {
    return 'BalanceRcRouteArgs{key: $key, rcBarcode: $rcBarcode}';
  }
}

/// generated route for
/// [_i3.BarCodeScannedPage]
class BarCodeScannedRoute extends _i65.PageRouteInfo<BarCodeScannedRouteArgs> {
  BarCodeScannedRoute({
    required void Function(_i69.ReceivingCard?) removeReceivingCardCallBack,
    required void Function() backToScreen,
    required void Function(_i70.ReceivingCardItem?) removePartCardCallBack,
    List<_i69.ReceivingCard>? receivingCards,
    List<_i70.ReceivingCardItem>? receivingCardItems,
    _i68.Key? key,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          BarCodeScannedRoute.name,
          args: BarCodeScannedRouteArgs(
            removeReceivingCardCallBack: removeReceivingCardCallBack,
            backToScreen: backToScreen,
            removePartCardCallBack: removePartCardCallBack,
            receivingCards: receivingCards,
            receivingCardItems: receivingCardItems,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'BarCodeScannedRoute';

  static const _i65.PageInfo<BarCodeScannedRouteArgs> page =
      _i65.PageInfo<BarCodeScannedRouteArgs>(name);
}

class BarCodeScannedRouteArgs {
  const BarCodeScannedRouteArgs({
    required this.removeReceivingCardCallBack,
    required this.backToScreen,
    required this.removePartCardCallBack,
    this.receivingCards,
    this.receivingCardItems,
    this.key,
  });

  final void Function(_i69.ReceivingCard?) removeReceivingCardCallBack;

  final void Function() backToScreen;

  final void Function(_i70.ReceivingCardItem?) removePartCardCallBack;

  final List<_i69.ReceivingCard>? receivingCards;

  final List<_i70.ReceivingCardItem>? receivingCardItems;

  final _i68.Key? key;

  @override
  String toString() {
    return 'BarCodeScannedRouteArgs{removeReceivingCardCallBack: $removeReceivingCardCallBack, backToScreen: $backToScreen, removePartCardCallBack: $removePartCardCallBack, receivingCards: $receivingCards, receivingCardItems: $receivingCardItems, key: $key}';
  }
}

/// generated route for
/// [_i4.CameraCapturePage]
class CameraCaptureRoute extends _i65.PageRouteInfo<void> {
  const CameraCaptureRoute({List<_i65.PageRouteInfo>? children})
      : super(
          CameraCaptureRoute.name,
          initialChildren: children,
        );

  static const String name = 'CameraCaptureRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ChangeStoreLocationPage]
class ChangeStoreLocationRoute extends _i65.PageRouteInfo<void> {
  const ChangeStoreLocationRoute({List<_i65.PageRouteInfo>? children})
      : super(
          ChangeStoreLocationRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangeStoreLocationRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ChangeTrolleyPage]
class ChangeTrolleyRoute extends _i65.PageRouteInfo<void> {
  const ChangeTrolleyRoute({List<_i65.PageRouteInfo>? children})
      : super(
          ChangeTrolleyRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangeTrolleyRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i7.CheckBarcodeLackPage]
class CheckBarcodeLackRoute
    extends _i65.PageRouteInfo<CheckBarcodeLackRouteArgs> {
  CheckBarcodeLackRoute({
    _i68.Key? key,
    _i66.Barcode? barcode,
    List<_i70.ReceivingCardItem>? scanningBarcode,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          CheckBarcodeLackRoute.name,
          args: CheckBarcodeLackRouteArgs(
            key: key,
            barcode: barcode,
            scanningBarcode: scanningBarcode,
          ),
          initialChildren: children,
        );

  static const String name = 'CheckBarcodeLackRoute';

  static const _i65.PageInfo<CheckBarcodeLackRouteArgs> page =
      _i65.PageInfo<CheckBarcodeLackRouteArgs>(name);
}

class CheckBarcodeLackRouteArgs {
  const CheckBarcodeLackRouteArgs({
    this.key,
    this.barcode,
    this.scanningBarcode,
  });

  final _i68.Key? key;

  final _i66.Barcode? barcode;

  final List<_i70.ReceivingCardItem>? scanningBarcode;

  @override
  String toString() {
    return 'CheckBarcodeLackRouteArgs{key: $key, barcode: $barcode, scanningBarcode: $scanningBarcode}';
  }
}

/// generated route for
/// [_i8.CheckBlockDataPage]
class CheckBlockDataRoute extends _i65.PageRouteInfo<CheckBlockDataRouteArgs> {
  CheckBlockDataRoute({
    _i68.Key? key,
    required String? blockName,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          CheckBlockDataRoute.name,
          args: CheckBlockDataRouteArgs(
            key: key,
            blockName: blockName,
          ),
          initialChildren: children,
        );

  static const String name = 'CheckBlockDataRoute';

  static const _i65.PageInfo<CheckBlockDataRouteArgs> page =
      _i65.PageInfo<CheckBlockDataRouteArgs>(name);
}

class CheckBlockDataRouteArgs {
  const CheckBlockDataRouteArgs({
    this.key,
    required this.blockName,
  });

  final _i68.Key? key;

  final String? blockName;

  @override
  String toString() {
    return 'CheckBlockDataRouteArgs{key: $key, blockName: $blockName}';
  }
}

/// generated route for
/// [_i9.CheckLastLotPage]
class CheckLastLotRoute extends _i65.PageRouteInfo<CheckLastLotRouteArgs> {
  CheckLastLotRoute({
    _i68.Key? key,
    required int blockId,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          CheckLastLotRoute.name,
          args: CheckLastLotRouteArgs(
            key: key,
            blockId: blockId,
          ),
          initialChildren: children,
        );

  static const String name = 'CheckLastLotRoute';

  static const _i65.PageInfo<CheckLastLotRouteArgs> page =
      _i65.PageInfo<CheckLastLotRouteArgs>(name);
}

class CheckLastLotRouteArgs {
  const CheckLastLotRouteArgs({
    this.key,
    required this.blockId,
  });

  final _i68.Key? key;

  final int blockId;

  @override
  String toString() {
    return 'CheckLastLotRouteArgs{key: $key, blockId: $blockId}';
  }
}

/// generated route for
/// [_i10.CheckListKittingDetailPage]
class CheckListKittingDetailRoute extends _i65.PageRouteInfo<void> {
  const CheckListKittingDetailRoute({List<_i65.PageRouteInfo>? children})
      : super(
          CheckListKittingDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'CheckListKittingDetailRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i11.CheckMaterialInStorePage]
class CheckMaterialInStoreRoute
    extends _i65.PageRouteInfo<CheckMaterialInStoreRouteArgs> {
  CheckMaterialInStoreRoute({
    _i68.Key? key,
    String? positionOrRc,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          CheckMaterialInStoreRoute.name,
          args: CheckMaterialInStoreRouteArgs(
            key: key,
            positionOrRc: positionOrRc,
          ),
          initialChildren: children,
        );

  static const String name = 'CheckMaterialInStoreRoute';

  static const _i65.PageInfo<CheckMaterialInStoreRouteArgs> page =
      _i65.PageInfo<CheckMaterialInStoreRouteArgs>(name);
}

class CheckMaterialInStoreRouteArgs {
  const CheckMaterialInStoreRouteArgs({
    this.key,
    this.positionOrRc,
  });

  final _i68.Key? key;

  final String? positionOrRc;

  @override
  String toString() {
    return 'CheckMaterialInStoreRouteArgs{key: $key, positionOrRc: $positionOrRc}';
  }
}

/// generated route for
/// [_i12.CheckRcOnLocationPage]
class CheckRcOnLocationRoute extends _i65.PageRouteInfo<void> {
  const CheckRcOnLocationRoute({List<_i65.PageRouteInfo>? children})
      : super(
          CheckRcOnLocationRoute.name,
          initialChildren: children,
        );

  static const String name = 'CheckRcOnLocationRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i13.CheckTrolleyPage]
class CheckTrolleyRoute extends _i65.PageRouteInfo<void> {
  const CheckTrolleyRoute({List<_i65.PageRouteInfo>? children})
      : super(
          CheckTrolleyRoute.name,
          initialChildren: children,
        );

  static const String name = 'CheckTrolleyRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i14.DAInvoicePage]
class DAInvoiceRoute extends _i65.PageRouteInfo<DAInvoiceRouteArgs> {
  DAInvoiceRoute({
    _i68.Key? key,
    required _i67.DeliveryPlan deliveryPlan,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          DAInvoiceRoute.name,
          args: DAInvoiceRouteArgs(
            key: key,
            deliveryPlan: deliveryPlan,
          ),
          initialChildren: children,
        );

  static const String name = 'DAInvoiceRoute';

  static const _i65.PageInfo<DAInvoiceRouteArgs> page =
      _i65.PageInfo<DAInvoiceRouteArgs>(name);
}

class DAInvoiceRouteArgs {
  const DAInvoiceRouteArgs({
    this.key,
    required this.deliveryPlan,
  });

  final _i68.Key? key;

  final _i67.DeliveryPlan deliveryPlan;

  @override
  String toString() {
    return 'DAInvoiceRouteArgs{key: $key, deliveryPlan: $deliveryPlan}';
  }
}

/// generated route for
/// [_i15.DisplayTextPicturePage]
class DisplayTextPictureRoute
    extends _i65.PageRouteInfo<DisplayTextPictureRouteArgs> {
  DisplayTextPictureRoute({
    _i68.Key? key,
    required String imagePath,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          DisplayTextPictureRoute.name,
          args: DisplayTextPictureRouteArgs(
            key: key,
            imagePath: imagePath,
          ),
          initialChildren: children,
        );

  static const String name = 'DisplayTextPictureRoute';

  static const _i65.PageInfo<DisplayTextPictureRouteArgs> page =
      _i65.PageInfo<DisplayTextPictureRouteArgs>(name);
}

class DisplayTextPictureRouteArgs {
  const DisplayTextPictureRouteArgs({
    this.key,
    required this.imagePath,
  });

  final _i68.Key? key;

  final String imagePath;

  @override
  String toString() {
    return 'DisplayTextPictureRouteArgs{key: $key, imagePath: $imagePath}';
  }
}

/// generated route for
/// [_i16.EmapKittingPage]
class EmapKittingRoute extends _i65.PageRouteInfo<EmapKittingRouteArgs> {
  EmapKittingRoute({
    required List<_i71.KittingDetail> listKittingDetails,
    required List<String> selectedLocations,
    List<_i72.OrderBlock> orderBlocks = const [],
    List<_i73.SuggestPath> suggestPaths = const [],
    _i68.Key? key,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          EmapKittingRoute.name,
          args: EmapKittingRouteArgs(
            listKittingDetails: listKittingDetails,
            selectedLocations: selectedLocations,
            orderBlocks: orderBlocks,
            suggestPaths: suggestPaths,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'EmapKittingRoute';

  static const _i65.PageInfo<EmapKittingRouteArgs> page =
      _i65.PageInfo<EmapKittingRouteArgs>(name);
}

class EmapKittingRouteArgs {
  const EmapKittingRouteArgs({
    required this.listKittingDetails,
    required this.selectedLocations,
    this.orderBlocks = const [],
    this.suggestPaths = const [],
    this.key,
  });

  final List<_i71.KittingDetail> listKittingDetails;

  final List<String> selectedLocations;

  final List<_i72.OrderBlock> orderBlocks;

  final List<_i73.SuggestPath> suggestPaths;

  final _i68.Key? key;

  @override
  String toString() {
    return 'EmapKittingRouteArgs{listKittingDetails: $listKittingDetails, selectedLocations: $selectedLocations, orderBlocks: $orderBlocks, suggestPaths: $suggestPaths, key: $key}';
  }
}

/// generated route for
/// [_i17.FindBarcodeLostPage]
class FindBarcodeLostRoute extends _i65.PageRouteInfo<void> {
  const FindBarcodeLostRoute({List<_i65.PageRouteInfo>? children})
      : super(
          FindBarcodeLostRoute.name,
          initialChildren: children,
        );

  static const String name = 'FindBarcodeLostRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i18.FindKittingListPage]
class FindKittingListRoute extends _i65.PageRouteInfo<void> {
  const FindKittingListRoute({List<_i65.PageRouteInfo>? children})
      : super(
          FindKittingListRoute.name,
          initialChildren: children,
        );

  static const String name = 'FindKittingListRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i19.FloorDetailPage]
class FloorDetailRoute extends _i65.PageRouteInfo<FloorDetailRouteArgs> {
  FloorDetailRoute({
    _i68.Key? key,
    required int receivingCardId,
    _i74.EMapNavigateFunction eMapNavigateFunction =
        _i74.EMapNavigateFunction.storing,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          FloorDetailRoute.name,
          args: FloorDetailRouteArgs(
            key: key,
            receivingCardId: receivingCardId,
            eMapNavigateFunction: eMapNavigateFunction,
          ),
          initialChildren: children,
        );

  static const String name = 'FloorDetailRoute';

  static const _i65.PageInfo<FloorDetailRouteArgs> page =
      _i65.PageInfo<FloorDetailRouteArgs>(name);
}

class FloorDetailRouteArgs {
  const FloorDetailRouteArgs({
    this.key,
    required this.receivingCardId,
    this.eMapNavigateFunction = _i74.EMapNavigateFunction.storing,
  });

  final _i68.Key? key;

  final int receivingCardId;

  final _i74.EMapNavigateFunction eMapNavigateFunction;

  @override
  String toString() {
    return 'FloorDetailRouteArgs{key: $key, receivingCardId: $receivingCardId, eMapNavigateFunction: $eMapNavigateFunction}';
  }
}

/// generated route for
/// [_i20.GRHaveBarcodePage]
class GRHaveBarcodeRoute extends _i65.PageRouteInfo<GRHaveBarcodeRouteArgs> {
  GRHaveBarcodeRoute({
    _i68.Key? key,
    _i69.ReceivingCard? receivingCard,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          GRHaveBarcodeRoute.name,
          args: GRHaveBarcodeRouteArgs(
            key: key,
            receivingCard: receivingCard,
          ),
          initialChildren: children,
        );

  static const String name = 'GRHaveBarcodeRoute';

  static const _i65.PageInfo<GRHaveBarcodeRouteArgs> page =
      _i65.PageInfo<GRHaveBarcodeRouteArgs>(name);
}

class GRHaveBarcodeRouteArgs {
  const GRHaveBarcodeRouteArgs({
    this.key,
    this.receivingCard,
  });

  final _i68.Key? key;

  final _i69.ReceivingCard? receivingCard;

  @override
  String toString() {
    return 'GRHaveBarcodeRouteArgs{key: $key, receivingCard: $receivingCard}';
  }
}

/// generated route for
/// [_i21.GRNoBarcodePage]
class GRNoBarcodeRoute extends _i65.PageRouteInfo<GRNoBarcodeRouteArgs> {
  GRNoBarcodeRoute({
    _i68.Key? key,
    _i69.ReceivingCard? receivingCard,
    String? material,
    required _i67.DeliveryPlan deliveryPlan,
    bool isOffsetGoods = false,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          GRNoBarcodeRoute.name,
          args: GRNoBarcodeRouteArgs(
            key: key,
            receivingCard: receivingCard,
            material: material,
            deliveryPlan: deliveryPlan,
            isOffsetGoods: isOffsetGoods,
          ),
          initialChildren: children,
        );

  static const String name = 'GRNoBarcodeRoute';

  static const _i65.PageInfo<GRNoBarcodeRouteArgs> page =
      _i65.PageInfo<GRNoBarcodeRouteArgs>(name);
}

class GRNoBarcodeRouteArgs {
  const GRNoBarcodeRouteArgs({
    this.key,
    this.receivingCard,
    this.material,
    required this.deliveryPlan,
    this.isOffsetGoods = false,
  });

  final _i68.Key? key;

  final _i69.ReceivingCard? receivingCard;

  final String? material;

  final _i67.DeliveryPlan deliveryPlan;

  final bool isOffsetGoods;

  @override
  String toString() {
    return 'GRNoBarcodeRouteArgs{key: $key, receivingCard: $receivingCard, material: $material, deliveryPlan: $deliveryPlan, isOffsetGoods: $isOffsetGoods}';
  }
}

/// generated route for
/// [_i22.HomePage]
class HomeRoute extends _i65.PageRouteInfo<void> {
  const HomeRoute({List<_i65.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i23.IQCBorrowReceivingCardPage]
class IQCBorrowReceivingCardRoute extends _i65.PageRouteInfo<void> {
  const IQCBorrowReceivingCardRoute({List<_i65.PageRouteInfo>? children})
      : super(
          IQCBorrowReceivingCardRoute.name,
          initialChildren: children,
        );

  static const String name = 'IQCBorrowReceivingCardRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i24.IQCMenuPage]
class IQCMenuRoute extends _i65.PageRouteInfo<void> {
  const IQCMenuRoute({List<_i65.PageRouteInfo>? children})
      : super(
          IQCMenuRoute.name,
          initialChildren: children,
        );

  static const String name = 'IQCMenuRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i25.InputLocationPage]
class InputLocationRoute extends _i65.PageRouteInfo<void> {
  const InputLocationRoute({List<_i65.PageRouteInfo>? children})
      : super(
          InputLocationRoute.name,
          initialChildren: children,
        );

  static const String name = 'InputLocationRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i26.InputTrolleyPage]
class InputTrolleyRoute extends _i65.PageRouteInfo<void> {
  const InputTrolleyRoute({List<_i65.PageRouteInfo>? children})
      : super(
          InputTrolleyRoute.name,
          initialChildren: children,
        );

  static const String name = 'InputTrolleyRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i27.InventoryPage]
class InventoryRoute extends _i65.PageRouteInfo<void> {
  const InventoryRoute({List<_i65.PageRouteInfo>? children})
      : super(
          InventoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'InventoryRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i28.KittingIndexPage]
class KittingIndexRoute extends _i65.PageRouteInfo<void> {
  const KittingIndexRoute({List<_i65.PageRouteInfo>? children})
      : super(
          KittingIndexRoute.name,
          initialChildren: children,
        );

  static const String name = 'KittingIndexRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i29.KittingModelPage]
class KittingModelRoute extends _i65.PageRouteInfo<void> {
  const KittingModelRoute({List<_i65.PageRouteInfo>? children})
      : super(
          KittingModelRoute.name,
          initialChildren: children,
        );

  static const String name = 'KittingModelRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i30.KittingPage]
class KittingRoute extends _i65.PageRouteInfo<KittingRouteArgs> {
  KittingRoute({
    _i68.Key? key,
    _i75.KittingType? kittingType,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          KittingRoute.name,
          args: KittingRouteArgs(
            key: key,
            kittingType: kittingType,
          ),
          initialChildren: children,
        );

  static const String name = 'KittingRoute';

  static const _i65.PageInfo<KittingRouteArgs> page =
      _i65.PageInfo<KittingRouteArgs>(name);
}

class KittingRouteArgs {
  const KittingRouteArgs({
    this.key,
    this.kittingType,
  });

  final _i68.Key? key;

  final _i75.KittingType? kittingType;

  @override
  String toString() {
    return 'KittingRouteArgs{key: $key, kittingType: $kittingType}';
  }
}

/// generated route for
/// [_i31.ListBorrowItemPage]
class ListBorrowItemRoute extends _i65.PageRouteInfo<void> {
  const ListBorrowItemRoute({List<_i65.PageRouteInfo>? children})
      : super(
          ListBorrowItemRoute.name,
          initialChildren: children,
        );

  static const String name = 'ListBorrowItemRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i32.ListBoxCardPage]
class ListBoxCardRoute extends _i65.PageRouteInfo<ListBoxCardRouteArgs> {
  ListBoxCardRoute({
    _i68.Key? key,
    required List<_i66.Barcode> barcodes,
    required int totalQuantity,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          ListBoxCardRoute.name,
          args: ListBoxCardRouteArgs(
            key: key,
            barcodes: barcodes,
            totalQuantity: totalQuantity,
          ),
          initialChildren: children,
        );

  static const String name = 'ListBoxCardRoute';

  static const _i65.PageInfo<ListBoxCardRouteArgs> page =
      _i65.PageInfo<ListBoxCardRouteArgs>(name);
}

class ListBoxCardRouteArgs {
  const ListBoxCardRouteArgs({
    this.key,
    required this.barcodes,
    required this.totalQuantity,
  });

  final _i68.Key? key;

  final List<_i66.Barcode> barcodes;

  final int totalQuantity;

  @override
  String toString() {
    return 'ListBoxCardRouteArgs{key: $key, barcodes: $barcodes, totalQuantity: $totalQuantity}';
  }
}

/// generated route for
/// [_i33.LoginPage]
class LoginRoute extends _i65.PageRouteInfo<void> {
  const LoginRoute({List<_i65.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i34.MaterialHistoryTransitionPage]
class MaterialHistoryTransitionRoute
    extends _i65.PageRouteInfo<MaterialHistoryTransitionRouteArgs> {
  MaterialHistoryTransitionRoute({
    _i68.Key? key,
    required String material,
    required String sloc,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          MaterialHistoryTransitionRoute.name,
          args: MaterialHistoryTransitionRouteArgs(
            key: key,
            material: material,
            sloc: sloc,
          ),
          initialChildren: children,
        );

  static const String name = 'MaterialHistoryTransitionRoute';

  static const _i65.PageInfo<MaterialHistoryTransitionRouteArgs> page =
      _i65.PageInfo<MaterialHistoryTransitionRouteArgs>(name);
}

class MaterialHistoryTransitionRouteArgs {
  const MaterialHistoryTransitionRouteArgs({
    this.key,
    required this.material,
    required this.sloc,
  });

  final _i68.Key? key;

  final String material;

  final String sloc;

  @override
  String toString() {
    return 'MaterialHistoryTransitionRouteArgs{key: $key, material: $material, sloc: $sloc}';
  }
}

/// generated route for
/// [_i35.MaterialPositionPage]
class MaterialPositionRoute
    extends _i65.PageRouteInfo<MaterialPositionRouteArgs> {
  MaterialPositionRoute({
    _i68.Key? key,
    required String material,
    required String currentSloc,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          MaterialPositionRoute.name,
          args: MaterialPositionRouteArgs(
            key: key,
            material: material,
            currentSloc: currentSloc,
          ),
          initialChildren: children,
        );

  static const String name = 'MaterialPositionRoute';

  static const _i65.PageInfo<MaterialPositionRouteArgs> page =
      _i65.PageInfo<MaterialPositionRouteArgs>(name);
}

class MaterialPositionRouteArgs {
  const MaterialPositionRouteArgs({
    this.key,
    required this.material,
    required this.currentSloc,
  });

  final _i68.Key? key;

  final String material;

  final String currentSloc;

  @override
  String toString() {
    return 'MaterialPositionRouteArgs{key: $key, material: $material, currentSloc: $currentSloc}';
  }
}

/// generated route for
/// [_i36.MaterialSamplePage]
class MaterialSampleRoute extends _i65.PageRouteInfo<MaterialSampleRouteArgs> {
  MaterialSampleRoute({
    _i68.Key? key,
    required String material,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          MaterialSampleRoute.name,
          args: MaterialSampleRouteArgs(
            key: key,
            material: material,
          ),
          initialChildren: children,
        );

  static const String name = 'MaterialSampleRoute';

  static const _i65.PageInfo<MaterialSampleRouteArgs> page =
      _i65.PageInfo<MaterialSampleRouteArgs>(name);
}

class MaterialSampleRouteArgs {
  const MaterialSampleRouteArgs({
    this.key,
    required this.material,
  });

  final _i68.Key? key;

  final String material;

  @override
  String toString() {
    return 'MaterialSampleRouteArgs{key: $key, material: $material}';
  }
}

/// generated route for
/// [_i37.MoveReceivingCardPage]
class MoveReceivingCardRoute extends _i65.PageRouteInfo<void> {
  const MoveReceivingCardRoute({List<_i65.PageRouteInfo>? children})
      : super(
          MoveReceivingCardRoute.name,
          initialChildren: children,
        );

  static const String name = 'MoveReceivingCardRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i38.NewMapFloorPage]
class NewMapFloorRoute extends _i65.PageRouteInfo<NewMapFloorRouteArgs> {
  NewMapFloorRoute({
    _i68.Key? key,
    int? receivingCardId,
    String? material,
    _i74.EMapNavigateFunction eMapNavigateFunction =
        _i74.EMapNavigateFunction.storing,
    String? plant,
    String? sloc,
    String? category,
    int? startTime,
    int? endTime,
    double? qtyKitting,
    List<String> blockLocations = const [],
    List<_i65.PageRouteInfo>? children,
  }) : super(
          NewMapFloorRoute.name,
          args: NewMapFloorRouteArgs(
            key: key,
            receivingCardId: receivingCardId,
            material: material,
            eMapNavigateFunction: eMapNavigateFunction,
            plant: plant,
            sloc: sloc,
            category: category,
            startTime: startTime,
            endTime: endTime,
            qtyKitting: qtyKitting,
            blockLocations: blockLocations,
          ),
          initialChildren: children,
        );

  static const String name = 'NewMapFloorRoute';

  static const _i65.PageInfo<NewMapFloorRouteArgs> page =
      _i65.PageInfo<NewMapFloorRouteArgs>(name);
}

class NewMapFloorRouteArgs {
  const NewMapFloorRouteArgs({
    this.key,
    this.receivingCardId,
    this.material,
    this.eMapNavigateFunction = _i74.EMapNavigateFunction.storing,
    this.plant,
    this.sloc,
    this.category,
    this.startTime,
    this.endTime,
    this.qtyKitting,
    this.blockLocations = const [],
  });

  final _i68.Key? key;

  final int? receivingCardId;

  final String? material;

  final _i74.EMapNavigateFunction eMapNavigateFunction;

  final String? plant;

  final String? sloc;

  final String? category;

  final int? startTime;

  final int? endTime;

  final double? qtyKitting;

  final List<String> blockLocations;

  @override
  String toString() {
    return 'NewMapFloorRouteArgs{key: $key, receivingCardId: $receivingCardId, material: $material, eMapNavigateFunction: $eMapNavigateFunction, plant: $plant, sloc: $sloc, category: $category, startTime: $startTime, endTime: $endTime, qtyKitting: $qtyKitting, blockLocations: $blockLocations}';
  }
}

/// generated route for
/// [_i39.NewMapZonePage]
class NewMapZoneRoute extends _i65.PageRouteInfo<NewMapZoneRouteArgs> {
  NewMapZoneRoute({
    _i68.Key? key,
    int? receivingCardId,
    _i74.EMapNavigateFunction eMapNavigateFunction =
        _i74.EMapNavigateFunction.storing,
    _i76.EMapZone? zoneData,
    int totalTempQty = 0,
    int totalStoreQty = 0,
    String lastLotName = '',
    List<_i65.PageRouteInfo>? children,
  }) : super(
          NewMapZoneRoute.name,
          args: NewMapZoneRouteArgs(
            key: key,
            receivingCardId: receivingCardId,
            eMapNavigateFunction: eMapNavigateFunction,
            zoneData: zoneData,
            totalTempQty: totalTempQty,
            totalStoreQty: totalStoreQty,
            lastLotName: lastLotName,
          ),
          initialChildren: children,
        );

  static const String name = 'NewMapZoneRoute';

  static const _i65.PageInfo<NewMapZoneRouteArgs> page =
      _i65.PageInfo<NewMapZoneRouteArgs>(name);
}

class NewMapZoneRouteArgs {
  const NewMapZoneRouteArgs({
    this.key,
    this.receivingCardId,
    this.eMapNavigateFunction = _i74.EMapNavigateFunction.storing,
    this.zoneData,
    this.totalTempQty = 0,
    this.totalStoreQty = 0,
    this.lastLotName = '',
  });

  final _i68.Key? key;

  final int? receivingCardId;

  final _i74.EMapNavigateFunction eMapNavigateFunction;

  final _i76.EMapZone? zoneData;

  final int totalTempQty;

  final int totalStoreQty;

  final String lastLotName;

  @override
  String toString() {
    return 'NewMapZoneRouteArgs{key: $key, receivingCardId: $receivingCardId, eMapNavigateFunction: $eMapNavigateFunction, zoneData: $zoneData, totalTempQty: $totalTempQty, totalStoreQty: $totalStoreQty, lastLotName: $lastLotName}';
  }
}

/// generated route for
/// [_i40.OneForAllPage]
class OneForAllRoute extends _i65.PageRouteInfo<void> {
  const OneForAllRoute({List<_i65.PageRouteInfo>? children})
      : super(
          OneForAllRoute.name,
          initialChildren: children,
        );

  static const String name = 'OneForAllRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i41.OpenGoodReceiptPage]
class OpenGoodReceiptRoute extends _i65.PageRouteInfo<void> {
  const OpenGoodReceiptRoute({List<_i65.PageRouteInfo>? children})
      : super(
          OpenGoodReceiptRoute.name,
          initialChildren: children,
        );

  static const String name = 'OpenGoodReceiptRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i42.OutReceivingCardPage]
class OutReceivingCardRoute extends _i65.PageRouteInfo<void> {
  const OutReceivingCardRoute({List<_i65.PageRouteInfo>? children})
      : super(
          OutReceivingCardRoute.name,
          initialChildren: children,
        );

  static const String name = 'OutReceivingCardRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i43.OutStoragePage]
class OutStorageRoute extends _i65.PageRouteInfo<void> {
  const OutStorageRoute({List<_i65.PageRouteInfo>? children})
      : super(
          OutStorageRoute.name,
          initialChildren: children,
        );

  static const String name = 'OutStorageRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i44.OutTrolleyPage]
class OutTrolleyRoute extends _i65.PageRouteInfo<void> {
  const OutTrolleyRoute({List<_i65.PageRouteInfo>? children})
      : super(
          OutTrolleyRoute.name,
          initialChildren: children,
        );

  static const String name = 'OutTrolleyRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i45.PalletDetailPage]
class PalletDetailRoute extends _i65.PageRouteInfo<PalletDetailRouteArgs> {
  PalletDetailRoute({
    _i68.Key? key,
    required int rackId,
    required int receivingCardId,
    required _i74.EMapNavigateFunction eMapNavigateFunction,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          PalletDetailRoute.name,
          args: PalletDetailRouteArgs(
            key: key,
            rackId: rackId,
            receivingCardId: receivingCardId,
            eMapNavigateFunction: eMapNavigateFunction,
          ),
          initialChildren: children,
        );

  static const String name = 'PalletDetailRoute';

  static const _i65.PageInfo<PalletDetailRouteArgs> page =
      _i65.PageInfo<PalletDetailRouteArgs>(name);
}

class PalletDetailRouteArgs {
  const PalletDetailRouteArgs({
    this.key,
    required this.rackId,
    required this.receivingCardId,
    required this.eMapNavigateFunction,
  });

  final _i68.Key? key;

  final int rackId;

  final int receivingCardId;

  final _i74.EMapNavigateFunction eMapNavigateFunction;

  @override
  String toString() {
    return 'PalletDetailRouteArgs{key: $key, rackId: $rackId, receivingCardId: $receivingCardId, eMapNavigateFunction: $eMapNavigateFunction}';
  }
}

/// generated route for
/// [_i46.RackDetailPage]
class RackDetailRoute extends _i65.PageRouteInfo<RackDetailRouteArgs> {
  RackDetailRoute({
    _i68.Key? key,
    required int rackId,
    required int receivingCardId,
    required _i74.EMapNavigateFunction eMapNavigateFunction,
    String lastNodeName = '',
    _i77.RackType? rackType,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          RackDetailRoute.name,
          args: RackDetailRouteArgs(
            key: key,
            rackId: rackId,
            receivingCardId: receivingCardId,
            eMapNavigateFunction: eMapNavigateFunction,
            lastNodeName: lastNodeName,
            rackType: rackType,
          ),
          initialChildren: children,
        );

  static const String name = 'RackDetailRoute';

  static const _i65.PageInfo<RackDetailRouteArgs> page =
      _i65.PageInfo<RackDetailRouteArgs>(name);
}

class RackDetailRouteArgs {
  const RackDetailRouteArgs({
    this.key,
    required this.rackId,
    required this.receivingCardId,
    required this.eMapNavigateFunction,
    this.lastNodeName = '',
    this.rackType,
  });

  final _i68.Key? key;

  final int rackId;

  final int receivingCardId;

  final _i74.EMapNavigateFunction eMapNavigateFunction;

  final String lastNodeName;

  final _i77.RackType? rackType;

  @override
  String toString() {
    return 'RackDetailRouteArgs{key: $key, rackId: $rackId, receivingCardId: $receivingCardId, eMapNavigateFunction: $eMapNavigateFunction, lastNodeName: $lastNodeName, rackType: $rackType}';
  }
}

/// generated route for
/// [_i47.RePrintRcConvertPage]
class RePrintRcConvertRoute
    extends _i65.PageRouteInfo<RePrintRcConvertRouteArgs> {
  RePrintRcConvertRoute({
    _i68.Key? key,
    required String stockBarcode,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          RePrintRcConvertRoute.name,
          args: RePrintRcConvertRouteArgs(
            key: key,
            stockBarcode: stockBarcode,
          ),
          initialChildren: children,
        );

  static const String name = 'RePrintRcConvertRoute';

  static const _i65.PageInfo<RePrintRcConvertRouteArgs> page =
      _i65.PageInfo<RePrintRcConvertRouteArgs>(name);
}

class RePrintRcConvertRouteArgs {
  const RePrintRcConvertRouteArgs({
    this.key,
    required this.stockBarcode,
  });

  final _i68.Key? key;

  final String stockBarcode;

  @override
  String toString() {
    return 'RePrintRcConvertRouteArgs{key: $key, stockBarcode: $stockBarcode}';
  }
}

/// generated route for
/// [_i48.ReceivingCardListPage]
class ReceivingCardListRoute
    extends _i65.PageRouteInfo<ReceivingCardListRouteArgs> {
  ReceivingCardListRoute({
    _i68.Key? key,
    _i67.DeliveryPlan? deliveryPlan,
    String? material,
    int? parentId,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          ReceivingCardListRoute.name,
          args: ReceivingCardListRouteArgs(
            key: key,
            deliveryPlan: deliveryPlan,
            material: material,
            parentId: parentId,
          ),
          initialChildren: children,
        );

  static const String name = 'ReceivingCardListRoute';

  static const _i65.PageInfo<ReceivingCardListRouteArgs> page =
      _i65.PageInfo<ReceivingCardListRouteArgs>(name);
}

class ReceivingCardListRouteArgs {
  const ReceivingCardListRouteArgs({
    this.key,
    this.deliveryPlan,
    this.material,
    this.parentId,
  });

  final _i68.Key? key;

  final _i67.DeliveryPlan? deliveryPlan;

  final String? material;

  final int? parentId;

  @override
  String toString() {
    return 'ReceivingCardListRouteArgs{key: $key, deliveryPlan: $deliveryPlan, material: $material, parentId: $parentId}';
  }
}

/// generated route for
/// [_i49.ReceivingPage]
class ReceivingRoute extends _i65.PageRouteInfo<void> {
  const ReceivingRoute({List<_i65.PageRouteInfo>? children})
      : super(
          ReceivingRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReceivingRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i50.ReprintBarcodeNGPage]
class ReprintBarcodeNGRoute extends _i65.PageRouteInfo<void> {
  const ReprintBarcodeNGRoute({List<_i65.PageRouteInfo>? children})
      : super(
          ReprintBarcodeNGRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReprintBarcodeNGRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i51.ReprintReceivingCardPage]
class ReprintReceivingCardRoute extends _i65.PageRouteInfo<void> {
  const ReprintReceivingCardRoute({List<_i65.PageRouteInfo>? children})
      : super(
          ReprintReceivingCardRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReprintReceivingCardRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i52.ReturnKittingPage]
class ReturnKittingRoute extends _i65.PageRouteInfo<void> {
  const ReturnKittingRoute({List<_i65.PageRouteInfo>? children})
      : super(
          ReturnKittingRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReturnKittingRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i53.RevertKittingPage]
class RevertKittingRoute extends _i65.PageRouteInfo<void> {
  const RevertKittingRoute({List<_i65.PageRouteInfo>? children})
      : super(
          RevertKittingRoute.name,
          initialChildren: children,
        );

  static const String name = 'RevertKittingRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i54.SelectDAInvoicePage]
class SelectDAInvoiceRoute
    extends _i65.PageRouteInfo<SelectDAInvoiceRouteArgs> {
  SelectDAInvoiceRoute({
    _i68.Key? key,
    String? material,
    String? po,
    String? poItem,
    String? deliveryPlanNo,
    _i78.DeliveryPlanType? deliveryPlanType,
    int? quantity,
    bool includeGoodReceipt = false,
    required void Function(
      _i67.DeliveryPlan?,
      String?,
    ) onSelect,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          SelectDAInvoiceRoute.name,
          args: SelectDAInvoiceRouteArgs(
            key: key,
            material: material,
            po: po,
            poItem: poItem,
            deliveryPlanNo: deliveryPlanNo,
            deliveryPlanType: deliveryPlanType,
            quantity: quantity,
            includeGoodReceipt: includeGoodReceipt,
            onSelect: onSelect,
          ),
          initialChildren: children,
        );

  static const String name = 'SelectDAInvoiceRoute';

  static const _i65.PageInfo<SelectDAInvoiceRouteArgs> page =
      _i65.PageInfo<SelectDAInvoiceRouteArgs>(name);
}

class SelectDAInvoiceRouteArgs {
  const SelectDAInvoiceRouteArgs({
    this.key,
    this.material,
    this.po,
    this.poItem,
    this.deliveryPlanNo,
    this.deliveryPlanType,
    this.quantity,
    this.includeGoodReceipt = false,
    required this.onSelect,
  });

  final _i68.Key? key;

  final String? material;

  final String? po;

  final String? poItem;

  final String? deliveryPlanNo;

  final _i78.DeliveryPlanType? deliveryPlanType;

  final int? quantity;

  final bool includeGoodReceipt;

  final void Function(
    _i67.DeliveryPlan?,
    String?,
  ) onSelect;

  @override
  String toString() {
    return 'SelectDAInvoiceRouteArgs{key: $key, material: $material, po: $po, poItem: $poItem, deliveryPlanNo: $deliveryPlanNo, deliveryPlanType: $deliveryPlanType, quantity: $quantity, includeGoodReceipt: $includeGoodReceipt, onSelect: $onSelect}';
  }
}

/// generated route for
/// [_i55.SplitReceivingPage]
class SplitReceivingRoute extends _i65.PageRouteInfo<void> {
  const SplitReceivingRoute({List<_i65.PageRouteInfo>? children})
      : super(
          SplitReceivingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplitReceivingRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i56.StockToReceivingCardPage]
class StockToReceivingCardRoute extends _i65.PageRouteInfo<void> {
  const StockToReceivingCardRoute({List<_i65.PageRouteInfo>? children})
      : super(
          StockToReceivingCardRoute.name,
          initialChildren: children,
        );

  static const String name = 'StockToReceivingCardRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i57.StorageBorrowItemPage]
class StorageBorrowItemRoute extends _i65.PageRouteInfo<void> {
  const StorageBorrowItemRoute({List<_i65.PageRouteInfo>? children})
      : super(
          StorageBorrowItemRoute.name,
          initialChildren: children,
        );

  static const String name = 'StorageBorrowItemRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i58.StorageJupiterPage]
class StorageJupiterRoute extends _i65.PageRouteInfo<void> {
  const StorageJupiterRoute({List<_i65.PageRouteInfo>? children})
      : super(
          StorageJupiterRoute.name,
          initialChildren: children,
        );

  static const String name = 'StorageJupiterRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i59.StorageRCCardPage]
class StorageRCCardRoute extends _i65.PageRouteInfo<StorageRCCardRouteArgs> {
  StorageRCCardRoute({
    _i68.Key? key,
    String? rcBarcode,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          StorageRCCardRoute.name,
          args: StorageRCCardRouteArgs(
            key: key,
            rcBarcode: rcBarcode,
          ),
          initialChildren: children,
        );

  static const String name = 'StorageRCCardRoute';

  static const _i65.PageInfo<StorageRCCardRouteArgs> page =
      _i65.PageInfo<StorageRCCardRouteArgs>(name);
}

class StorageRCCardRouteArgs {
  const StorageRCCardRouteArgs({
    this.key,
    this.rcBarcode,
  });

  final _i68.Key? key;

  final String? rcBarcode;

  @override
  String toString() {
    return 'StorageRCCardRouteArgs{key: $key, rcBarcode: $rcBarcode}';
  }
}

/// generated route for
/// [_i60.StoringPage]
class StoringRoute extends _i65.PageRouteInfo<void> {
  const StoringRoute({List<_i65.PageRouteInfo>? children})
      : super(
          StoringRoute.name,
          initialChildren: children,
        );

  static const String name = 'StoringRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i61.SupplyKittingPage]
class SupplyKittingRoute extends _i65.PageRouteInfo<SupplyKittingRouteArgs> {
  SupplyKittingRoute({
    _i68.Key? key,
    _i75.KittingType? kittingType,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          SupplyKittingRoute.name,
          args: SupplyKittingRouteArgs(
            key: key,
            kittingType: kittingType,
          ),
          initialChildren: children,
        );

  static const String name = 'SupplyKittingRoute';

  static const _i65.PageInfo<SupplyKittingRouteArgs> page =
      _i65.PageInfo<SupplyKittingRouteArgs>(name);
}

class SupplyKittingRouteArgs {
  const SupplyKittingRouteArgs({
    this.key,
    this.kittingType,
  });

  final _i68.Key? key;

  final _i75.KittingType? kittingType;

  @override
  String toString() {
    return 'SupplyKittingRouteArgs{key: $key, kittingType: $kittingType}';
  }
}

/// generated route for
/// [_i62.TemporaryAreaPage]
class TemporaryAreaRoute extends _i65.PageRouteInfo<void> {
  const TemporaryAreaRoute({List<_i65.PageRouteInfo>? children})
      : super(
          TemporaryAreaRoute.name,
          initialChildren: children,
        );

  static const String name = 'TemporaryAreaRoute';

  static const _i65.PageInfo<void> page = _i65.PageInfo<void>(name);
}

/// generated route for
/// [_i63.TrolleyMapHTMLPage]
class TrolleyMapHTMLRoute extends _i65.PageRouteInfo<TrolleyMapHTMLRouteArgs> {
  TrolleyMapHTMLRoute({
    _i68.Key? key,
    required String trolleyCode,
    required int kittingListId,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          TrolleyMapHTMLRoute.name,
          args: TrolleyMapHTMLRouteArgs(
            key: key,
            trolleyCode: trolleyCode,
            kittingListId: kittingListId,
          ),
          initialChildren: children,
        );

  static const String name = 'TrolleyMapHTMLRoute';

  static const _i65.PageInfo<TrolleyMapHTMLRouteArgs> page =
      _i65.PageInfo<TrolleyMapHTMLRouteArgs>(name);
}

class TrolleyMapHTMLRouteArgs {
  const TrolleyMapHTMLRouteArgs({
    this.key,
    required this.trolleyCode,
    required this.kittingListId,
  });

  final _i68.Key? key;

  final String trolleyCode;

  final int kittingListId;

  @override
  String toString() {
    return 'TrolleyMapHTMLRouteArgs{key: $key, trolleyCode: $trolleyCode, kittingListId: $kittingListId}';
  }
}

/// generated route for
/// [_i64.ZoneDetailPage]
class ZoneDetailRoute extends _i65.PageRouteInfo<ZoneDetailRouteArgs> {
  ZoneDetailRoute({
    _i68.Key? key,
    required int receivingCardId,
    int? zoneId,
    _i74.EMapNavigateFunction eMapNavigateFunction =
        _i74.EMapNavigateFunction.storing,
    List<_i65.PageRouteInfo>? children,
  }) : super(
          ZoneDetailRoute.name,
          args: ZoneDetailRouteArgs(
            key: key,
            receivingCardId: receivingCardId,
            zoneId: zoneId,
            eMapNavigateFunction: eMapNavigateFunction,
          ),
          initialChildren: children,
        );

  static const String name = 'ZoneDetailRoute';

  static const _i65.PageInfo<ZoneDetailRouteArgs> page =
      _i65.PageInfo<ZoneDetailRouteArgs>(name);
}

class ZoneDetailRouteArgs {
  const ZoneDetailRouteArgs({
    this.key,
    required this.receivingCardId,
    this.zoneId,
    this.eMapNavigateFunction = _i74.EMapNavigateFunction.storing,
  });

  final _i68.Key? key;

  final int receivingCardId;

  final int? zoneId;

  final _i74.EMapNavigateFunction eMapNavigateFunction;

  @override
  String toString() {
    return 'ZoneDetailRouteArgs{key: $key, receivingCardId: $receivingCardId, zoneId: $zoneId, eMapNavigateFunction: $eMapNavigateFunction}';
  }
}
