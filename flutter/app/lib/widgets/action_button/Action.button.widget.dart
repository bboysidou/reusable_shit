import 'package:flutter/material.dart';

import 'widgets/loading_button_state.dart';

enum ButtonVariant { primary, destructive, outline, secondary, ghost, link }

enum ButtonSize { defaultSize, sm, lg, icon }

final Map<ButtonVariant, ButtonStyle> buttonVariants = {
  ButtonVariant.primary: ElevatedButton.styleFrom(
    shadowColor: Colors.transparent,
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  ButtonVariant.destructive: ElevatedButton.styleFrom(
    backgroundColor: Colors.red.shade600,
    foregroundColor: Colors.white,
    shadowColor: Colors.red.shade900,
  ),
  ButtonVariant.outline: OutlinedButton.styleFrom(
    side: const BorderSide(color: Colors.grey),
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.black,
    elevation: 0,
  ),
  ButtonVariant.secondary: ElevatedButton.styleFrom(
    backgroundColor: Colors.grey.shade200,
    foregroundColor: Colors.black,
    elevation: 0,
  ),
  ButtonVariant.ghost: TextButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.grey,
    elevation: 0,
  ),
  ButtonVariant.link: TextButton.styleFrom(
    shadowColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.blue,
    textStyle: const TextStyle(decoration: TextDecoration.underline),
    elevation: 0,
  ),
};

final Map<ButtonSize, EdgeInsetsGeometry> buttonPadding = {
  ButtonSize.defaultSize: const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  ),
  ButtonSize.sm: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  ButtonSize.lg: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
  ButtonSize.icon: const EdgeInsets.all(12),
};

class ActionButtonLayout extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool withConfirmation;
  final String? confirmationMessage;
  final bool isLoading;
  final bool isDisabled;
  final String label;
  final ButtonVariant variant;
  final ButtonSize size;
  final ButtonStyle? style;

  const ActionButtonLayout({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.defaultSize,
    this.withConfirmation = false,
    this.confirmationMessage,
    this.isLoading = false,
    this.isDisabled = false,
    this.style,
  });

  @override
  State<ActionButtonLayout> createState() => _ActionButtonLayoutState();
}

class _ActionButtonLayoutState extends State<ActionButtonLayout> {
  void _handlePressed() {
    if (widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Are you sure?'),
        content: Text(
          widget.confirmationMessage ?? 'Please confirm your action.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _handlePressed();
            },
            child: widget.isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = buttonVariants[widget.variant];
    final padding = buttonPadding[widget.size] ?? const EdgeInsets.all(12);
    final isButtonDisabled = widget.isDisabled || widget.isLoading;

    return ElevatedButton(
      onPressed: isButtonDisabled
          ? null
          : () {
              if (widget.withConfirmation) {
                _showConfirmationDialog();
              } else {
                _handlePressed();
              }
            },
      style: style?.copyWith(
        elevation: WidgetStateProperty.all(0),
        padding: WidgetStateProperty.all(padding),
      ),
      child: LoadingButtonState(
        isLoading: widget.isLoading,
        child: Text(widget.label),
      ),
    );
  }
}
