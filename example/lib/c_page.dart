import 'package:flutter/material.dart';

class CPage extends StatefulWidget {
  const CPage({super.key});

  @override
  State<CPage> createState() => _CPageState();
}

class _CPageState extends State<CPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("C Page"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("push DPage"),
          onPressed: () {
            Navigator.pushNamed(context, "/d_page");
          },
        ),
      ),
    );
  }
}
