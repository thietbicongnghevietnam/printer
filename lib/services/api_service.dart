import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/services/models/request/barcode_model.dart';
import 'package:smart_warehouse/services/models/request/check_supply_request_model.dart';
import 'package:smart_warehouse/services/models/request/combine_pallet_request_model.dart';
import 'package:smart_warehouse/services/models/request/create_receiving_card_request_model.dart';
import 'package:smart_warehouse/services/models/request/input_location_request_model.dart';
import 'package:smart_warehouse/services/models/request/kitting_card_request.dart';
import 'package:smart_warehouse/services/models/request/login_request_model.dart';
import 'package:smart_warehouse/services/models/request/move_receiving_card_request_model.dart';
import 'package:smart_warehouse/services/models/request/out_receiving_card_request_model.dart';
import 'package:smart_warehouse/services/models/request/receiving_card_by_stock_request_model.dart';
import 'package:smart_warehouse/services/models/request/revert_kitting_request_model.dart';
import 'package:smart_warehouse/services/models/request/store_recard_jit_request_model.dart';
import 'package:smart_warehouse/services/models/request/update_receiving_card_request_model.dart';
import 'package:smart_warehouse/services/models/response/balance_detail_response_model.dart';
import 'package:smart_warehouse/services/models/response/emap_kitting_suggest_response_model.dart';
import 'package:smart_warehouse/services/models/response/fifo_response_model.dart';
import 'package:smart_warehouse/services/models/response/floor_map_response_model.dart';
import 'package:smart_warehouse/services/models/response/inventory_response_model.dart';
import 'package:smart_warehouse/services/models/response/kitting_card_response_model.dart';
import 'package:smart_warehouse/services/models/response/kitting_detail_response_model.dart';
import 'package:smart_warehouse/services/models/response/kitting_response_model.dart';
import 'package:smart_warehouse/services/models/response/login_response_model.dart';
import 'package:smart_warehouse/services/models/response/order_plan_response_model.dart';
import 'package:smart_warehouse/services/models/response/plant_category_response_model.dart';
import 'package:smart_warehouse/services/models/response/printer_device_response_model.dart';
import 'package:smart_warehouse/services/models/response/qty_by_location_response_model.dart';
import 'package:smart_warehouse/services/models/response/rack_detail_response_model.dart';
import 'package:smart_warehouse/services/models/response/receiving_card_by_block_response_model.dart';
import 'package:smart_warehouse/services/models/response/receiving_card_item_response_model.dart';
import 'package:smart_warehouse/services/models/response/receiving_card_kitting_response_model.dart';
import 'package:smart_warehouse/services/models/response/receiving_card_response_model.dart';
import 'package:smart_warehouse/services/models/response/receiving_schedule_response_model.dart';
import 'package:smart_warehouse/services/models/response/search_pmd_response_model.dart';
import 'package:smart_warehouse/services/models/response/search_response_model.dart';
import 'package:smart_warehouse/services/models/response/search_smart_warehouse_for_kitting_response_model.dart';
import 'package:smart_warehouse/services/models/response/supply_response_model.dart';
import 'package:smart_warehouse/services/models/response/vendor_response_model.dart';
import 'package:smart_warehouse/services/models/response/zone_detail_response_model.dart';

import 'models/request/change_location_request_model.dart';
import 'models/request/check_kitting_request_model.dart';
import 'models/request/clone_receiving_card_request_model.dart';
import 'models/request/combine_location_request_model.dart';
import 'models/request/create_balance_qty_request_model.dart';
import 'models/request/create_balance_rc_qty_request_model.dart';
import 'models/request/create_trolleykitting_request_model.dart';
import 'models/request/material_request_model.dart';
import 'models/request/move_out_all_storage_request_model.dart';
import 'models/request/move_out_store_request_model.dart';
import 'models/request/out_pallet_request_model.dart';
import 'models/request/qc_borrow_rc_request_model.dart';
import 'models/request/receiving_card_model.dart';
import 'models/request/return_kitting_request_model.dart';
import 'models/request/split_receiving_card_request_model.dart';
import 'models/request/store_goods_request_model.dart';
import 'models/request/store_recard_request_model.dart';
import 'models/request/trolley_kitting_move_request_model.dart';
import 'models/response/all_plant_sloc_response_model.dart';
import 'models/response/app_version_model.dart';
import 'models/response/borrow_goods_response_model.dart';
import 'models/response/box_quantity_response_model.dart';
import 'models/response/da_invoice_response_model.dart';
import 'models/response/floor_map_info_response_model.dart';
import 'models/response/kitting_list_trolley_info_response_model.dart';
import 'models/response/location_response_model.dart';
import 'models/response/map_suggest_widget_response_model.dart';
import 'models/response/map_trolley_response_model.dart';
import 'models/response/material_history_transition_response_model.dart';
import 'models/response/material_info_response_model.dart';
import 'models/response/material_location_response_model.dart';
import 'models/response/material_response_model.dart';
import 'models/response/material_sample_responses_model.dart';
import 'models/response/new_map_widget_response_model.dart';
import 'models/response/plant_type_freqquency_response_model.dart';
import 'models/response/qm_sampling_rohs_response_model.dart';
import 'models/response/qty_qc_history_response_model.dart';
import 'models/response/result_receiving_qc.dart';
import 'models/response/search_da_inv_item_response_model.dart';
import 'models/response/urgen_sloc_response_model.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // ----------------------------- AUTHENTICATION ------------------------------

  @Header('No-Authentication: true')
  @POST('/signin')
  Future<LoginResponseModel> login(@Body() LoginRequestModel request);

  @POST('/signout')
  Future<void> logout();

  // --------------------------------- APP --------------------v----------------

  @GET('/app/downloadfile')
  Future<AppVersionResponseModel> updateApp();

  @GET('/app/get')
  Future<String> getVersionApp();

  // --------------------------------- VENDOR ----------------------------------

  @GET('/vendor/search')
  Future<SearchResponseModel<VendorResponseModel>> searchVendor();

  // ------------------------------- DA/Invoice --------------------------------

  @GET('/deliveryplan/search')
  Future<SearchResponseModel<DAInvoiceResponseModel>> searchDAInvoice({
    @Query('Date') String? date,
    @Query('VendorCode') String? vendorCode,
    @Query('Material') String? material,
    @Query('Type') int? type,
    @Query('DaInvNo') String? daInvNo,
    @Query('DAInvItem') String? daInvItem,
    @Query('PONO') String? poNo,
    @Query('POItem') String? poItem,
    @Query('Quantity') int? quantity,
    @Query('GlobalCode') String? globalCode,
    @Query('IncludeGoodReceipt') bool? includeGoodReceipt,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  //Tuấn Anh thêm
  @GET('/deliveryplan/searchexistBarcode')
  Future<bool> Checkexistsbarcode({
    @Query('barCode') required String barCode,
});



  @GET('/deliveryplanitemdetail/search')
  Future<List<SearchDAInvItemResponseModel>> searchDAInvoiceItemDetail({
    @Query('Type') int? type,
    @Query('Material') String? material,
    @Query('DaInvNo') String? daInvNo,
    @Query('DAInvItem') String? daInvItem,
    @Query('PONO') String? poNo,
    @Query('POItem') String? poItem,
  });

  @GET('/deliveryplan/get')
  Future<DAInvoiceResponseModel> getDAInvoiceDetail({
    @Query('DAInvId') int? id,
    @Query('DAInvNo') String? no,
    @Query('Type') required int type,
    @Query('GlobalCode') String? globalCode,
  });

  @GET('/deliveryplan/readpmd')
  Future<SearchPMDResponsesModel?> readPMD({
    @Query('barCode') required String barCode,
  });

  @GET('/deliveryplan/search_plan_order')
  Future<SearchResponseModel<OrderPlanResponseModel>> searchPlanOrder({
    @Query('planOrderNumber') String? planOrderNumber,
    @Query('plant') String? plant,
    @Query('material') String? material,
    @Query('sloc') String? sloc,
    @Query('category') String? category,
    @Query('postingDate') String? postingDate,
    @Query('isGR') bool? isGR = true,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  // ----------------------------- Receiving Card ------------------------------

  @POST('/receivingcard/create')
  Future<ReceivingCardResponseModel> createReceivingCard(
    @Body() CreateReceivingCardRequestModel request,
  );

  @POST('/receivingcard/clone')
  Future<ReceivingCardResponseModel> cloneReceivingCard(
    @Body() CloneReceivingCardRequestModel request,
  );

  @PUT('/receivingcard/update_status')
  Future<ReceivingCardResponseModel> updateStatusReceivingCard(
    @Query('id') int id,
    @Query('status') int status,
  );

  @GET('/receivingcard/read')
  Future<ReceivingCardResponseModel> getReceivingCard(
    @Query('receivingCardId') int id,
  );

  @GET('/receivingcard/search')
  Future<List<ReceivingCardResponseModel>> searchReceivingCard({
    @Query('Type') int? daInvType,
    @Query('DaInvId') int? daInvId,
    @Query('Material') String? material,
    @Query('Barcode') String? barcode,
    @Query('TemporaryAreaCode') String? pallet,
    @Query('PlanOrderNumber') String? planOrderNumber,
    @Query('ParentID') int? parentID,
  });
  @GET('/receivingcard/searchTA')
  Future<List<ReceivingCardResponseModel>> searchReceivingCardTA({
    @Query('Type') int? daInvType,
    @Query('DaInvId') int? daInvId,
    @Query('Material') String? material,
    @Query('Barcode') String? barcode,
    @Query('TemporaryAreaCode') String? pallet,
    @Query('PlanOrderNumber') String? planOrderNumber,
    @Query('ParentID') int? parentID,
  });

  @GET('/receivingcard/searchreceivingcarddetailbybarcode')
  Future<List<MaterialResponseModel>> searchReceivingCardDetailsByBarcode({
    @Query('barcode') required String barcode,
  });

  @PUT('/receivingcard/update')
  Future<ReceivingCardResponseModel> updateReceivingCard(
    @Body() UpdateReceivingCardRequestModel request,
  );

  @PUT('/receivingcard/confirm')
  Future<void> confirmReceivingCard(@Query('id') int id);

  @PUT('/receivingcard/confirm')
  Future<void> confirmCloneReceivingCard(
    @Query('id') int id,
    @Query('parentId') int parentId,
    @Query('status') int status,
  );

  @PUT('/receivingcard/revert')
  Future<void> revertReceivingCard(@Query('id') int id);

  @GET('/receivingcard/getschedulerc')
  Future<ReceivingScheduleResponsesModel> getReceivingSchedule();

  @GET('/receivingcard/checkrc')
  Future<ResultReceivingQCResponsesModel?> receivingCardRcCheck(
      @Query('id') int id);

  @POST('/receivingcard/splitrc')
  Future<ReceivingCardResponseModel> splitReceivingCard(
    @Body() SplitReceivingCardRequestModel request,
  );

  @GET('/receivingcard/getrcbystockcard')
  Future<ReceivingCardResponseModel> getRCConvertByStock(
      @Query('barocdeStock') String barocdeStock);

  @POST('/receivingcard/updatercforqc')
  Future<ReceivingCardResponseModel> qcBorrowReceivingCard(
      @Body() QCBorrowRcRequestModel body);

  @GET('/receivingcard/getqtyqchistory')
  Future<List<QtyQCHistoryResponseModel>?> getQtyQCHistory({
    @Query('material') required String material,
    @Query('plant') required String plant,
    @Query('sloc') required String sloc,
  });

  // ----------------------------- Material ------------------------------

  @GET('/material/getMaterialInfo')
  Future<MaterialInfoResponseModel?> getMaterialInfo(
    @Query('Material') String material,
    @Query('Plant') String plant,
    @Query('Sloc') String sloc,
    @Query('VendorCode') String? vendorCode,
  );

  // ----------------------------- Temporary Area ------------------------------

  @POST('/temporaryarea/inputlocation')
  Future<List<ReceivingCardModel>?> createInputLocation(
    @Body() InputLocationRequestModel request,
  );

  @POST('/temporaryarea/movereceivingcard')
  Future<List<ReceivingCardModel>?> createMoveReceivingCard(
    @Body() MoveReceivingCardRequestModel request,
  );

  @POST('/temporaryarea/combinetemporaryarea')
  Future<List<ReceivingCardModel>> createCombinePallet(
    @Body() CombinePalletRequestModel request,
  );

  @PUT('/temporaryarea/out_temporary_area')
  Future<ReceivingCardModel?> outReceivingCard(
    @Body() OutReceivingCardRequestModel request,
  );

  @PUT('/temporaryarea/out_temporary_areas')
  Future<ReceivingCardModel?> outPallet(
    @Body() OutPalletRequestModel? request,
  );

  // ----------------------------- Printer Device ------------------------------

  @GET('/printerdevice/getall')
  Future<SearchResponseModel<PrinterDeviceResponseModel>>
      getAllPrinterDevices();

  // ----------------------------- Reprint Barcode ------------------------------
  @POST('/historyprint/create')
  Future<void> createBarCodeNG(
    @Body() BarCodeModel request,
  );

  // ----------------------------- Storing ------------------------------
  // Map
  @GET('/floor/getfloors')
  Future<List<FloorMapInfoResponseModel>?> getListFloorMap();

  @GET('/layout/get_widget')
  Future<NewMapWidgetResponseModel> getListMapWidgets(
    @Query('id') int? widgetId,
  );

  @GET('/layout/getwidgetbyrcid')
  Future<NewMapWidgetResponseModel?> getListMapWidgetsByRcId(
    @Query('id') int? widgetId,
  );

  @GET('/layout/smartwarehousemap')
  Future<List<MapSuggestWidgetResponseModel>?> getMapSuggest({
    @Query('receivingcardID') int? receivingCardID,
    @Query('material') String? material,
    @Query('plant') String? plant,
    @Query('sloc') String? sloc,
    @Query('category') String? category,
    @Query('startTime') int? startTime,
    @Query('endTime') int? endTime,
    @Query('qtyKitting') double? qtyKitting,
  });

  @GET('/layout/layoutdetail')
  Future<NewMapWidgetResponseModel> getEMapUI({
    @Query('id') int? floorId,
  });

  @GET('/zone/getzonesbyfloorId')
  Future<FloorMapResponseModel> getFloorDetail(
    @Query('floorId') int? floorId,
  );

  @GET('/zone/getzonesbyreceivingcardid')
  Future<FloorMapResponseModel?> getFloorDetailByReceivingCard(
    @Query('receivingCardId') int? receivingId,
  );

  @GET('/block/getblocksbyrackidandrcid')
  Future<RackDetailResponseModel?> getRackDetail({
    @Query('receivingCardId') int? receivingId,
    @Query('rackId') int? rackId,
  });

  @GET('/block/getreceivingcardsbyblockid')
  Future<List<ReceivingCardByBlockResponseModel>?> getReceivingCardByBlockId(
    @Query('blockId') int? blockId,
  );

  @GET('/rack/getracksbyzoneid')
  Future<ZoneDetailResponseModel> getZoneDetail(
    @Query('zoneId') int? zoneId,
  );

  @GET('/rack/getracksbyrcidandzoneid')
  Future<ZoneDetailResponseModel?> getZoneDetailByReIdAndZoneId({
    @Query('zoneId') int? zoneId,
    @Query('receivingCardId') int? receivingId,
  });

  /// Storing
  @POST('/block/storingreceivingcard')
  Future<void> storingReceivingCard(@Body() StoreReCardRequestModel body);

  @POST('/zone/storingreceivingcardjit')
  Future<void> storingReceivingCardJIT(@Body() StoreReCardJITRequestModel body);

  @POST('/block/storerequestinggoods')
  Future<void> storeRequestingGoods(@Body() List<StoreGoodsRequestModel> body);

  @GET('/block/searchrequestinggoods')
  Future<List<BorrowGoodsResponseModel>?> searchBorrowGoodsList({
    @Query('name') String? goodsName,
    @Query('pageNumber') int? pageNumber,
    @Query('pageSize') int? pageSize,
  });

  @PUT('/block/takeoutrequestinggoods')
  Future<void> takeOutBorrowGoods(@Query('ids') String ids);

  @GET('/block/getlocationbyrcid')
  Future<LocationResponseModel?> getLocationByReId(@Query('rcId') int rcId);

  @POST('/storage/combinelocation')
  Future<void> combineLocation(@Body() CombineLocationRequestModel body);

  @POST('/storage/changelocation')
  Future<void> changeLocation(@Body() ChangeLocationRequestModel body);

  @POST('/storage/moveoutstore')
  Future<void> moveOutStore(@Body() MoveOutStoreRequestModel body);

  @POST('/storage/moveallstore')
  Future<void> moveOutAllStore(@Body() MoveOutAllStoreRequestModel body);

  @GET('/material/getmaterialbylocation')
  Future<List<MaterialLocationResponseModel>?> getMaterialByLocation(
    @Query('locationName') String locationName,
  );

  @GET('/storage/getpositionbymaterial')
  Future<List<MaterialLocationResponseModel>?> getPositionByMaterial(
    @Query('material') String material,
    @Query('sloc') String sloc,
  );

  @GET('/materialdetail/getbymaterial')
  Future<MaterialSampleResponseModel?> getSampleMaterial(
    @Query('material') String material,
  );

  @GET('/storage/gethistoryblocktransition')
  Future<MaterialHistoryTransitionResponseModel?> getHistoryBlockTransition({
    @Query('Material') required String material,
    @Query('FromDate') DateTime? fromDate,
    @Query('ToDate') DateTime? toDate,
    @Query('Sloc') String? sloc,
  });

  @POST('/receivingcard/movereceivingcardjpt')
  Future<void> storingJupiter(@Query('receivingCardId') int receivingCardId);

  // Special case: Convert StockCard to ReceivingCard
  @GET('/goodreceipt/geturgen')
  Future<UrgenSlocResponseModel?> getUrgenInfoFromMaterial(
    @Query('material') String material,
  );

  @GET('/goodreceipt/gettypefrequency')
  Future<List<PlantTypeFrequencyResponseModel>?> getTypeFrequencyFromMaterial(
    @Query('material') String material,
  );

  @GET('/goodreceipt/getqm')
  Future<QmSamplingRohsResponseModel?> getQmConvertStockCard({
    @Query('vendorCode') required String venderCode,
    @Query('material') required String material,
    @Query('plant') required String plant,
  });

  @POST('/receivingcard/creatconverttoreceivingcard')
  Future<ReceivingCardResponseModel> createConvertStockToReCard({
    @Body() required ReceivingCardByStockRequestModel body,
  });

  @GET('/goodreceipt/getbox')
  Future<List<BoxQuantityResponseModel>?> getAllBoxCard({
    @Query('material') required String material,
    @Query('sloc') required String sloc,
    @Query('plant') required String plant,
    @Query('position') required String position,
  });

  @GET('/typefrequency/getall')
  Future<AllPlantSlocResponseModel?> getAllPlanSlocFromMaterial({
    @Query('Material') String? material,
    @Query('pageNumber') int? pageNumber,
    @Query('pageSize') int? pageSize,
  });

  // ----------------------------- Kitting ------------------------------
  @GET('/kitting/getkittinglistbykey')
  Future<KittingResponseModel?> getDataKittingList({
    @Query('barcode') String? barcode,
    @Query('id') int? id,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  @GET('/layout/smartwarehouskittingemap')
  Future<SearchSmartWarehouseForKittingResponseModel> getKittingDetail({
    @Query('parentId') int? kittingListId,
    @Query('material') String? material,
    @Query('kittingTimeType') String? kittingTimeType,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
    @Query('startTime') int? startTime,
    @Query('endTime') int? endTime,
    @Query('isJIT') bool? isJIT,
    @Query('model') String? model,
    @Query('isOnTheHour') bool? isOnTheHour,
    @Query('isKittingEnough') bool? isKittingEnough,
    @Query('deliveryDate') String? deliveryDate,
    @Query('isUrgent') bool? isUrgent,
    @Query('kittingType') int? kittingType,
    @Query('startLocation') String? startLocation,
    @Query('category') String? category,
    @Query('reason') String? reason,
    @Query('uploadno') String? uploadno,
    @Query('picuser') String? picuser,
    @Query('isDay') bool? isDay,
    @Query('isDownstairs') bool isDownstairs = false,
    @Query('location') String? location,
  });

  @GET('/kitting/getkittingcardbyid')
  Future<KittingCardResponseModel?> getKittingCard(
    @Query('id') int id,
  );

  @POST('/kitting/createkittingcard')
  Future<List<KittingCardResponseModel>> createKittingCard(
    @Body() KittingCardRequest kittingCardsRequests,
  );

  @GET('/receivingcard/getrcdetailbybarcode')
  Future<List<ReceivingCardItemResponseModel>> getReceivingCardItem(
    @Query('barcode') String barcode,
  );

  @POST('/kitting/checkingkittinglist')
  Future<void> checkKittingList(
    @Body() CheckKittingRequestModel request,
  );

  @PUT('/kitting/revertkittingcard')
  Future<ReceivingCardResponseModel> revertKitting(
    @Body() RevertKittingRequestModel request,
  );

  @POST('/kitting/returnkittingcard')
  Future<ReceivingCardResponseModel?> returnKitting(
    @Body() ReturnKittingRequestModel request,
  );

  @GET('/inventory/search')
  Future<SearchResponseModel<InventoryResponseModel>> searchInventory({
    @Query('material') String? material,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  @GET('/trolleykitting/getbykittinglistid')
  Future<SearchResponseModel<SupplyResponseModel>> getByKittingListId({
    @Query('kittingListId') int? kittingListId,
  });

  @GET('/receivingcard/searchreceivingcarddetailbyrcid')
  Future<List<ReceivingCardItemResponseModel>> getReceivingCardItemByRcId({
    @Query('rcId') int? rcId,
  });

  @GET('/receivingcard/getrcforkitting')
  Future<List<ReceivingCardResponseModel>> getReceivingCardForKitting({
    @Query('receivingCardId') int? receivingCardId,
    @Query('material') String? material,
  });

  @GET('/receivingcard/getrcdetailbybarcodeforkitting')
  Future<List<ReceivingCardItemResponseModel>>
      getReceivingCardItemByBarCodeForKitting({
    @Query('barcode') String? barcode,
    @Query('material') String? material,
  });

  @GET('/trolleykitting/gettrollykittinglistbykittingcard')
  Future<KittingListTrolleyInfoResponsesModel?> getKittingListWithTrolley({
    @Query('kittingCard') int? kittingCardId,
  });

  @GET('/layout/getmaptrolley')
  Future<MapTrolleyResponsesModel?> getMapTrolley();

  // ----------------------------- Supply ------------------------------
  @POST('/trolleykitting/create')
  Future<void> inputKittingListLocation({
    @Body() required CreateTrolleyKittingRequestModel request,
  });

  @POST('/trolleykitting/delete')
  Future<void> outKittingListLocation({
    @Query('barcode') required String kittingListQR,
  });

  @POST('/trolleykitting/move')
  Future<void> moveKittingListLocation({
    @Body() required TrolleyKittingMoveRequestModel body,
  });

  @POST('/trolleykitting/confirmsupply')
  Future<void> confirmSupply({
    @Query('barCodeKittingList') required String barCodeKittingList,
  });

  @POST('/receivingcard/checkreprintforrevertkittingcard')
  Future<void> checkReprintForRevertKittingCard({
    @Query('barcode') required String barcode,
  });

  @PUT('/kitting/checksupply')
  Future<void> checkSupply(
    @Body() CheckSupplyRequestModel request,
  );

  @GET('/goodreceipt/getrcbykittingcard')
  Future<List<ReceivingCardKittingResponsesModel>>
      getReceivingCardByKittingCard({
    @Query('barcode') String? barcode,
  });

  @GET('/goodreceipt/getfifo')
  Future<FifoResponseModel> getFifo({
    @Query('material') String? material,
  });

  @GET('/kitting/getkittingcardbykittinglistdetail')
  Future<List<KittingCardResponseModel>> getKittingCardByKittingListDetailId({
    @Query('kittingListDetailId') int? kittingListDetailId,
  });

  // -------- Inventory ---------- //

  @GET('/category/getallcategoryplant')
  Future<List<PlantCategoryResponseModel>?> getAllPlantCate();

  @GET('/inventory/getlistbalance')
  Future<SearchResponseModel<BalanceDetailResponseModel>?> searchListBalance({
    @Query('material') String? material,
    @Query('plant') String? plant,
    @Query('sloc') String? sloc,
    @Query('category') String? category,
    @Query('pageSize') int? pageSize,
    @Query('pageNumber') int? pageNumber,
  });

  @POST('/inventory/createbalanceqty')
  Future<void> createBalanceQty({
    @Body() required List<CreateBalanceQtyRequestModel> request,
  });

  @POST('/goodreceipt/balancerc')
  Future<void> createBalanceRcQty(
    @Body() BalanceRcDataRequestModel request,
  );

  @GET('/receivingcard/searchrcbyblockname')
  Future<List<ReceivingCardResponseModel>> getRCListInBlock(
    @Query('blockname') String? blockname,
  );

  @GET('/kitting/getuploadno')
  Future<List<String>> getUploadNo({
    @Query('kittingType') int? kittingType,
    @Query('deliveryDate') String? deliveryDate,
  });

  @GET('/layout/suggestkitting')
  Future<EMapKittingSuggestResponseModel> getDataSuggestMap({
    @Query('locations') required List<String> locations,
  });

  @GET('/goodreceipt/getrcbyrcd')
  Future<ReceivingCardResponseModel> getReceivingCardByPartCardId({
    @Query('rcDId') int? partCardId,
  });

  @GET('/goodreceipt/getqtybylocation')
  Future<QtyByLocationResponseModel> getQtyByLocation({
    @Query('rcId') int? receivingCardId,
  });

  @GET('/kitting/searchkittinglistdetail')
  Future<SearchSmartWarehouseForKittingResponseModel>
      getKittingDetailByKittingListId({
    @Query('parentId') int? kittingListId,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });
}
