import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/repositories/auth_repository.dart';

import '../../../shared/router/auth_guard.gr.dart';
import 'package:smart_warehouse/ViewUI/InspectionSample.dart';
import 'package:smart_warehouse/ViewUI/RecheckInspection.dart';

import 'package:smart_warehouse/ViewUI/Hang1NamInspection.dart';

import 'package:smart_warehouse/ViewUI/StatusInspection.dart';

import 'package:smart_warehouse/ViewUI/FindLocation.dart';

import 'package:smart_warehouse/ViewUI/PrintReceivingCardPage.dart';
// import 'package:smart_warehouse/ViewUI/testfocusdelay.dart';

import 'package:smart_warehouse/ViewUI/SupllyKittingOutside.dart';


@RoutePage()
class IQCMenuPage extends StatefulWidget {
  const IQCMenuPage({super.key});

  @override
  State<IQCMenuPage> createState() => _IQCMenuPageState();
}

class _IQCMenuPageState extends State<IQCMenuPage> {
  String userId = "";

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() async {
      userId = await getIt<AuthRepository>().getUserID();
      print(userId);
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', '');
  //2026
    // if (mounted) {
    //   // Quay về Login bằng auto_route
    //   context.router.replaceAll([const LoginRoute()]);
    // }
  }

  void _backHome() {
    // navigate(): neu HomeRoute da co trong stack thi pop ve dung trang do,
    // neu chua co thi push moi. Khong xoa username de cac man IQC van dung duoc.
    context.router.navigate(const HomeRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IQC Menu'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Welcome
            // Container(
            //   height: 50,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(30),
            //     boxShadow: const [
            //       BoxShadow(
            //         color: Color(0xFFd8dbe0),
            //         offset: Offset(1, 1),
            //         blurRadius: 20,
            //         spreadRadius: 10,
            //       )
            //     ],
            //   ),
            //   child: Center(
            //     child: Text(
            //       'Welcome: $userId',
            //       style: const TextStyle(
            //         fontWeight: FontWeight.w700,
            //         fontSize: 16,
            //       ),
            //     ),
            //   ),
            // ),
            //
            // const SizedBox(height: 20),

            // 1. Inspection IQC
            _buildButton(
              title: '1. Inspection IQC',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckInspection()),
                );
              },
            ),
            const SizedBox(height: 5),

            // 2. Inspection Recheck
            _buildButton(
              title: '2. Inspection Recheck',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecheckInspection()),
                );
              },
            ),
            const SizedBox(height: 5),

            // 3. Inspection more 1Year
            _buildButton(
              title: '3. Inspection more 1Year',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Hang1NamInspection()),
                );
              },
            ),
            const SizedBox(height: 5),

            // 4. Check Status Inspection
            _buildButton(
              title: '4. Check Status Inspection',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatusInspection()),
                );
              },
            ),
            const SizedBox(height: 5),

            // 5. Find Location
            _buildButton(
              title: '5. Find Location',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Findlocation()),
                );
              },
            ),
            const SizedBox(height: 5),

            // 6. Print Receiving Card
            _buildButton(
              title: '6. Print Receiving Card',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrintReceivingCardPage()),
                );
              },
            ),
            const SizedBox(height: 5),

            // 7. update kitting outside
            _buildButton(
              title: '7. Supply kitting outside',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SupllyKittingOutside()),
                );
              },
            ),

            // const SizedBox(height: 10),
            //
            // // 8. Others
            // _buildButton(
            //   title: '8. Others',
            //   onPressed: () {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) => Testfocus()),
            //     // );
            //   },
            // ),

            const Spacer(),

            // Back Home
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _backHome,
                child: const Text('Back Home'),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required String title,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}