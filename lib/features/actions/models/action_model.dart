import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_binary_ui_kit/widgets/widgets.dart';

class PolicyAction {
  final String label;
  final FutureOr<dynamic> Function(BuildContext context) task;
  void Function()? didPressed;

  PolicyAction({
    required this.label,
    required this.task,
    this.didPressed,
  });

  IBButton button(BuildContext context) => IBButton.regular(
        type: IBButtonType.primary,
        backgroundColor: Colors.green,
        title: label,
        onPressed: () async {
          await task(context);
          didPressed?.call();
        },
      );
}
