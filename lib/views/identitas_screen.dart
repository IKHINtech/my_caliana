import 'package:flutter/material.dart';
import 'package:my_caliana/views/pindai_screen.dart';
import 'package:my_caliana/widgets/custom_button.dart';

class IdentitasScreen extends StatefulWidget {
  const IdentitasScreen({super.key});

  @override
  State<IdentitasScreen> createState() => _IdentitasScreenState();
}

class _IdentitasScreenState extends State<IdentitasScreen> {
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
          "Pilih Kartu Identitas",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 20.0, // Jarak antara elemen dalam satu baris
          crossAxisSpacing: 20.0,
          childAspectRatio: 1.9,
          scrollDirection: Axis.vertical,
          children: [
            CustomButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PindaiScreen(title: "e-KTP"),
                      ));
                },
                icon: Icon(Icons.abc),
                title: "e-KTP"),
            CustomButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PindaiScreen(title: "SIM"),
                      ));
                },
                icon: Icon(Icons.abc),
                title: "SIM"),
            CustomButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PindaiScreen(title: "Paspor"),
                      ));
                },
                icon: Icon(Icons.abc),
                title: "Paspor"),
            CustomButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PindaiScreen(title: "Lainnya"),
                      ));
                },
                icon: Icon(Icons.abc),
                title: "Lainnya"),
          ],
        ),
      ),
    );
  }
}
