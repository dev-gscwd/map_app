import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:map_app/src/core/utils/utils_handler.dart';
import 'package:map_app/src/presentation/view/my_map.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  await Hive.initFlutter();
  const permission = Permission.location;
  if (await permission.isDenied) {
    await permission.request();
    // if (await permission.isDenied) {
    //   exit(0);
    // }
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
      .then((Position position) {
    UtilsHandler.currentPosition = position;
    // _getAddressFromLatLng(_currentPosition!);
  }).catchError((e) {
    // debugPrint(e);
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reloads.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyMap(title: 'Flutter Demo Home Page'));
  }
}
