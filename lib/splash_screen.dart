
import 'package:flutter/material.dart';
import 'package:image_pick_provider/HomeScreen.dart';
import 'package:image_pick_provider/LocationSearch/place_provider/location_provider.dart';
import 'package:image_pick_provider/SelectMap/select_map_provider.dart';
import 'package:image_pick_provider/select_address_map.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    locationPermission();
    //locationPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    if (state == AppLifecycleState.resumed) {
     // locationPermission();
      print("resumed");
    } else if (state == AppLifecycleState.paused) {
     // locationPermission();
      print("paused");
    } else if (state == AppLifecycleState.inactive) {
     // locationPermission();
      print("inactive");
    } else if (state == AppLifecycleState.detached) {
      //locationPermission();
      print("detached");
    } else if (state == AppLifecycleState.hidden) {
     //locationPermission();
      print("hidden");
    }
  }

  Future<void> locationPermission() async {
    WidgetsBinding.instance.addPostFrameCallback((_)async {
     final locationProvider = Provider.of<LocationProvider>(context, listen: false);
     await locationProvider.getCurrentLocation(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("dvjiejvijeivjiejvijeve")
            // Text(locationProvider.currentAddress.toString()),
            // Text(locationProvider.getCurrentPosition!.latitude.toString()),
            // Text(locationProvider.getCurrentPosition!.longitude.toString()),
            // ElevatedButton(
            //   onPressed: () async {
            //     if (locationProvider.errorMessage != null) {
            //       await locationProvider.getCurrentLocation();
            //     } else {
            //       await locationProvider.updatePosition(
            //         lat: 18.98244984018237,
            //         lng: 73.02644455756709,
            //       );
            //     }
            //   },
            //   child: Text(locationProvider.errorMessage != null ? 'Retry' : 'Update Lat Lng'),
            // )
          ],
        ),
      ),
    );
  }

}
