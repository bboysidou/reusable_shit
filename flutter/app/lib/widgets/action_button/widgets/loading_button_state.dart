import 'package:flutter/material.dart';

class LoadingButtonState extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingButtonState({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(opacity: isLoading ? 0.0 : 1.0, child: child),
        if (isLoading)
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
      ],
    );
  }
}
