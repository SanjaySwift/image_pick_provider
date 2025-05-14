import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_pick_provider/LocationSearch/GloableSearch.dart';
import 'package:image_pick_provider/LocationSearch/location_items.dart';
import 'package:image_pick_provider/LocationSearch/place_provider/location_provider.dart';
import 'package:image_pick_provider/place_api/place_api_provider/PlaceAPIController.dart';
import 'package:provider/provider.dart';

const backgroundColor = Color(0xFFDFF1EB);

class SearchLocationPage extends StatefulWidget {
  const SearchLocationPage({super.key});

  @override
  State<SearchLocationPage> createState() => _SearchLocationPageState();
}

class _SearchLocationPageState extends State<SearchLocationPage> {

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final placeAPI = Provider.of<PlaceAPIController>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(Icons.keyboard_arrow_down,
                      size: 30, color: Colors.black),
                  SizedBox(width: 10),
                  Text("Select a location",
                      style: TextStyle(color: Colors.black))
                ],
              ),
            )),
        body: Column(
          children: [
            GlobalSearch(
              onChanged: (value) {
                setState(()async {
                  if (value.toString().length > 2) {
                    await placeAPI.autoSearchPlaceAPI(searchAddress: value);
                  }else{
                    await  placeAPI.autoSearchPlaceAPI(searchAddress: "");
                  }
                });
              },
              controller: searchController,
              clear: searchController.text.isNotEmpty ? true : false,
              clearText: ()async {
               await placeAPI.autoSearchPlaceAPI(searchAddress: "");
                searchController.clear();

              },
              hint: "Search for diagnostics here...",
            ),
            InkWell(
              onTap: () async {
                locationProvider.isPermissionDenied ? await Geolocator.openAppSettings():await locationProvider.getCurrentLocation();
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Icon(Icons.my_location, color: Colors.green),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Use your current location",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            locationProvider.isLoading
                ? Center(child: LinearProgressIndicator(color: Colors.green, minHeight: 2))
                : SizedBox(height: 20),
            Expanded(
              child: placeAPI.predictions.isEmpty ? Text("No data found")
                  : placeAPI.isLoadingAutoSearchPlace?Center(child: CircularProgressIndicator(color: CupertinoColors.systemGreen,)):
              ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      itemBuilder: (context, index) {
                        return LocationItems(
                            click: () async {
                              locationProvider.updatePlaceName(placeName: placeAPI.predictions![index].structuredFormatting!.mainText.toString());
                              locationProvider.updateCurrentAddress(currentAddress: placeAPI.predictions![index].structuredFormatting!.secondaryText.toString());
                              placeAPi(placeAPI.predictions![index].placeId.toString());
                            }, predictions: placeAPI.predictions![index]);
                      },
                      itemCount: placeAPI.predictions!.length,
                    ),
            ),
          ],
        ));
  }

  void placeAPi(String placeID) async {
    final placeAPI = Provider.of<PlaceAPIController>(context, listen: false);
    final locationAPI = Provider.of<LocationProvider>(context, listen: false);
    await placeAPI.placeAPI(placeId: placeID).then((value) async {
      double lat = double.parse(value!.result!.geometry!.location!.lat.toString());
      double lng = double.parse(value.result!.geometry!.location!.lng.toString());
      if (locationAPI.errorMessage != null) {
        await locationAPI.getCurrentLocation();
      } else {
        await locationAPI.updatePosition(lat: lat, lng: lng);
        if(mounted) {
          Navigator.pop(context);
        }
      }
    });
  }

}
