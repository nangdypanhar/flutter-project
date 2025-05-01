import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/race_snack_bar.dart';

class ConfirmDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;

  const ConfirmDialog({
    super.key,
    required this.onConfirm,
    this.title = 'Confirm Action',
    this.content = 'Are you sure you want to proceed?',
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
  });

  Future<void> show(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            SnackBarHelper.showRaceSnackBar(
                  context,
                  "Participant deleted successfully",
                  SnackBarType.success,
                );
            Navigator.of(context).pop();
          },
          child: Text(confirmText),
        ),
      ],
    );
  }
}