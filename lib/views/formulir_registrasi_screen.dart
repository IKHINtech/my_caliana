import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:my_caliana/const/colors.dart';
import 'package:my_caliana/model/user.dart';
import 'package:my_caliana/provider/user_provider.dart';
import 'package:my_caliana/views/foto_wajah_screen.dart';
import 'package:my_caliana/widgets/back_dialog.dart';
import 'package:my_caliana/widgets/custom_label.dart';
import 'package:my_caliana/widgets/custom_text_fields.dart';
import 'package:my_caliana/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class FormulirRegistrasiScreen extends StatefulWidget {
  const FormulirRegistrasiScreen({super.key});

  @override
  State<FormulirRegistrasiScreen> createState() =>
      _FormulirRegistrasiScreenState();
}

class _FormulirRegistrasiScreenState extends State<FormulirRegistrasiScreen> {
  final GlobalKey<FormState> _fkey = GlobalKey<FormState>();
  final TextEditingController _controllerKartu = TextEditingController();
  final TextEditingController _controllerAccess = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  final ValueNotifier<bool> isValid = ValueNotifier<bool>(false);

  void checkValid() {
    if (_controllerEmail.text != "" && _controllerName.text != "") {
      isValid.value = true;
    } else {
      isValid.value = false;
    }
  }

  void submit() {
    if (_fkey.currentState!.validate()) {
      try {
        _fkey.currentState!.save();
        final UserProvider provider =
            Provider.of<UserProvider>(context, listen: false);
        final User? user = provider.user;
        if (user != null) {
          final User newUser = User(
            accessNumber: _controllerAccess.text,
            idNumber: _controllerKartu.text,
            email: _controllerEmail.text,
            name: _controllerName.text,
            photoCard: user.photoCard,
          );

          provider.setUser(data: newUser);
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FacePhotoScreen(),
          ),
        );
      } catch (e) {
        if (!context.mounted) return;
        Navigator.pop(context);
        if (mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error !"),
                content: Text("$e"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _controllerAccess.dispose();
    _controllerEmail.dispose();
    _controllerKartu.dispose();
    _controllerName.dispose();
    isValid.dispose();
    super.dispose();
  }

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
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) {
            return;
          }
          showBackDialog(
            context: context,
          );
        },
        child: SingleChildScrollView(
          child: Form(
            key: _fkey,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Data Pribadi",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customLabel('Nomor Kartu Identitas ',
                          '(tidak wajib diisi)', true),
                      SizedBox(
                        height: 10,
                      ),
                      ValueListenableBuilder(
                        valueListenable: _controllerKartu,
                        builder: (context, value, child) => customTextField(
                          controller: _controllerKartu,
                          inputType: TextInputType.number,
                          required: false,
                          prefixIcon: Icon(
                            TablerIcons.id,
                          ),
                          hint: "Masukkan Nomor Kartu Identias",
                          onSaved: (val) {},
                          isBorder: true,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customLabel(
                          'Nomor Kartu Akses ', '(tidak wajib diisi)', true),
                      SizedBox(
                        height: 10,
                      ),
                      ValueListenableBuilder(
                        valueListenable: _controllerAccess,
                        builder: (context, value, child) => customTextField(
                          controller: _controllerAccess,
                          inputType: TextInputType.number,
                          prefixIcon: Icon(
                            TablerIcons.id,
                          ),
                          required: false,
                          hint: "Masukkan Nomor Kartu Akses",
                          onSaved: (val) {},
                          isBorder: true,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customLabel('Nama ', null, true),
                      SizedBox(
                        height: 10,
                      ),
                      ValueListenableBuilder(
                        valueListenable: _controllerName,
                        builder: (context, value, child) => customTextField(
                          controller: _controllerName,
                          prefixIcon: Icon(
                            Icons.person_outline,
                          ),
                          required: false,
                          hint: "Nama",
                          onSaved: (val) {},
                          isBorder: true,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customLabel('Email ', null, true),
                      SizedBox(
                        height: 10,
                      ),
                      ValueListenableBuilder(
                        valueListenable: _controllerEmail,
                        builder: (context, value, child) => customTextField(
                          inputType: TextInputType.emailAddress,
                          controller: _controllerEmail,
                          prefixIcon: Icon(
                            TablerIcons.at,
                          ),
                          required: true,
                          onChange: (p0) {
                            _fkey.currentState!.validate();
                            checkValid();
                          },
                          hint: "Email",
                          onSaved: (val) {},
                          isEmail: true,
                          isBorder: true,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ValueListenableBuilder(
                    valueListenable: isValid,
                    builder: (BuildContext context, bool valid, _) {
                      return InkWell(
                        onTap: valid ? submit : null,
                        child: Container(
                          padding: EdgeInsets.all(14),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: valid ? mainColor : Colors.grey[300]),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Selanjutnya",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: valid ? Colors.white : customGrey),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  RoundedButton(
                    title: "Batal",
                    isMain: false,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
