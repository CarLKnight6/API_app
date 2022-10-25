import 'package:flutter/material.dart';

class DropDownButtonWidget extends StatefulWidget {
  const DropDownButtonWidget(
      {super.key,
      required this.label,
      required this.value,
      required this.items,
      this.onChanged,
      this.hintText});

  final String label;
  final Object? value;
  final List<DropdownMenuItem<Object>> items;
  final void Function(Object?)? onChanged;
  final String? hintText;

  @override
  State<DropDownButtonWidget> createState() => _DropDownButtonWidgetState();
}

class _DropDownButtonWidgetState extends State<DropDownButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      DropdownButtonFormField(
        dropdownColor: Colors.transparent,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hoverColor: Colors.grey,
            focusColor: Colors.grey,
            fillColor: Colors.grey,
            hintStyle:
                const TextStyle(color: Color.fromARGB(255, 243, 237, 237)),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: widget.label,
            labelStyle:
                const TextStyle(color: Color.fromARGB(255, 239, 238, 242)),
            errorStyle: const TextStyle(
              color: Colors.red,
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 229, 236, 222)))),
        value: widget.value,
        onChanged: widget.onChanged,
        validator: (value) {
          if (value.toString().isEmpty) {
            return '${widget.label} is required';
          }
          return null;
        },
        items: widget.items,
      ),
    ]);
  }
}
