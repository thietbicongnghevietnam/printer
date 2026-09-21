import 'dart:async';

import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/e_map/emap_kiting_suggest.dart';
import 'package:smart_warehouse/entities/e_map/suggest_path.dart';
import 'package:smart_warehouse/enums/emap_navigate_funciton.dart';
import 'package:smart_warehouse/repositories/emap_repository.dart';
import 'package:smart_warehouse/repositories/kitting_repository.dart';
import 'package:smart_warehouse/services/models/response/map_suggest_widget_response_model.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'new_map_floor_state.dart';

@injectable
class NewMapFloorController extends BaseCubit<NewMapFloorState> {
  NewMapFloorController(
    this._eMapRepository,
    this._kittingRepository,
  ) : super(NewMapFloorState());
  final EMapRepository _eMapRepository;
  final KittingRepository _kittingRepository;

  // final box = Hive.box<DraftEMapFloor>('draft_emap_floor');

  Future<void> initialLoadEMap({
    int? receivingCardId,
    String? material,
    String? plant,
    String? sloc,
    String? category,
    int? startTime,
    int? endTime,
    double? qtyKitting,
    EMapNavigateFunction? eMapNavigateFunction,
    List<String>? blockLocations,
  }) {
    return launch(() async {
      if (eMapNavigateFunction == EMapNavigateFunction.storing) {
        final suggestRes = await _eMapRepository.getSuggestInfoData(
          rcId: receivingCardId,
          // material: material ?? '',
          plant: plant,
          sloc: sloc,
          category: category,
          startTime: startTime,
          endTime: endTime,
          qtyKitting: qtyKitting,
        );

        final floorSuggest =
            suggestRes.firstWhereOrNull((e) => e.isSuggested == true);

        if (floorSuggest != null) {
          final layout =
              await _eMapRepository.loadMap(floorSuggestData: floorSuggest);
          emit(
            state.copyWith(
              floorUIData: layout,
              floorList: suggestRes,
            ),
          );
        }
      } else {
        if (blockLocations != null) {
          final floorInfo = await _eMapRepository.convertMapData();

          final suggestKitting = await _kittingRepository.getDataSuggestMap(locations:blockLocations);

          if (floorInfo.isNotEmpty) {
            emit(
              state.copyWith(
                floorUIData: suggestKitting.layoutMap,
                floorList: floorInfo,
              ),
            );

            final suggestPath = suggestKitting.suggestPath ?? [];
            final improvePath = <SuggestPath>[];
            final leng = suggestPath.length;

            if (suggestPath.isNotEmpty) {
              for (var i = 0; i < leng; i++) {
                final startX = suggestPath[i].x;
                final startY = suggestPath[i].y;

                var endX = startX;
                var endY = startY;

                while (i + 1 < leng) {
                  final nextX = suggestPath[i + 1].x;
                  final nextY = suggestPath[i + 1].y;

                  if (nextX == endX && nextY == endY + 10) {
                    endY = nextY;
                  } else if (nextY == endY && nextX == endX + 10) {
                    endX = nextX;
                  } else {
                    break;
                  }
                  i++;
                }

                improvePath.add(SuggestPath(x: startX, y: startY));
                if (startX != endX || startY != endY) {
                  improvePath.add(SuggestPath(x: endX, y: endY));
                }
              }

              suggestKitting.suggestPath = improvePath;
              emit(state.copyWith(emapKittingSuggest: suggestKitting));
            }
          }
        }
      }
    });
  }

  Future<void> onChangeFloor({
    required MapSuggestWidgetResponseModel floorChange,
  }) {
    return launch(() async {
      final floorSuggest = floorChange;

      final layout = await _eMapRepository.loadMap(
        floorSuggestData: floorSuggest,
      );
      emit(state.copyWith(floorUIData: layout));
    });
  }
}
