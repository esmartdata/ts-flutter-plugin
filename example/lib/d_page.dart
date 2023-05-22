import 'package:flutter/material.dart';

class DPage extends StatefulWidget {
  const DPage({super.key});

  @override
  State<DPage> createState() => _DPageState();
}

class _DPageState extends State<DPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("D Page"),
      ),
      body: const Center(
        child: Text("D Page"),
      ),
    );
  }
}
