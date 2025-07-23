import 'package:app/core/helpers/constants.dart';
import 'package:app/core/helpers/theme/Custom_colors.dart';
import 'package:flutter/material.dart';

import '../dialog/Custom_dialog.widget.dart';
import 'widgets/loading_button_state.dart';

enum ButtonVariant { primary, destructive, outline, secondary, ghost, link }

enum ButtonSize { defaultSize, sm, lg, icon }

final Map<ButtonVariant, ButtonStyle> buttonVariants = {
  ButtonVariant.primary: ElevatedButton.styleFrom(
    shadowColor: Colors.transparent,
    backgroundColor: ColorsManager.primary,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  ButtonVariant.destructive: ElevatedButton.styleFrom(
    backgroundColor: ColorsManager.destructive,
    foregroundColor: Colors.white,
  ),
  ButtonVariant.outline: OutlinedButton.styleFrom(
    side: const BorderSide(color: ColorsManager.border),
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.black,
    elevation: 0,
  ),
  ButtonVariant.secondary: ElevatedButton.styleFrom(
    backgroundColor: ColorsManager.secondary,
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
    foregroundColor: ColorsManager.primary,
    textStyle: const TextStyle(decoration: TextDecoration.underline),
    elevation: 0,
  ),
};

final Map<ButtonSize, EdgeInsetsGeometry> buttonPadding = {
  ButtonSize.defaultSize: const EdgeInsets.symmetric(
    horizontal: Constants.paddingMD,
    vertical: Constants.paddingSM,
  ),
  ButtonSize.sm: const EdgeInsets.symmetric(
    horizontal: Constants.paddingSM,
    vertical: Constants.paddingXS,
  ),
  ButtonSize.lg: const EdgeInsets.symmetric(
    horizontal: Constants.paddingMD,
    vertical: Constants.paddingSM,
  ),
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
  final double? radius;

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
    this.radius = Constants.radiusMD,
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

  void _showConfirmationDialog() async {
    await showAppDialog(
      context: context,
      title: 'Are you sure?',
      content: const Text('Do you really want to this?'),
      confirmText: 'Yes',
      confirmColor: ColorsManager.destructive,
      withConfirmation: true,
      onConfirm: () {
        _handlePressed();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = buttonVariants[widget.variant];
    final padding =
        buttonPadding[widget.size] ?? const EdgeInsets.all(Constants.paddingMD);
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
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.radius ?? 0),
          ),
        ),
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
