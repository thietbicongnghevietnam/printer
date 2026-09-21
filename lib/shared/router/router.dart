import 'package:auto_route/auto_route.dart';
import 'package:smart_warehouse/shared/router/auth_guard.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: HomeRoute.page, initial: true, guards: [AuthGuard()]),
        AutoRoute(page: ReceivingRoute.page),
        AutoRoute(page: GRHaveBarcodeRoute.page),
        AutoRoute(page: DAInvoiceRoute.page),
        AutoRoute(page: SelectDAInvoiceRoute.page, fullscreenDialog: true),
        AutoRoute(page: GRNoBarcodeRoute.page),
        AutoRoute(page: CheckBarcodeLackRoute.page),
        AutoRoute(page: ReprintReceivingCardRoute.page),
        AutoRoute(page: ReprintBarcodeNGRoute.page),
        AutoRoute(page: CameraCaptureRoute.page),
        AutoRoute(page: DisplayTextPictureRoute.page),
        AutoRoute(page: TemporaryAreaRoute.page),
        AutoRoute(page: InputLocationRoute.page),
        AutoRoute(page:       MoveReceivingCardRoute.page),
        AutoRoute(page: OpenGoodReceiptRoute.page),
        AutoRoute(page: ReceivingCardListRoute.page),
        AutoRoute(page: ListBoxCardRoute.page),

        //---Storing---//
        AutoRoute(page: StoringRoute.page),
        AutoRoute(page: StorageRCCardRoute.page),
        AutoRoute(page: CheckMaterialInStoreRoute.page),
        AutoRoute(page: OutStorageRoute.page),
        AutoRoute(page: ChangeStoreLocationRoute.page),
        AutoRoute(page: CheckLastLotRoute.page),
        AutoRoute(page: StorageBorrowItemRoute.page),
        AutoRoute(page: ListBorrowItemRoute.page),
        AutoRoute(page: MaterialHistoryTransitionRoute.page),
        AutoRoute(page: MaterialPositionRoute.page),
        AutoRoute(page: MaterialSampleRoute.page),
        AutoRoute(page: StorageJupiterRoute.page),
        AutoRoute(page: StockToReceivingCardRoute.page),
        AutoRoute(page: CheckBlockDataRoute.page),
        AutoRoute(page: RePrintRcConvertRoute.page),
        AutoRoute(page: IQCBorrowReceivingCardRoute.page),
        AutoRoute(page: FindBarcodeLostRoute.page),

        //---Kitting---//
        AutoRoute(page: KittingRoute.page),
        AutoRoute(page: OutReceivingCardRoute.page),
        AutoRoute(page: RevertKittingRoute.page),
        AutoRoute(page: InputTrolleyRoute.page),
        AutoRoute(page: ChangeTrolleyRoute.page),
        AutoRoute(page: OutTrolleyRoute.page),
        AutoRoute(page: FindKittingListRoute.page),
        AutoRoute(page: CheckListKittingDetailRoute.page),
        AutoRoute(page: BarCodeScannedRoute.page),
        AutoRoute(page: KittingModelRoute.page),
        AutoRoute(page: CheckTrolleyRoute.page),
        AutoRoute(page: SplitReceivingRoute.page),
        AutoRoute(page: EmapKittingRoute.page),
        AutoRoute(page: KittingIndexRoute.page),
        AutoRoute(page: ReturnKittingRoute.page),

        //---EMap---//
        AutoRoute(page: FloorDetailRoute.page),
        AutoRoute(page: ZoneDetailRoute.page),
        AutoRoute(page: RackDetailRoute.page),
        AutoRoute(page: PalletDetailRoute.page),
        AutoRoute(page: NewMapFloorRoute.page),
        AutoRoute(page: NewMapZoneRoute.page),
        AutoRoute(page: TrolleyMapHTMLRoute.page),

        //---Supply---//
        AutoRoute(page: SupplyKittingRoute.page),

        //---Inventory---//
        AutoRoute(page: InventoryRoute.page),
        AutoRoute(page: BalanceRcRoute.page),
        AutoRoute(page: BalanceAllRoute.page),
        AutoRoute(page: CheckRcOnLocationRoute.page),

        //---One For All---//
        AutoRoute(page: OneForAllRoute.page),

        //----IQC2026-----//
        AutoRoute(page: IQCMenuRoute.page),

      ];
}
