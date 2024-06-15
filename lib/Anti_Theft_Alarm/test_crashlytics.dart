import 'package:flutter/material.dart';

class TestingCrashlyticsPage extends StatefulWidget {
  const TestingCrashlyticsPage({super.key});

  @override
  State<TestingCrashlyticsPage> createState() => _TestingCrashlyticsPageState();
}

class _TestingCrashlyticsPageState extends State<TestingCrashlyticsPage> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => throw Exception(),
      child: const Text("Throw Test Exception"),
    );
  }
}
