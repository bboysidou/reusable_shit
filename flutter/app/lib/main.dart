import 'package:app/widgets/action_button/Action.button.widget.dart';
import 'package:flutter/material.dart';

import 'core/helpers/theme/global/theme.dart';
import 'widgets/custom_input/Custom_input.widget.dart';
import 'widgets/custom_scafford/Custom_scaffold.widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reusable Shit',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme(),
      darkTheme: AppThemes.darkTheme(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ActionButtonLayout(
            label: "Button Witout Confirmation",
            isLoading: isLoading,
            variant: ButtonVariant.destructive,
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                setState(() {
                  isLoading = false;
                });
              }
            },
          ),
          ActionButtonLayout(
            label: "Button with Confirmation",
            withConfirmation: true,
            confirmationMessage: "Are you sure?",
            isLoading: isLoading,
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                setState(() {
                  isLoading = false;
                });
              }
            },
          ),
          CustomFormFieldWidget(
            controller: TextEditingController(),
            label: "Email",
            fieldType: FieldType.email,
          ),
          CustomFormFieldWidget(
            controller: TextEditingController(),
            label: "Password",
            fieldType: FieldType.password,
          ),
          // LoaderWidget(),
        ],
      ),
    );
  }
}
