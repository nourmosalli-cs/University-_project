import 'package:expenses_graduation_project/src/Dedels/screens/Basic.dart';

import 'package:flutter/material.dart';

class SkipLoginButton extends StatelessWidget {
  final VoidCallback onSkip;

  const SkipLoginButton({super.key, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: const Text(
                'Login will be skipped and no information will be saved. Are you sure?',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancellation'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (e) => const Basic(),
                      ),
                    );
                  },
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
      },
      child: Text('Skip'),
    );
  }
}
