import 'package:app/widgets/action_button/Action.button.widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
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
    return Scaffold(
      body: Center(
        child: Column(
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

                print("Button pressed");
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

                print("Button pressed");
              },
            ),
          ],
        ),
      ),
    );
  }
}
