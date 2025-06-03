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
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            splashColor: Colors.green,
            onTap: () {
              Navigator.push(
                context,
                _createCustomTransition(const SearchLocationPage()),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        locationProvider.isLoading ? "..." : locationProvider.placeName.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  locationProvider.isLoading ? "..." : locationProvider.currentAddress.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 40),
        SizedBox(
          width: 40, // Adjust the width to fit your logo size
          height: 40, // Adjust the height to fit your logo size
          child: Image.asset(
            "assets/logo.png",
            fit: BoxFit.contain, // Ensure the image fits within the SizedBox
          ),
        ),
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
        var begin = const Offset(0.0, 1.0); // Start below the screen
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