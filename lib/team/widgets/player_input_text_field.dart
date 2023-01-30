import 'package:flutter/material.dart';

class PlayerInputTextField extends StatelessWidget {
  PlayerInputTextField({
    super.key,
    required this.onSubmitted,
  });

  final TextEditingController playerNameController = TextEditingController();
  final FocusNode playerNameFocus = FocusNode();
  final void Function(String) onSubmitted;

  void _onSubmitted() {
    if (playerNameController.text.isNotEmpty) {
      onSubmitted(playerNameController.text);
      playerNameController.clear();
      playerNameFocus.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: playerNameController,
            onSubmitted: (_) => _onSubmitted(),
            focusNode: playerNameFocus,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _onSubmitted,
        ),
      ],
    );
  }
}
