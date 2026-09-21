import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/entities/kitting_filter.dart';
import 'package:smart_warehouse/enums/kitting_time_type.dart';
import 'package:smart_warehouse/enums/kitting_type.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';

import '../kitting_controller.dart';
import '../kitting_state.dart';

class ListKittingFilterWidget extends StatelessWidget {
  const ListKittingFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<KittingController>();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocSelector<KittingController, KittingState,
          KittingFilter>(
        selector: (state) => state.kittingFilter,
        builder: (context, filter) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (filter.model != null)
                Chip(
                  labelStyle: const TextStyle(fontSize: 12),
                  padding: EdgeInsets.zero,
                  label: Text('Model: ${filter.model}'),
                  onDeleted: () =>
                      cubit.updateFilter(filter.copyWith(model: null,models: [])),
                ),
              if (filter.material != null)
                Chip(
                  labelStyle: const TextStyle(fontSize: 12),
                  padding: EdgeInsets.zero,
                  label: Text('Material: ${filter.material}'),
                  onDeleted: () =>
                      cubit.updateFilter(filter.copyWith(material: null)),
                ),
              if (filter.uploadNo != null)
                Chip(
                  labelStyle: const TextStyle(fontSize: 12),
                  padding: EdgeInsets.zero,
                  label: Text('Upload No: ${filter.uploadNo}'),
                  onDeleted: () =>
                      cubit.updateFilter(filter.copyWith(uploadNo: null)),
                ),
              if (filter.category != null)
                Chip(
                  labelStyle: const TextStyle(fontSize: 12),
                  padding: EdgeInsets.zero,
                  label: Text('Category: ${filter.category}'),
                  onDeleted: () =>
                      cubit.updateFilter(filter.copyWith(category: null)),
                ),
              if (filter.reason != null)
                Chip(
                  labelStyle: const TextStyle(fontSize: 12),
                  padding: EdgeInsets.zero,
                  label: Text('Reason: ${filter.reason}'),
                  onDeleted: () =>
                      cubit.updateFilter(filter.copyWith(reason: null)),
                ),
              if (filter.isKittingEnough)
                Chip(
                  labelStyle: const TextStyle(fontSize: 12),
                  padding: EdgeInsets.zero,
                  label: const Text('Chưa Kitting'),
                  onDeleted: () => cubit
                      .updateFilter(filter.copyWith(isKittingEnough: false)),
                ),
              if (filter.isJIT)
                Chip(
                  labelStyle: const TextStyle(fontSize: 12),
                  padding: EdgeInsets.zero,
                  label: const Text('JIT'),
                  onDeleted: () =>
                      cubit.updateFilter(filter.copyWith(isJIT: false)),
                ),
              if (filter.isUrgent ?? false)
                Chip(
                  labelStyle: const TextStyle(fontSize: 12),
                  padding: EdgeInsets.zero,
                  label: const Text('Urgent'),
                  onDeleted: () =>
                      cubit.updateFilter(filter.copyWith(isUrgent: false)),
                ),
              if (filter.isDownstairs)
                Chip(
                  labelStyle: const TextStyle(fontSize: 12),
                  padding: EdgeInsets.zero,
                  label: const Text('Tầng dưới'),
                  onDeleted: () =>
                      cubit.updateFilter(filter.copyWith(isDownstairs: false)),
                ),
              if (filter.isSub)
                Chip(
                  labelStyle: const TextStyle(fontSize: 12),
                  padding: EdgeInsets.zero,
                  label: const Text('Hàng Sub'),
                  onDeleted: () =>
                      cubit.updateFilter(filter.copyWith(isSub: false)),
                ),
              if (filter.kittingType == KittingType.dip &&
                  filter.isOnTheHour != null)
                Chip(
                  labelStyle: const TextStyle(fontSize: 12),
                  padding: EdgeInsets.zero,
                  label: Text('Khung giờ: ${filter.getTimeKittingFormatted()}'),
                  onDeleted: () => cubit.updateFilter(
                    filter.copyWith(
                      isOnTheHour: null,
                      startTime: null,
                      endTime: null,
                    ),
                  ),
                ),
              if (filter.location != null)
                Chip(
                  labelStyle: const TextStyle(fontSize: 12),
                  padding: EdgeInsets.zero,
                  label: Text('Location: ${filter.location}'),
                  onDeleted: () =>
                      cubit.updateFilter(filter.copyWith(location: null)),
                ),
              if (filter.deliveryDate != null)
                Chip(
                  labelStyle: const TextStyle(fontSize: 12),
                  padding: EdgeInsets.zero,
                  label: Text(filter.deliveryDate?.toText() ?? ''),
                  onDeleted: () => cubit.updateFilter(
                      filter.copyWith(deliveryDate: null, isDay: false)),
                ),
              if (filter.kittingTimeType == KittingTimeType.total)
                Chip(
                  labelStyle: const TextStyle(fontSize: 12),
                  padding: EdgeInsets.zero,
                  label: Text(filter.kittingTimeType.toString()),
                )
              else
                Chip(
                  labelStyle: const TextStyle(fontSize: 12),
                  padding: EdgeInsets.zero,
                  label: Text(
                    '${filter.kittingTimeType}${filter.isOnTheHour == null ? '' : ': ${filter.getTimeKittingFormatted()}'}',
                  ),
                  onDeleted: () => cubit.updateFilter(
                    filter.copyWith(
                      kittingTimeType: KittingTimeType.total,
                      isOnTheHour: null,
                      startTime: null,
                      endTime: null,
                    ),
                  ),
                ),
            ].withWidgetBetween(const SizedBox(width: 4)),
          );
        },
      ).paddingSymmetric(horizontal: 16),
    );
  }
}
