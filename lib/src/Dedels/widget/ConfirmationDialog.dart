import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ConfirmationDialog({
    Key? key,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sure'),
      content: Text(
          'Are you sure you want to close the window and delete the data?'),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text('Cancellation'),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text('Ok'),
        ),
      ],
    );
  }
}
