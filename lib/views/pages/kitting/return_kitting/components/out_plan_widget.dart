import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/views/pages/kitting/return_kitting/return_kitting_controller.dart';
import 'package:smart_warehouse/views/pages/kitting/return_kitting/return_kitting_state.dart';
import 'package:smart_warehouse/views/widgets/app_drop_down.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';
import 'package:smart_warehouse/views/widgets/receiving_card_widget.dart';

class OutPlanWidget extends StatefulWidget {
  const OutPlanWidget({super.key});

  @override
  State<OutPlanWidget> createState() => _OutPlanWidgetState();
}

class _OutPlanWidgetState extends State<OutPlanWidget> {
  late TextEditingController _materialController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    _materialController = TextEditingController();
    _quantityController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ReturnKittingController, ReturnKittingState>(
          listenWhen: (preState, state) => preState.material != state.material,
          listener: (_, state) {
            _materialController.text = state.material ?? '';
          },
        ),
        BlocListener<ReturnKittingController, ReturnKittingState>(
          listenWhen: (preState, state) => _quantityController.text.isEmpty &&
              preState.receivingCard != state.receivingCard,
          listener: (_, state) {
            _quantityController.text =
                state.receivingCard?.currentQuantity.toString() ?? '';
          },
        ),
      ],
      child: BlocBuilder<ReturnKittingController, ReturnKittingState>(
        buildWhen: (preState, state) =>
            preState.material != state.material ||
            preState.plant != state.plant ||
            preState.sloc != state.sloc ||
            preState.category != state.category,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    AppText.title('Material: '),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppFormField(
                        autoFocus: true,
                        controller: _materialController,
                        onClear: () => context.read<ReturnKittingController>().clearData(),
                        // decoration: InputDecoration(
                        //   suffixIcon: IconButton(
                        //     onPressed: () async {
                        //       final selectCode =
                        //           await context.pushRoute<String>(
                        //         const CameraCaptureRoute(),
                        //       );
                        //       _materialController.text = selectCode ?? '';
                        //       context
                        //           .read<ReturnKittingController>()
                        //           .updateMaterial(_materialController.text.toUpperCase());
                        //     },
                        //     icon: const Icon(
                        //       Icons.document_scanner,
                        //     ),
                        //   ),
                        // ),
                        onFieldSubmitted: (material) {
                          context
                              .read<ReturnKittingController>()
                              .updateMaterial(material);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    AppText.title('Số lượng:'),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppFormField(
                        autoFocus: true,
                        keyboardType: TextInputType.number,
                        controller: _quantityController,
                        onChanged: (value) {
                          context
                              .read<ReturnKittingController>().updateQuantity(value.toInt());
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          AppText.title('Plant: '),
                          const SizedBox(width: 4),
                          DropdownButton<String>(
                            value: state.plant,
                            icon:
                                const Icon(Icons.keyboard_arrow_down, size: 16),
                            onChanged: (value) {
                              context
                                  .read<ReturnKittingController>()
                                  .updatePlant(value ?? '');
                            },
                            items: state.listPlants
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          AppText.title('Sloc: '),
                          const SizedBox(width: 4),
                          DropdownButton<String>(
                            value: state.sloc,
                            icon:
                                const Icon(Icons.keyboard_arrow_down, size: 16),
                            onChanged: (value) {
                              context
                                  .read<ReturnKittingController>()
                                  .updateSloc(value ?? '');
                            },
                            items: state.listSlocs
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          AppText.title('Cate: '),
                          const SizedBox(width: 4),
                          DropdownButton<String>(
                            value: state.category,
                            icon:
                                const Icon(Icons.keyboard_arrow_down, size: 16),
                            onChanged: (value) {
                              context
                                  .read<ReturnKittingController>()
                                  .updateCategory(value ?? '');
                            },
                            items: state.listCategories
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ).paddingSymmetric(horizontal: 10, vertical: 8),
    );
  }
}
