import 'package:flutter/material.dart';

class CustomScaffoldWidget extends StatelessWidget {
  final Widget child;
  final AppBar? appBar;
  const CustomScaffoldWidget({required this.child, this.appBar, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar,
      body: SafeArea(
        child: GestureDetector(
          excludeFromSemantics: true,
          behavior: HitTestBehavior.opaque,
          onPanDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(20), //TODO: make this from constants
            child: child,
          ),
        ),
      ),
    );
  }
}
