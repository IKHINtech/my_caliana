import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_caliana/model/user.dart';
import 'package:my_caliana/provider/user_provider.dart';
import 'package:my_caliana/views/formulir_registrasi_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class PindaiScreen extends StatefulWidget {
  final String title;
  final List<CameraDescription> cameras;

  const PindaiScreen({super.key, required this.title, required this.cameras});

  @override
  State<PindaiScreen> createState() => _PindaiScreenState();
}

class _PindaiScreenState extends State<PindaiScreen> {
  final User user = User();
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  ValueNotifier<bool> loadingTake = ValueNotifier<bool>(false);

  Future<void> _checkPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.status;

    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
  }

  void _initFrontCamera() {
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.cameras.first,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );
    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  Future<void> switchCamera() async {
    if (_controller.description.lensDirection == CameraLensDirection.front) {
      return await _controller.setDescription(widget.cameras.first);
    } else {
      return await _controller.setDescription(widget.cameras.last);
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
      final image = await _controller.takePicture();
      user.photoCard = image.path;
      if (!context.mounted) return;
      UserProvider userProv = Provider.of<UserProvider>(context, listen: false);
      userProv.setUser(data: user);
      if (!context.mounted) return;
      if (kIsWeb) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormulirRegistrasiScreen(),
            ));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormulirRegistrasiScreen(),
            ));
      }
      // } else {
      //   if (!context.mounted) return;
      //   Navigator.pop(context, "error");
      // }
      loadingTake.value = false;
    } catch (e) {
      loadingTake.value = false;
      if (!context.mounted) return;
      Navigator.pop(context, 'error');
      log('$e');
    }
  }

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    _initFrontCamera();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
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
          "Pindai ${widget.title}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
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
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Tempatkan ${widget.title} Anda di dalam kotak.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CameraPreview(_controller),
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
                                  : Column(
                                      children: const [
                                        Icon(
                                          Icons.camera_alt_outlined,
                                        ),
                                        Text(
                                          "Ambil Foto",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )
                                      ],
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
    );
  }
}
