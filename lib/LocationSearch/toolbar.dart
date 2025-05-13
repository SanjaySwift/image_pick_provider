import 'package:flutter/material.dart';
import 'package:image_pick_provider/LocationSearch/place_provider/location_provider.dart';
import 'package:image_pick_provider/LocationSearch/search_location_page.dart';

import 'package:provider/provider.dart';

class HomePageToolbar extends StatelessWidget {
  const HomePageToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    return Row(
      children: [
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            splashColor: Colors.green,
            onTap: (){
              Navigator.push(
                context, _createCustomTransition(SearchLocationPage()),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on_rounded),
                    SizedBox(width: 5),
                    Text(locationProvider.isLoading?"...":locationProvider.placeName.toString(),
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Text(locationProvider.isLoading?"...":locationProvider.currentAddress.toString(),
                      style: TextStyle(
                          fontSize: 14,
                        overflow: TextOverflow.ellipsis
                      )),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ),
        Image.asset("assets/logo.png",scale: 55)
      ],
    );
  }
  // Custom transition for the navigation
  PageRouteBuilder _createCustomTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Define the up-slide transition
        var begin = Offset(0.0, 1.0); // Start below the screen
        var end = Offset.zero; // End at the normal position
        var curve = Curves.easeInOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        // Use SlideTransition for the "up" effect
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
