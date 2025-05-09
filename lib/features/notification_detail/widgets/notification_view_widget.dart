import 'package:flutter/material.dart';
import 'package:secure_wave/core/theme/app_theme.dart';

class NotificationDetailItemWidget extends StatelessWidget {
  const NotificationDetailItemWidget({
    super.key,
    required this.keyText,
    required this.valueText,
  });

  final String keyText;
  final String valueText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            keyText,
            style: context.theme.textTheme.bodySmall,
          ),
        ),
        NotificationViewWidget(
          child: Text(
            valueText,
            style: context.theme.textTheme.bodyMedium,
          ),
        )
      ],
    );
  }
}

class NotificationViewWidget extends StatelessWidget {
  const NotificationViewWidget({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}
