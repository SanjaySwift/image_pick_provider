import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_pick_provider/ImagePickerProvider.dart';
import 'package:image_pick_provider/LocationSearch/place_provider/location_provider.dart';
import 'package:image_pick_provider/LocationSearch/toolbar.dart';
import 'package:image_pick_provider/upload_image/image_pick_bottomsheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
      await locationProvider.getCurrentLocation();
      print("resumed");
    } else if (state == AppLifecycleState.paused) {
      print("paused");
    } else if (state == AppLifecycleState.inactive) {
      print("inactive");
    } else if (state == AppLifecycleState.detached) {
      print("detached");
    } else if (state == AppLifecycleState.hidden) {
      print("hidden");
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    return  Scaffold(
            body: locationProvider.isPermissionDenied
                ? Center(child: InkWell(
              onTap: ()async{
                await Geolocator.openAppSettings();
              }, child: Text("Enable location from setting")))
                : locationProvider.isLoading?CircularProgressIndicator():
            Consumer<ImagePickerProvider>(
                    builder: (context, provider, _) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30),
                            HomePageToolbar(),
                            const SizedBox(height: 50),
                            _buildImageDisplay(provider),
                            const SizedBox(height: 20),
                            _buildErrorMessage(provider),
                            const SizedBox(height: 20),
                            _buildButtons(context, provider),
                          ],
                        ),
                      );
                    },
                  ),
          );
  }

  Widget _buildImageDisplay(ImagePickerProvider provider) {
    final locationProvider = Provider.of<LocationProvider>(context);
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.image != null
              ? Image.file(
                  provider.image!,
                  fit: BoxFit.cover,
                )
              : Column(
                children: [
                 // Center(child: Text(locationProvider.getCurrentPosition!.latitude.toString())),
                  Text(locationProvider.currentAddress.toString()),
                  Text(locationProvider.getCurrentPosition!.latitude.toString()),
                  Text(locationProvider.getCurrentPosition!.longitude.toString()),
                ],
              ),
    );
  }

  Widget _buildErrorMessage(ImagePickerProvider provider) {
    return provider.error != null
        ? Text(
            provider.error!,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ) : const SizedBox.shrink();
  }

  Widget _buildButtons(BuildContext context, ImagePickerProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: provider.isLoading
              ? null
              : () => provider.pickImage(ImageSource.camera, context: context),
          icon: const Icon(Icons.camera_alt),
          label: const Text('Camera'),
        ),
        ElevatedButton.icon(
          onPressed: provider.isLoading
              ? null
              : () => provider.pickImage(ImageSource.gallery),
          icon: const Icon(Icons.photo_library),
          label: const Text('Gallery'),
        ),
        //if (provider.image != null)
        ElevatedButton.icon(
          onPressed: () {
            mCornerBottomSheet(
                aContext: context,
                galleryClick: () =>
                    provider.pickImage(ImageSource.gallery, context: context),
                cameraClick: () =>
                    provider.pickImage(ImageSource.camera, context: context),
                closeClick: null);
          },
          //provider.clearImage,
          icon: const Icon(Icons.delete),
          label: const Text('Clear'),
        ),
      ],
    );
  }
}
