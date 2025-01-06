import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_binary_ui_kit/infinite_binary_ui_kit.dart';
import 'package:secure_wave/features/emergency/view/tabs/alert_tab.dart';
import 'package:secure_wave/features/emergency/view/tabs/faq_tab.dart';
import 'package:secure_wave/features/emergency/view/tabs/notifications_tab.dart';

@RoutePage()
class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {},
      canPop: false,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.red.shade50,
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text(
              'EMERGENCY NOTICE',
              style: context.headlineSmallStyle?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.warning), text: 'Alert'),
                Tab(icon: Icon(Icons.question_answer), text: 'FAQ'),
                Tab(icon: Icon(Icons.notifications), text: 'Notices'),
              ],
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.white,
            ),
            automaticallyImplyLeading: false,
          ),
          body: const TabBarView(
            children: [
              AlertTab(),
              FAQTab(),
              NotificationsTab(),
            ],
          ),
        ),
      ),
    );
  }
}
