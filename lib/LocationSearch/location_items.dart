import 'package:flutter/material.dart';
import 'package:image_pick_provider/place_api/query_autocomplete_model.dart';

const backgroundColor = Color(0xFFDFF1EB);

class LocationItems extends StatelessWidget {

  final Predictions predictions;
  final VoidCallback click;
  const LocationItems({super.key, required this.click, required this.predictions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: InkWell(
          onTap: click,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Icon(Icons.location_on_rounded),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(predictions.structuredFormatting!.mainText.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                      SizedBox(height: 5),
                      Text(predictions.structuredFormatting!.secondaryText.toString(),style: TextStyle(fontSize: 14)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
