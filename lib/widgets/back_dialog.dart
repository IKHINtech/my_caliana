import 'package:flutter/material.dart';
import 'package:my_caliana/views/beranda_screen.dart';

void showBackDialog({
  required BuildContext context,
}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
    ),
    builder: (BuildContext context) {
      return SizedBox(
        height: 180,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: const [
                    Text(
                      "Semua data tidak akan disimpan.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Yakin ingin membatalkan?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey, width: 0.1),
                      ),
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        textStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      child: const Text('Ya, batalkan'),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BerandaScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.red,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      child: const Text('Tidak, kembali'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}
