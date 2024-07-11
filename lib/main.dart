import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_caliana/provider/user_provider.dart';
import 'package:my_caliana/views/beranda_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

List<CameraDescription> cameras = [];
void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } catch (e) {
    if (e is CameraException) {
      log('Error in fetching the cameras: $e');
    }
    log('$e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale("id")],
        debugShowCheckedModeBanner: false,
        title: 'My Caliana',
        routes: {
          '/beranda': (context) => BerandaScreen(),
        },
        theme: ThemeData(
          fontFamily: GoogleFonts.inter().fontFamily,
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0x00B3E9FF)),
          useMaterial3: true,
        ),
        home: const BerandaScreen(),
      ),
    );
  }
}
