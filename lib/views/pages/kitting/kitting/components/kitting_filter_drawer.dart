import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/entities/kitting_filter.dart';
import 'package:smart_warehouse/enums/kitting_time_type.dart';
import 'package:smart_warehouse/enums/kitting_type.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/views/dialogs/kitting_ntime_dialog.dart';
import 'package:smart_warehouse/views/pages/kitting/kitting/kitting_controller.dart';
import 'package:smart_warehouse/views/pages/kitting/kitting/kitting_state.dart';
import 'package:smart_warehouse/views/widgets/app_autocomplete.dart';
import 'package:smart_warehouse/views/widgets/app_date_picker.dart';
import 'package:smart_warehouse/views/widgets/app_drop_down.dart';
import 'package:smart_warehouse/views/widgets/app_radio.dart';

class KittingFilterDrawer extends StatefulWidget {
  const KittingFilterDrawer({super.key});

  @override
  State<KittingFilterDrawer> createState() => _KittingFilterDrawerState();
}

class _KittingFilterDrawerState extends State<KittingFilterDrawer> {
  final List<int> listTimeNTimeInt = List.generate(24, (index) => index);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<KittingController>();
    return SafeArea(
      child: Drawer(
        child: BlocSelector<KittingController, KittingState, KittingFilter>(
          selector: (state) => state.kittingFilter,
          builder: (context, filter) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                const ListTile(title: Text('Model')),
                AppAutoComplete(
                  optionsBuilder: (textEditingValue) {
                    return cubit.state.kittingDetails
                        .map((e) => e.model)
                        .where(
                          (element) => element
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()),
                        )
                        .toSet();
                  },
                  onSelect: (value) {
                    // final newList = filter.models.clone()..add(value ?? '');
                    cubit.updateFilter(
                      filter.copyWith(
                        model: value,
                        // models: newList.toSet().toList(),
                      ),
                    );
                  },
                  displayStringForOption: (object) => object,
                ).paddingSymmetric(horizontal: 16),
                if (filter.models.isNotEmpty)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: filter.models
                          .map(
                            (e) => Chip(
                              label: Text(e),
                              onDeleted: () {
                                final newList = filter.models.clone()
                                  ..remove(e);
                                cubit.updateFilter(
                                  filter.copyWith(
                                    model: null,
                                    models: newList.toSet().toList(),
                                  ),
                                );
                              },
                            ),
                          )
                          .toList()
                          .withWidgetBetween(const SizedBox(width: 8)),
                    ).paddingSymmetric(horizontal: 16),
                  ),
                if ([KittingType.subcon, KittingType.outside]
                    .contains(filter.kittingType)) ...[
                  const ListTile(title: Text('Upload No')),
                  AppAutoComplete(
                    optionsBuilder: (textEditingValue) {
                      return cubit.state.kittingDetails
                          .map((e) => e.uploadNo ?? '')
                          .where(
                            (element) => element
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()),
                          )
                          .toSet();
                    },
                    onSelect: (value) =>
                        cubit.updateFilter(filter.copyWith(uploadNo: value)),
                    displayStringForOption: (object) => object,
                  ).paddingSymmetric(horizontal: 16),
                  const ListTile(title: Text('Category')),
                  AppAutoComplete(
                    optionsBuilder: (textEditingValue) {
                      return cubit.state.kittingDetails
                          .map((e) => e.category ?? '')
                          .where(
                            (element) => element
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()),
                          )
                          .toSet();
                    },
                    onSelect: (value) =>
                        cubit.updateFilter(filter.copyWith(category: value)),
                    displayStringForOption: (object) => object,
                  ).paddingSymmetric(horizontal: 16),
                  const ListTile(title: Text('Reason')),
                  AppAutoComplete(
                    optionsBuilder: (textEditingValue) {
                      return cubit.state.kittingDetails
                          .map((e) => e.reason ?? '')
                          .where(
                            (element) => element
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()),
                          )
                          .toSet();
                    },
                    onSelect: (value) =>
                        cubit.updateFilter(filter.copyWith(reason: value)),
                    displayStringForOption: (object) => object,
                  ).paddingSymmetric(horizontal: 16),
                ],
                const ListTile(title: Text('Material')),
                AppAutoComplete(
                  optionsBuilder: (textEditingValue) {
                    return cubit.state.kittingDetails
                        .map((e) => e.material)
                        .where(
                          (element) => element
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()),
                        )
                        .toSet();
                  },
                  onSelect: (value) =>
                      cubit.updateFilter(filter.copyWith(material: value)),
                  displayStringForOption: (object) => object,
                ).paddingSymmetric(horizontal: 16),
                const ListTile(title: Text('Ngày')),
                //Tuấn Anh check ngày
                AppDatePicker(
                  initialDate: filter.deliveryDate,

                  onChanged: (date) => cubit.updateFilter(
                    filter.copyWith(
                      deliveryDate: date,
                      isDay: true,
                    ),
                  ),
                ).paddingSymmetric(horizontal: 16),
                if (filter.kittingType == KittingType.fa) ...[
                  const ListTile(title: Text('Loại Kitting')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AppRadio(
                        value: KittingTimeType.oneTime,
                        title: '1 Lần',
                        groupValue: filter.kittingTimeType,
                        onChanged: (type) async {
                          await kittingNTimeDialog(
                            context,
                            startTime: filter.startTime ?? 0,
                            endTime: filter.endTime ?? 0,
                            isOnTheHour: filter.isOnTheHour,
                            onConfirm: (timeStart, timeEnd, isOnTheHour) async {
                              cubit.updateFilter(
                                filter.copyWith(
                                  kittingTimeType: KittingTimeType.oneTime,
                                  isOnTheHour: isOnTheHour,
                                  startTime: timeStart,
                                  endTime: timeEnd,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      AppRadio(
                        value: KittingTimeType.prepare,
                        title: 'Chuẩn bị',
                        groupValue: filter.kittingTimeType,
                        onChanged: (type) async {
                          await kittingNTimeDialog(
                            context,
                            startTime: filter.startTime ?? 0,
                            endTime: filter.endTime ?? 0,
                            isOnTheHour: filter.isOnTheHour,
                            onConfirm: (timeStart, timeEnd, isOnTheHour) async {
                              cubit.updateFilter(
                                filter.copyWith(
                                  kittingTimeType: KittingTimeType.prepare,
                                  isOnTheHour: isOnTheHour,
                                  startTime: timeStart,
                                  endTime: timeEnd,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      AppRadio(
                        value: KittingTimeType.nTime,
                        title: 'N Lần',
                        groupValue: filter.kittingTimeType,
                        onChanged: (type) async {
                          await kittingNTimeDialog(
                            context,
                            startTime: filter.startTime ?? 0,
                            endTime: filter.endTime ?? 0,
                            isOnTheHour: filter.isOnTheHour,
                            onConfirm: (timeStart, timeEnd, isOnTheHour) async {
                              cubit.updateFilter(
                                filter.copyWith(
                                  kittingTimeType: KittingTimeType.nTime,
                                  isOnTheHour: isOnTheHour,
                                  startTime: timeStart,
                                  endTime: timeEnd,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
                if (filter.kittingType == KittingType.dip)
                  ListTile(
                    leading: const Icon(Icons.access_alarm),
                    title: const Text('Chọn giờ'),
                    onTap: () async {
                      await kittingNTimeDialog(
                        context,
                        startTime: filter.startTime ?? 0,
                        endTime: filter.endTime ?? 0,
                        isOnTheHour: filter.isOnTheHour,
                        onConfirm: (timeStart, timeEnd, isOnTheHour) async {
                          cubit.updateFilter(
                            filter.copyWith(
                              isOnTheHour: isOnTheHour,
                              startTime: timeStart,
                              endTime: timeEnd,
                            ),
                          );
                        },
                      );
                    },
                  ),
                if (filter.isOnTheHour != null)
                  Text('Khung giờ: ${filter.getTimeKittingFormatted()}')
                      .paddingSymmetric(horizontal: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CheckboxListTile(
                        dense: true,
                        value: filter.isKittingEnough,
                        title: const Text('Chưa Kitting'),
                        onChanged: (value) => cubit.updateFilter(
                            filter.copyWith(isKittingEnough: value ?? false)),
                      ),
                    ),
                    if (filter.kittingType == KittingType.fa || filter.kittingType == KittingType.outside)
                      Expanded(
                        flex: 2,
                        child: CheckboxListTile(
                          value: filter.isJIT,
                          title: const Text('JIT'),
                          onChanged: (value) => cubit.updateFilter(
                              filter.copyWith(isJIT: value ?? false)),
                        ),
                      ),
                    if (filter.kittingType == KittingType.dip)
                      Expanded(
                        flex: 3,
                        child: CheckboxListTile(
                          dense: true,
                          value: filter.isUrgent ?? false,
                          title: const Text('Urgent'),
                          onChanged: (value) => cubit.updateFilter(
                            filter.copyWith(isUrgent: value ?? false),
                          ),
                        ),
                      ),
                  ],
                ),
                CheckboxListTile(
                  dense: true,
                  value: filter.isDownstairs,
                  title: const Text('Tầng dưới'),
                  onChanged: (value) => cubit.updateFilter(
                    filter.copyWith(isDownstairs: value ?? false),
                  ),
                ),
                if (filter.kittingType == KittingType.outside)
                  CheckboxListTile(
                    dense: true,
                    value: filter.isSub,
                    title: const Text('Hàng Sub'),
                    onChanged: (value) => cubit.updateFilter(
                      filter.copyWith(isSub: value ?? false),
                    ),
                  ),
                TextButton(
                  onPressed: () {
                    cubit.clearFilter();
                    Navigator.pop(context);
                  },
                  child: const Text('Xoá bộ lọc'),
                ).paddingSymmetric(horizontal: 16),
              ],
            );
          },
        ),
      ),
    );
  }
}
