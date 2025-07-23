import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  final double size;
  const LoaderWidget({this.size = 50, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).colorScheme.surface,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
