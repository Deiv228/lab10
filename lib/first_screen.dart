import 'package:flutter/material.dart';
import 'second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _inputController = TextEditingController();
  double _selectedSize = 25;

  static const _robotIcon =
      'https://emojiisland.com/cdn/shop/products/Robot_Emoji_Icon_abe111a-1293-4668-bdf9-9ceb05cff58e_large.png?v=1571606090';

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _navigateToPreview() async {
    final action = await Navigator.push<PreviewAction>(
      context,
      MaterialPageRoute(
        builder: (_) => SecondScreen(
          previewText: _inputController.text,
          textSize: _selectedSize,
        ),
      ),
    );

    if (!mounted) return;

    final dialogText = switch (action) {
      PreviewAction.ok => 'Cool!',
      PreviewAction.cancel => "Let's try something else",
      null => "Don't know what to say",
    };

    _showFeedbackDialog(dialogText);
  }

  void _showFeedbackDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              _robotIcon,
              height: 54,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.smart_toy_outlined,
                size: 54,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text('Text previewer'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _inputController,
                decoration: const InputDecoration(
                  labelText: 'Text',
                  helperText: 'Enter some text',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Text('Font size: ${_selectedSize.toInt()}'),
                  Expanded(
                    child: Slider(
                      value: _selectedSize,
                      min: 10,
                      max: 100,
                      onChanged: (newValue) {
                        setState(() => _selectedSize = newValue);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              FilledButton(
                onPressed: _navigateToPreview,
                child: const Text('Preview'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}