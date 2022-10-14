import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubmitButton extends StatefulWidget {
  const SubmitButton(
      {Key? key,
      required this.label,
      required this.formKey,
      this.isProcessing = true,
      required this.onPressed,
      this.visible = true})
      : super(key: key);

  final String label;
  final GlobalKey<FormState> formKey;
  final bool? isProcessing;
  final VoidCallback onPressed;
  final bool? visible;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 125, right: 75),
      child: Visibility(
        visible: widget.visible!,
        child: MaterialButton(
          color: Colors.black.withOpacity(0.05),
          onPressed: widget.onPressed,
          child: Text(
            widget.label,
            style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
