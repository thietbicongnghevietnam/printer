import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/pages/login/login_controller.dart';
import 'package:smart_warehouse/views/pages/login/login_state.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class LoginPage extends BasePage<LoginController, LoginState> {
  const LoginPage({super.key});

  @override
  BasePageState createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginController, LoginState> {
  late TextEditingController idController;
  late FocusNode idFocusNode;
  late PdaDevice pdaDevice;

  @override
  void initState() {
    idController = TextEditingController();
    idFocusNode = FocusNode()..requestFocus();
    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) async {
      idController.text = data;
      await context.read<LoginController>().login(data);

      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        context.router.replaceAll([const HomeRoute()]);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    pdaDevice.dispose();
    super.dispose();
  }

  @override
  Widget builder(context, cubit, state) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          AppText.display(LocaleKeys.app_name, color: Colors.blue).tr(),
          const SizedBox(height: 16),
          Row(
            children: [
              const AppText(LocaleKeys.login_id).tr(),
              const SizedBox(width: 16),
              Expanded(
                child: AppFormField(
                  readOnly: true,
                  showCursor: true,
                  focusNode: idFocusNode,
                  controller: idController,
                  obscureText: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const AppText(LocaleKeys.login_version).tr(args: [state.version]),
          const Spacer(),
          BlocSelector<LoginController, LoginState, bool>(
            selector: (state) => state.newVersion,
            builder: (context, newVersion) {
              return Visibility(
                visible: newVersion,
                child: Column(
                  children: [
                    const Text('SWMS có phiên bản mới'),
                    ElevatedButton(
                      onPressed: () {
                        launchUrl(
                          mode: LaunchMode.externalApplication,
                          Uri.parse(
                              'http://192.168.128.131:8010/app/downloadfile'),
                        );
                      },
                      child: const Text('Cập nhật ngay'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ).paddingAll(16),
    );
  }
}
