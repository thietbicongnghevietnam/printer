import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/extensions/table_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/pages/kitting/kitting_trolley/check_trolley/check_trolley_controller.dart';
import 'package:smart_warehouse/views/pages/kitting/kitting_trolley/check_trolley/check_trolley_state.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

@RoutePage()
class CheckTrolleyPage extends BasePage<CheckTrolleyController, CheckTrolleyState> {
  const CheckTrolleyPage({super.key});

  @override
  BasePageState createState() => _CheckTrolleyPageState();
}

class _CheckTrolleyPageState extends BasePageState<CheckTrolleyController, CheckTrolleyState> {
  late TextEditingController _codeController;
  late PdaDevice pdaDevice;

  @override
  void initState() {
    final controller = context.read<CheckTrolleyController>();
    _codeController = TextEditingController();
    pdaDevice = getIt<PdaDevice>();

    pdaDevice.listen(context, (data) {
        _codeController.text = data;
    });
    super.initState();
  }

 @override
  Widget builder(BuildContext context, CheckTrolleyController cubit, CheckTrolleyState state) {
   return BlocListener<CheckTrolleyController, CheckTrolleyState>(
     listenWhen: (pre, current) => pre.trolley != current.trolley,
     listener: (context, state) {
       ScaffoldMessenger.of(context).clearSnackBars();
       _codeController.text = state.barcode ?? '';
     },
     child: Scaffold(
       appBar: AppBar(
         title: const Text('Revert Kitting'),
       ),
       body: Column(
         children: [
          Row(
            children: [
              const Text('Kitting Card:'),
              Expanded(
                child: AppFormField(
                  readOnly: true,
                  controller: _codeController,
                  autoFocus: true,
                ),
              ),
            ],
          ),
           const Divider(),
           if (state.kittingLists.isNotEmpty)
             BlocBuilder<CheckTrolleyController, CheckTrolleyState>(
               builder: (context, state) {
                 return SingleChildScrollView(
                   child: ListView.separated(
                     shrinkWrap: true,
                     itemBuilder: (context, index) {
                       final kittingList= state.kittingLists[index];
                       return Container(
                         padding: const EdgeInsets.symmetric(horizontal: 10),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           border: Border.all(
                             color: Colors.black,
                           ),
                           color: Colors.greenAccent.shade100,
                         ),
                         child: Column(
                           children: [
                             const Center(
                               child: Text(
                                 'Kitting List',
                                 style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   fontSize: 15,
                                 ),
                               ),
                             ),
                             const SizedBox(
                               height: 10,
                             ),
                             Table(
                               defaultVerticalAlignment:
                               TableCellVerticalAlignment.middle,
                               columnWidths: const {
                                 0: FixedColumnWidth(80),
                                 1: FlexColumnWidth(),
                               },
                               children: [
                                 TableRow(
                                   children: [
                                     const Text('Model:'),
                                     Text(
                                       kittingList.model ?? '',
                                       style: const TextStyle(
                                         fontWeight: FontWeight.bold,
                                       ),
                                     ),
                                   ],
                                 ),
                                 TableRow(
                                   children: [
                                     const Text('Location:'),
                                     Text(
                                       '${kittingList.quantity}',
                                       style: const TextStyle(
                                         fontWeight: FontWeight.bold,
                                       ),
                                     ),
                                   ],
                                 ),
                               ].withSpaceBetween(5),
                             ),
                           ],
                         ).paddingSymmetric(vertical: 10),
                       ).paddingSymmetric(horizontal: 20, vertical: 10);
                     },
                     itemCount: state.kittingLists.length,
                     separatorBuilder: (context, index) {
                       return const SizedBox(
                         height: 5,
                       );
                     },
                   ),
                 );
               },
               buildWhen: (pre, current) =>
               pre.kittingLists != current.kittingLists,
             )
           else
             const SizedBox(
               child: Center(
                 child: Text(
                   'Vui Lòng Quét Trolley',
                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                 ),
               ),
             ),
         ],
       ),
     ),
   );
  }
}
