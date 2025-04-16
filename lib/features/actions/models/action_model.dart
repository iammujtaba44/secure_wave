import 'dart:async';

import 'package:flutter/material.dart';
import 'package:secure_wave/core/theme/app_button.dart';

class PolicyAction {
  final String label;
  final FutureOr<dynamic> Function(BuildContext context) task;
  void Function()? didPressed;

  PolicyAction({
    required this.label,
    required this.task,
    this.didPressed,
  });

  Widget button(BuildContext context) => AppButton(
        text: label,
        onPressed: () async {
          await task(context);
          didPressed?.call();
        },
        type: ButtonType.primary,
      );
}
