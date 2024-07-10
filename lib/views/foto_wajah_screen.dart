import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_caliana/const/colors.dart';
import 'package:my_caliana/main.dart';
import 'package:my_caliana/model/user.dart';
import 'package:my_caliana/provider/user_provider.dart';
import 'package:my_caliana/views/formulir_registrasi_screen.dart';
import 'package:my_caliana/views/konfirmasi_data_screen.dart';
import 'package:my_caliana/widgets/back_dialog.dart';
import 'package:my_caliana/widgets/rounded_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class FacePhotoScreen extends StatefulWidget {
  const FacePhotoScreen({super.key});

  @override
  State<FacePhotoScreen> createState() => _FacePhotoScreenState();
}

class _FacePhotoScreenState extends State<FacePhotoScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  ValueNotifier<bool> loadingTake = ValueNotifier<bool>(false);
  ValueNotifier<XFile?> file = ValueNotifier<XFile?>(null);

  Future<void> _checkPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.status;

    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
  }

  void _initFrontCamera() {
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      cameras.first,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );
    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  Future<void> switchCamera() async {
    if (_controller.description.lensDirection == CameraLensDirection.front) {
      return await _controller.setDescription(cameras.first);
    } else {
      return await _controller.setDescription(cameras.last);
    }
  }

  Future<void> takePhoto({required BuildContext context}) async {
    try {
      loadingTake.value = true;
      await _initializeControllerFuture;
      if (!kIsWeb) {
        await _controller.setFocusMode(FocusMode.locked);
        await _controller.setExposureMode(ExposureMode.locked);
      }
      file.value = await _controller.takePicture();
      if (!context.mounted) return;

      if (!context.mounted) return;

      loadingTake.value = false;
    } catch (e) {
      loadingTake.value = false;
      if (!context.mounted) return;
      Navigator.pop(context, 'error');
      log('$e');
    }
  }

  void navigateAndSetData() {
    // define provider
    final UserProvider provider =
        Provider.of<UserProvider>(context, listen: false);

    // get data from provider
    final User? user = provider.user;

    if (user != null && file.value != null) {
      // set new data
      final User newUser = User(
          accessNumber: user.accessNumber,
          email: user.email,
          idNumber: user.idNumber,
          name: user.name,
          photo: file.value!.path,
          photoCard: user.photoCard);
      provider.setUser(data: newUser);
    }
    // navigate to next screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => KonfirmasiDataScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    _initFrontCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    loadingTake.dispose();
    file.dispose();
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
        title: ValueListenableBuilder<XFile?>(
          valueListenable: file,
          builder: (BuildContext context, XFile? value, _) => Text(
            value == null ? "Ambil Foto Wajah" : "Periksa Kualitas Foto",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.center,
                        child: ValueListenableBuilder<XFile?>(
                          valueListenable: file,
                          builder: (BuildContext context, XFile? value, _) =>
                              Text(
                            value == null
                                ? "Tolong posisikan wajah Anda di tengah area selfie dan lalu ambil foto."
                                : "Pastikan foto wajah Anda tidak buram atau di luar bingkai sebelum melanjutkan",
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width - 32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: mainColor)),
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ValueListenableBuilder<XFile?>(
                          valueListenable: file,
                          builder: (BuildContext context, XFile? value, _) {
                            if (value != null) {
                              return Image.file(
                                File(value.path),
                                fit: BoxFit.fill,
                              );
                            } else {
                              return CameraPreview(_controller);
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Align(
                          child: ValueListenableBuilder(
                            valueListenable: loadingTake,
                            builder: (BuildContext context, bool value, _) =>
                                InkWell(
                              onTap: () async {
                                await takePhoto(context: context);
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: value
                                    ? CircularProgressIndicator()
                                    : ValueListenableBuilder(
                                        valueListenable: file,
                                        builder: (context, value, child) {
                                          if (value == null) {
                                            return Column(
                                              children: const [
                                                Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: mainColor,
                                                ),
                                                Text(
                                                  "Ambil Foto",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    color: mainColor,
                                                  ),
                                                )
                                              ],
                                            );
                                          } else {
                                            return Column(
                                              children: [
                                                RoundedButton(
                                                  title: "Sesuai dan lanjutkan",
                                                  isMain: true,
                                                  onPressed: navigateAndSetData,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                RoundedButton(
                                                  title: "Ulangi Ambil Foto",
                                                  isMain: false,
                                                  onPressed: () {
                                                    file.value = null;
                                                  },
                                                )
                                              ],
                                            );
                                          }
                                        },
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                // Otherwise, display a loading indicator.
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
