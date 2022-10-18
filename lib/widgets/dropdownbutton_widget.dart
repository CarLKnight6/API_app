import 'dart:ffi';

import 'package:api_app/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class DropDownButtonWidget extends StatefulWidget {
  const DropDownButtonWidget(
      {super.key,
      required this.label,
      required this.value,
      required this.items,
      this.onChanged});

  final String label;
  final Object? value;
  final List<DropdownMenuItem<Object>> items;
  final void Function(Object?)? onChanged;

  @override
  State<DropDownButtonWidget> createState() => _DropDownButtonWidgetState();
}

class _DropDownButtonWidgetState extends State<DropDownButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      TextFieldWidget(label: widget.label),
      DropdownButton(
        value: widget.value,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: widget.onChanged,
        items: widget.items,
      ),
    ]);
  }
}



//(int? newValue) {}