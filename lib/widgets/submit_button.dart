// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.label,
    required this.formKey,
    required this.isProcessing,
    required this.validated,
  }) : super(key: key);

  final String label;
  final GlobalKey<FormState> formKey;
  final bool isProcessing;
  final Function() validated;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 125, right: 75),
      child: MaterialButton(
        color: Colors.black.withOpacity(0.05),
        onPressed: isProcessing ? null : validated,
        child: Text(
          label,
          style: GoogleFonts.openSans(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
