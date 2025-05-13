

import 'package:flutter/material.dart';

mCornerBottomSheet({
  required BuildContext aContext,
required galleryClick,
  required cameraClick,
  required closeClick
}) {
  showModalBottomSheet(
    context: aContext,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
    builder: (builder) {
      return Container(
        height: 250.0,
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Choose Photo",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700)),
                InkWell(
                  splashColor: Colors.grey,
                  onTap: closeClick,
                    child: Icon(Icons.close))
              ],
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: galleryClick,
              splashColor: Colors.green.shade100,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.grey.shade100
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Image.asset("assets/gallery.png",scale: 15),
                      SizedBox(width: 10),
                      Text("Gallery",style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: cameraClick,
              splashColor: Colors.green.shade100,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.grey.shade100
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Image.asset("assets/gallery.png",scale: 15),
                      SizedBox(width: 10),
                      Text("Camera",style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}