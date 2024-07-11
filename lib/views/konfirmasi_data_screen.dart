import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:my_caliana/const/colors.dart';
import 'package:my_caliana/model/user.dart';
import 'package:my_caliana/provider/user_provider.dart';
import 'package:my_caliana/views/beranda_screen.dart';
import 'package:my_caliana/widgets/back_dialog.dart';
import 'package:my_caliana/widgets/custom_appbar.dart';
import 'package:my_caliana/widgets/custom_label.dart';
import 'package:my_caliana/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class KonfirmasiDataScreen extends StatefulWidget {
  const KonfirmasiDataScreen({super.key});

  @override
  State<KonfirmasiDataScreen> createState() => KonfirmasiDataScreenState();
}

class KonfirmasiDataScreenState extends State<KonfirmasiDataScreen> {
  final ValueNotifier<List<bool>> _isOpen =
      ValueNotifier<List<bool>>([true, true]);
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();

  @override
  void initState() {
    final UserProvider provider =
        Provider.of<UserProvider>(context, listen: false);
    final User? user = provider.user;
    if (user != null) {
      _name.text = user.name!;
      _email.text = user.email!;
    }
    super.initState();
  }

  @override
  void dispose() {
    _isOpen.dispose();
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        showBackDialog(
          context: context,
        );
      },
      child: Scaffold(
        appBar: customAppbar(
          context,
          "Konfirmasi Data",
        ),
        body: Consumer<UserProvider>(
          builder: (BuildContext context, UserProvider store, _) => Padding(
            padding: EdgeInsets.all(22),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ValueListenableBuilder<List<bool>>(
                    valueListenable: _isOpen,
                    builder: (BuildContext context, List<bool> value, _) =>
                        ExpansionPanelList(
                      elevation: 0,
                      dividerColor: Colors.transparent,
                      children: [
                        ExpansionPanel(
                          canTapOnHeader: true,
                          isExpanded: value[0],
                          headerBuilder: (context, isExpanded) {
                            return Text(
                              "Foto Wajah",
                              style: TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold),
                            );
                          },
                          body: Container(
                            height: MediaQuery.of(context).size.width - 32,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: mainColor)),
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: store.user!.photo != null
                                  ? Image.file(
                                      File(store.user!.photo!),
                                      fit: BoxFit.fill,
                                    )
                                  : Align(
                                      alignment: Alignment.center,
                                      child: Text("Tidak Ada Data !"),
                                    ),
                            ),
                          ),
                        ),
                        ExpansionPanel(
                          canTapOnHeader: true,
                          isExpanded: value[1],
                          headerBuilder: (context, isExpanded) {
                            return Text(
                              "Data Pribadi",
                              style: TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold),
                            );
                          },
                          body: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customLabel('Nama ', null, false),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    customTextField(
                                        _name, Icon(Icons.person_outline))
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customLabel('Email ', null, false),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    customTextField(
                                        _email,
                                        Icon(
                                          TablerIcons.at,
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                      expansionCallback: (panelIndex, isExpanded) {
                        final newValue = List<bool>.from(value);
                        newValue[panelIndex] = isExpanded;
                        _isOpen.value = newValue;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      RoundedButton(
                        title: "Check In",
                        isMain: true,
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Berhasil'),
                              content: Text('Check In berhasil.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BerandaScreen(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RoundedButton(
                        title: "Batal",
                        isMain: false,
                        onPressed: () {
                          showBackDialog(context: context);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextField customTextField(TextEditingController controller, Widget prefix) {
    return TextField(
      enabled: false,
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: mainColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: mainColor),
        ),
        prefixIcon: prefix,
      ),
    );
  }
}
