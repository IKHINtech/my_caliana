import 'package:flutter/material.dart';

class FormulirRegistrasiScreen extends StatefulWidget {
  const FormulirRegistrasiScreen({super.key});

  @override
  State<FormulirRegistrasiScreen> createState() =>
      _FormulirRegistrasiScreenState();
}

class _FormulirRegistrasiScreenState extends State<FormulirRegistrasiScreen> {
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
          "Formulir Registrasi",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
