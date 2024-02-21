import 'package:flutter/material.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';

class HubSnackbar {
  static void show({
    required BuildContext context,
    required Widget child,
    Widget? trailing,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            HubTheme.hubBorderRadius * 2,
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            child,
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }
}
