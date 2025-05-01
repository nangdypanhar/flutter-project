import 'package:flutter/material.dart';

enum SnackBarType { success, error }

class SnackBarHelper {
  static void showRaceSnackBar(
    BuildContext context,
    String message,
    SnackBarType type,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        backgroundColor:
            type == SnackBarType.success ? Colors.green : Colors.red,
      ),
    );
  }
}
