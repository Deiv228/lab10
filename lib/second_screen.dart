import 'package:flutter/material.dart';

enum PreviewAction { ok, cancel }

class SecondScreen extends StatelessWidget {
  final String previewText;
  final double textSize;

  const SecondScreen({
    super.key,
    required this.previewText,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text('Preview'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                previewText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: textSize),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    onPressed: () => Navigator.pop(context, PreviewAction.ok),
                    child: const Text('Ok'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () =>
                        Navigator.pop(context, PreviewAction.cancel),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}