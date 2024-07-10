import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:my_caliana/const/colors.dart';
import 'package:my_caliana/main.dart';
import 'package:my_caliana/views/pindai_screen.dart';
import 'package:my_caliana/widgets/custom_appbar.dart';
import 'package:my_caliana/widgets/custom_bg.dart';
import 'package:my_caliana/widgets/custom_button.dart';
import 'package:my_caliana/widgets/rounded_button.dart';

class IdentitasScreen extends StatefulWidget {
  const IdentitasScreen({super.key});

  @override
  State<IdentitasScreen> createState() => _IdentitasScreenState();
}

class _IdentitasScreenState extends State<IdentitasScreen> {
  final TextEditingController _otherController = TextEditingController();

  void showOtherDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              height: 230,
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Masukkan kartu Identitas Lainnya",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Masukkan kartu Identitas Lainnya",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                      TextField(
                        controller: _otherController,
                        decoration: InputDecoration(
                          isDense: true,
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: mainColor),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: mainColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: RoundedButton(
                          isSmal: true,
                          title: "Batal",
                          isMain: false,
                          onPressed: () {
                            Navigator.pop(context);
                            _otherController.text = "";
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 2,
                        child: ValueListenableBuilder<TextEditingValue>(
                          valueListenable: _otherController,
                          builder: (BuildContext context,
                                  TextEditingValue value, _) =>
                              InkWell(
                            onTap: value.text != ""
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PindaiScreen(
                                          title: value.text,
                                          cameras: cameras,
                                        ),
                                      ),
                                    );
                                  }
                                : null,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: value.text != ""
                                    ? mainColor
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(18),
                                border: null,
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Selanjutnya",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _otherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: customBg(
        context,
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: customAppbar(
            context,
            "Pilih Kartu Identitas",
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20),
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
                          builder: (context) => PindaiScreen(
                            title: "e-KTP",
                            cameras: cameras,
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      TablerIcons.id,
                      color: customGrey,
                      size: 18,
                    ),
                    title: "e-KTP"),
                CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PindaiScreen(title: "SIM", cameras: cameras),
                        ),
                      );
                    },
                    icon: Icon(
                      TablerIcons.id,
                      color: customGrey,
                      size: 18,
                    ),
                    title: "SIM"),
                CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PindaiScreen(title: "Paspor", cameras: cameras),
                        ),
                      );
                    },
                    icon: Icon(
                      TablerIcons.id,
                      color: customGrey,
                      size: 18,
                    ),
                    title: "Paspor"),
                CustomButton(
                    onPressed: () {
                      _otherController.text = "";
                      showOtherDialog(context);
                    },
                    icon: Icon(
                      TablerIcons.id,
                      color: customGrey,
                      size: 18,
                    ),
                    title: "Lainnya"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
