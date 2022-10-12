// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  Button({
    required this.label,
    this.formKey,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;
  final GlobalKey<FormState>? formKey;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(left: 125, right: 75),
        child: MaterialButton(
          color: Colors.black.withOpacity(0.05),
          onPressed: onPressed,
          child: Text(
            label,
            style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ]);
  }
}
