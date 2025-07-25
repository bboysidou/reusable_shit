import 'package:flutter/material.dart';

import 'dart:ui';

import '../../core/helpers/theme/Custom_colors.dart';

Future<void> showAppDialog({
  required BuildContext context,
  required String title,
  required Widget content,
  VoidCallback? onConfirm,
  bool withConfirmation = false,
  String cancelText = 'Cancel',
  String confirmText = 'OK',
  Color? confirmColor,
  bool barrierDismissible = true,
}) {
  assert(
    !withConfirmation || onConfirm != null,
    'onConfirm must be provided when withConfirmation is true.',
  );

  final theme = Theme.of(context);
  final confirmButtonColor = confirmColor ?? theme.colorScheme.primary;

  return showGeneralDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: ColorsManager.backgroundDark.withValues(alpha: 0.5),
    pageBuilder: (context, animation, secondaryAnimation) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Center(
          child: AlertDialog(
            backgroundColor: theme.colorScheme.surface,
            surfaceTintColor: Colors.transparent,
            title: Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            content: content,
            actions: withConfirmation
                ? [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        cancelText,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: confirmButtonColor,
                        foregroundColor: theme.colorScheme.onPrimary,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onConfirm?.call();
                      },
                      child: Text(confirmText),
                    ),
                  ]
                : [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "Ok",
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
