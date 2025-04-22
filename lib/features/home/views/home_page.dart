import 'dart:async';
import 'package:device_admin_manager/device_manager.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
import 'package:secure_wave/core/providers/app_status_provider/app_status_provider.dart';
import 'package:secure_wave/core/services/notification_service/notification_service.dart';
import 'package:secure_wave/features/shared/widgets/custom_dropdown_selector.dart';
import 'package:secure_wave/features/shared/widgets/setup_section.dart';
import 'package:secure_wave/features/shared/widgets/setup_message_widget.dart';
import 'package:secure_wave/main.dart';
import 'package:secure_wave/routes/app_routes.dart';
import 'package:secure_wave/core/services/locator_service.dart';
import 'package:secure_wave/features/companies/models/companies_model.dart';
import 'package:secure_wave/features/shared/widgets/company_selector_bottom_sheet.dart';
import 'package:secure_wave/features/shared/widgets/company_ownership_card.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  bool _isSetupComplete = false;
  Companies? _selectedCompany;
  bool _isAllPermissionsGranted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _checkPermissions();
    });
  }

  Future<void> _onInit() async {
    _initNotificationService();
  }

  void _checkPermissions() async {
    _isAllPermissionsGranted = await AppStatusHandler.checkPermissions();
    setState(() {});
  }

  void _showCompanySelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CompanySelectorBottomSheet(
        onCompanySelected: (company) {
          setState(() {
            _selectedCompany = company;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appStatusProvider = context.watch<AppStatusProvider>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (appStatusProvider.branchId != null && appStatusProvider.companyId != null) ...[
                CompanyOwnershipCard(
                  company: Companies(
                    companyId: appStatusProvider.companyId!,
                    branchId: appStatusProvider.branchId!,
                    companyName: appStatusProvider.companyName!,
                    branchName: appStatusProvider.branchName!,
                  ),
                )
              ] else if (_isAllPermissionsGranted) ...[
                Center(child: const LoadingState())
              ] else ...[
                SetupMessageWidget(
                  isLoading: _isLoading,
                  hasCompanySelected: _selectedCompany != null,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomDropdownSelector(
                    label: _selectedCompany != null
                        ? '${_selectedCompany!.companyName} - ${_selectedCompany!.branchName}'
                        : 'Select Company & Branch',
                    onTap: _showCompanySelector,
                    isSelected: _selectedCompany != null,
                  ),
                ),
                const SizedBox(height: 16),
                if (_selectedCompany != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SetupSection(
                      isLoading: _isLoading,
                      isSetupComplete: _isSetupComplete,
                      onSetup: () async {
                        _onSetup();
                      },
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _initNotificationService() {
    locator.get<INotificationService>().initialize((result) {
      if (result.route != null) {
        AppStatusHandler.handleStatusChange(
          dam: DeviceAdminManager.instance,
          status: result.route!,
        );

        context.read<AppStatusProvider>().updateStatus(result.route!);
        return;
      }
      if (context.router.current.name != NotificationDetailRoute.name) {
        context.router.push(NotificationDetailRoute(notification: result));
      } else {
        context.router.replace(NotificationDetailRoute(notification: result));
      }
    });
  }

  void _onSetup() async {
    if (AppStatusHandler.checkPermissions() == true) {
      _isSetupComplete = true;
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      await AppStatusHandler.setAdminRestrictions();
      await _onInit();
      context.read<AppStatusProvider>().initializeStatusListener(company: _selectedCompany);
      context.read<AppStatusProvider>().initializeAndStoreToken();
      setState(() {
        _isLoading = false;
        _isSetupComplete = true;
      });

      await backgroundTask();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
