import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/pages/kitting/find_kitting_list/find_kitting_list_state.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

import 'find_kitting_list_controller.dart';

@RoutePage()
class FindKittingListPage
    extends BasePage<FindKittingListController, FindKittingListState> {
  const FindKittingListPage({super.key});

  @override
  BasePageState createState() => _FindKittingListFaPageState();
}

class _FindKittingListFaPageState
    extends BasePageState<FindKittingListController, FindKittingListState> {
  late TextEditingController _codeController;
  late PdaDevice pdaDevice;
  late FocusNode _codeControllerFocusNode;

  @override
  void initState() {
    super.initState();
    pdaDevice = getIt<PdaDevice>();
    _codeController = TextEditingController();
    pdaDevice.listen(context, (data) async {
      await context.read<FindKittingListController>().scanKittingCard(data);
      _codeController.text = data;
    });
    _codeControllerFocusNode = FocusNode()..requestFocus();
  }

  @override
  Widget builder(
    BuildContext context,
    FindKittingListController cubit,
    FindKittingListState state,
  ) {
    return BlocListener<FindKittingListController, FindKittingListState>(
      listenWhen: (prev, current) {
        return prev.kittingList != current.kittingList ||
            prev.codeTrolleys != current.codeTrolleys;
      },
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Find Kitting List'),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<FindKittingListController, FindKittingListState>(
      buildWhen: (prev, current) {
        return prev.kittingList != current.kittingList ||
            prev.codeTrolleys != current.codeTrolleys;
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: [
                  const Text('Scan Kitting Card:'),
                  const SizedBox(width: 20),
                  Expanded(
                    child: AppFormField(
                      controller: _codeController,
                      focusNode: _codeControllerFocusNode,
                      readOnly: true,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            if (state.kittingList != null && state.codeTrolleys.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Text(
                      LocaleKeys.kitting_trolley_list.tr(),
                    ),
                    const SizedBox(height: 15),
                    SingleChildScrollView(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.codeTrolleys.length,
                        itemBuilder: (_, i) {
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.greenAccent.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(
                                    2,
                                    1,
                                  ), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Text('Code: ${state.codeTrolleys[i]}'),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 15);
                        },
                      ),
                    ),
                  ],
                ),
              )
            else
              const Center(
                  child: Text(
                'Vui lòng quét Kitting Card',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          ],
        );
      },
    );
  }
}
