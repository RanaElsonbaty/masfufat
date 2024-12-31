import 'package:flutter/material.dart';

void showCustomSnackBar(String? message, BuildContext context, {bool isError = true, bool isToaster = false, int time = 1, VoidCallback? onTap}) {
  final snackBar = SnackBar(
    content: InkWell(
      splashColor: Colors.transparent, // Remove splash color
      highlightColor: Colors.transparent, // Remove highlight color
      onTap: () {
        // Trigger the onTap callback when the snackbar is tapped
        if (onTap != null) {
          onTap();
        }
      },
      child: Material(
        color: Colors.transparent, // Make the material background transparent
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
          decoration: BoxDecoration(
            color: isError ? const Color(0xFFFF0014) : const Color(0xFF1E7C15), // Snackbar background color
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            message!,
            style: const TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,// Make background transparent for the custom widget
    duration: Duration(seconds: time),
  );

  // Show the custom snackBar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
