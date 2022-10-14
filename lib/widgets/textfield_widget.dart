import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 125, right: 75),
      child: Text(
        widget.label,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
      ),
    );
  }
}
