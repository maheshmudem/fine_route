import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../di/injection_container.dart';
import '../../domain/entities/device_session.dart';
import '../bloc/device_bloc.dart';
import '../bloc/device_event.dart';
import '../bloc/device_state.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DeviceBloc>()..add(LoadDevicesEvent()),
      child: const _DeviceView(),
    );
  }
}

class _DeviceView extends StatelessWidget {
  const _DeviceView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.iconColor),
          onPressed: () => context.pop(),
        ),
        title: const AppText.headlineSmall(
          'Security Settings',
          color: AppColors.textHeading,
        ),
        backgroundColor: AppColors.surfaceColor,
        elevation: 0,
      ),
      body: BlocListener<DeviceBloc, DeviceState>(
        listener: (context, state) {
          if (state is DeviceError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
            );
          } else if (state is DeviceActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Device removed successfully'), backgroundColor: Colors.green),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderInfo(),
            _buildSearchBar(),
            Expanded(
              child: BlocBuilder<DeviceBloc, DeviceState>(
                buildWhen: (previous, current) => current is! DeviceActionLoading && current is! DeviceActionSuccess,
                builder: (context, state) {
                  if (state is DeviceLoading) {
                    return const Center(child: AppLoader());
                  } else if (state is DeviceError && state.message.contains('Failed')) {
                    // Only show full screen error if no devices loaded
                    return Center(child: AppText.bodyMedium(state.message, color: AppColors.error));
                  } else if (state is DeviceLoaded) {
                    final devices = state.devices;
                    if (devices.isEmpty) {
                      return const Center(child: AppText.bodyMedium('No active devices found', color: AppColors.textBody));
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: devices.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        return _buildDeviceCard(context, devices[index]);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText.headlineMedium(
            'Registered Devices & Hardware',
            color: AppColors.textHeading,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 8),
          AppText.bodyMedium(
            'Authorized hardware & devices linked to your account with device management permissions.',
            color: AppColors.textBody.withValues(alpha: 0.8),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Search device name, browser, or IP...',
            hintStyle: TextStyle(color: AppColors.textBody, fontSize: 14),
            prefixIcon: Icon(Icons.search, color: AppColors.textBody),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceCard(BuildContext context, DeviceSession device) {
    final parsedDevice = _parseUserAgent(device.userAgent);
    final dateStr = DateFormat('M/d/yyyy').format(device.lastActivityAt);
    final ipStr = device.ipAddress ?? 'Unknown IP';
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(parsedDevice.icon, color: AppColors.primary, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AppText.bodyLarge(
                            parsedDevice.name,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textHeading,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (device.isActive)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'TRUSTED',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.router, size: 14, color: AppColors.textBody),
                        const SizedBox(width: 4),
                        AppText.bodyMedium(ipStr, color: AppColors.textBody),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.bodySmall('Last used $dateStr', color: AppColors.textBody),
              OutlinedButton.icon(
                onPressed: () {
                  context.read<DeviceBloc>().add(RevokeDeviceEvent(device.id));
                },
                icon: const Icon(Icons.delete_outline, size: 16, color: AppColors.error),
                label: const Text(
                  'Remove\nDevice',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: AppColors.error, height: 1.1),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.error.withValues(alpha: 0.3)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _ParsedDevice _parseUserAgent(String userAgent) {
    final ua = userAgent.toLowerCase();
    
    String name = 'Authorized Device';
    IconData icon = Icons.laptop_mac;

    if (ua.contains('iphone') || ua.contains('ipad') || ua.contains('ios')) {
      name = 'Mobile App (iOS)';
      icon = Icons.smartphone;
    } else if (ua.contains('android')) {
      name = 'Mobile App (Android)';
      icon = Icons.smartphone;
    } else if (ua.contains('windows')) {
      name = 'Windows Workstation';
      icon = Icons.laptop_windows;
    } else if (ua.contains('mac')) {
      name = 'Mac Workstation';
      icon = Icons.laptop_mac;
    } else if (ua.contains('linux')) {
      name = 'Linux Workstation';
      icon = Icons.laptop;
    }

    return _ParsedDevice(name, icon);
  }
}

class _ParsedDevice {
  final String name;
  final IconData icon;

  _ParsedDevice(this.name, this.icon);
}
