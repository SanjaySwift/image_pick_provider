
import 'package:flutter/material.dart';
import 'package:image_pick_provider/ImageAssets.dart';

class GlobalSearch extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged onChanged;
  final String hint;
  final GestureTapCallback clearText;
  bool? clear;
  GlobalSearch(
      {super.key,
        required this.onChanged,
        required this.controller,
        this.clear = false,
        required this.clearText,
        required this.hint});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: const ImageAssets(image: "assets/search.png", scale: 3.3),
            suffixIcon: clear!
                ? InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              onTap: clearText,
              child: const Icon(Icons.clear),
            )
                : null,
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 16),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.blue),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.green, width: 2),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
          ),
        ),
      ),
    );
  }
}
