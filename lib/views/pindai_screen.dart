import 'package:flutter/material.dart';

class PindaiScreen extends StatefulWidget {
  final String title;
  const PindaiScreen({super.key, required this.title});

  @override
  State<PindaiScreen> createState() => _PindaiScreenState();
}

class _PindaiScreenState extends State<PindaiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          "Pindai ${widget.title}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [Text("Tempatkan ${widget.title} Anda di dalam kotak.")],
      ),
    );
  }
}
