import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';

import 'material_sample_controller.dart';
import 'material_sample_state.dart';

@RoutePage()
class MaterialSamplePage
    extends BasePage<MaterialSampleController, MaterialSampleState> {
  const MaterialSamplePage({
    super.key,
    required this.material,
  });

  final String material;

  @override
  BasePageState createState() => _MaterialSamplePage(material: material);
}

class _MaterialSamplePage
    extends BasePageState<MaterialSampleController, MaterialSampleState> {
  _MaterialSamplePage({required this.material});

  final String material;

  @override
  void initState() {
    context.read<MaterialSampleController>().initDataMaterial(material);

    super.initState();
  }

  @override
  Widget builder(context, cubit, state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.storing_sample).tr(),
      ),
      body: BlocBuilder<MaterialSampleController, MaterialSampleState>(
        buildWhen: (prev, current) {
          return prev.materialSample != current.materialSample;
        },
        builder: (context, state) {
          Uint8List? bytes;
          if (state.materialSample?.fileBase64 != null &&
              state.materialSample!.fileBase64!.isNotEmpty) {
            bytes = const Base64Codec()
                .decode(state.materialSample?.fileBase64 ?? '');
          }
          logger.i('bytes $bytes');
          logger.i('fileBase ${state.materialSample?.fileBase64}');
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.storing_material_detail.tr(),
                      style: const TextStyle(
                        color: Color(0xff53B1F5),
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(
                    state.materialSample?.material ?? '',
                    style: const TextStyle(
                      color: Color(0xff0A2753),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Divider(color: Colors.grey.withOpacity(0.3)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.storing_model_name.tr(),
                      style: const TextStyle(
                        color: Color(0xff53B1F5),
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(
                    state.materialSample?.name ?? '',
                    style: const TextStyle(
                      color: Color(0xff0A2753),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Divider(color: Colors.grey.withOpacity(0.3)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.storing_feature.tr(),
                      style: const TextStyle(
                        color: Color(0xff53B1F5),
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(
                    state.materialSample?.description ?? '',
                    style: const TextStyle(
                      color: Color(0xff0A2753),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Divider(color: Colors.grey.withOpacity(0.3)),
              const SizedBox(height: 16),
              if (state.materialSample?.fileBase64 != null &&
                  state.materialSample!.fileBase64!.isNotEmpty)
                Image.memory(
                  bytes!,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                ),
              // CachedNetworkImage(
              //   imageUrl: state.materialSample?.filePath ?? '',
              //   imageBuilder: (context, imageProvider) => Container(
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //           image: imageProvider,
              //           fit: BoxFit.cover,
              //           colorFilter: const ColorFilter.mode(
              //               Colors.red, BlendMode.colorBurn)),
              //     ),
              //   ),
              //   placeholder: (context, url) =>
              //       const CircularProgressIndicator(),
              //   errorWidget: (context, url, error) => const Icon(Icons.error),
              // )
            ],
          ).paddingSymmetric(horizontal: 20, vertical: 16);
        },
      ),
    );
  }
}
