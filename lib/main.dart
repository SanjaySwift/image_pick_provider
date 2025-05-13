import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_pick_provider/HomeScreen.dart';
import 'package:image_pick_provider/ImagePickerProvider.dart';
import 'package:image_pick_provider/LocationSearch/place_provider/location_provider.dart';
import 'package:image_pick_provider/place_api/place_api_provider/PlaceAPIController.dart';
import 'package:image_pick_provider/splash_screen.dart';
import 'package:provider/provider.dart';

/// Defines the main theme color.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ImagePickerProvider()),
          ChangeNotifierProvider(create: (_) => LocationProvider()),
          ChangeNotifierProvider(create: (_) => PlaceAPIController()),
        ],
        child: MaterialApp(
            builder: EasyLoading.init(),
          navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: false,
            ),
            home: const SplashScreen()));
  }
}

