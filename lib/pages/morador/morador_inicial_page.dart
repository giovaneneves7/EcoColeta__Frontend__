import 'package:flutter/material.dart';

class MoradorInicialPage extends StatefulWidget {
  const MoradorInicialPage({super.key});

  @override
  State<MoradorInicialPage> createState() => _MoradorInicialPageState();
}

class _MoradorInicialPageState extends State<MoradorInicialPage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: []),
          ),
        ),
      ),
    );
  }
}
