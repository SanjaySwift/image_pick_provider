import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_pick_provider/SelectMap/select_map_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

const appBlue = Color(0xFF008AFD);

class SelectAddressMap extends StatelessWidget {
  const SelectAddressMap({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapProvider(),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  _getMap(),
                  const Padding(
                    padding: EdgeInsets.only(top: 40.0, left: 10),
                    child: InkWell(
                      onTap: null, // Add navigation logic if needed
                      child: Icon(Icons.arrow_back_outlined),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Consumer<MapProvider>(
                      builder: (context, provider, _) => InkWell(
                        onTap: provider.gotoUserCurrentPosition,
                        child: const Icon(Icons.location_searching_sharp),
                      ),
                    ),
                  ),
                  _getCustomPin(),
                ],
              ),
            ),
            Expanded(
              flex: 0,
              child: _showDraggedAddress(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getMap() {
    return Consumer<MapProvider>(
      builder: (context, provider, _) => GoogleMap(
        initialCameraPosition: provider.cameraPosition!,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        onCameraIdle: provider.onCameraIdle,
        onCameraMove: provider.onCameraMove,
        onMapCreated: provider.onMapCreated,
      ),
    );
  }

  Widget _getCustomPin() {
    return Center(
      child: SizedBox(
        width: 130,
        child: Image.asset("assets/marker.png",
            width: 35, height: 35, color: Colors.green),
      ),
    );
  }

  Widget _showDraggedAddress() {
    return Consumer<MapProvider>(
      builder: (context, provider, _) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              provider.isLoading
                  ? Shimmer.fromColors(
                      enabled: true,
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: double.infinity,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ) ,
                      ),
                    )
                  : Row(
                      children: [
                        Icon(Icons.location_on_rounded),
                        SizedBox(width: 10),
                        Text(
                          provider.placeName,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: provider.isLoading
                        ? Shimmer.fromColors(
                            enabled: true,
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: double.infinity,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                            ),
                          )
                        : Text(
                            provider.draggedAddress,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontFamily: "Gilroy",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: provider.isLoading
                    ? Shimmer.fromColors(
                        enabled: true,
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {}, // Add navigation logic
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(appBlue),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
