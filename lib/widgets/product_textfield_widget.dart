// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ProductTextFormField extends StatefulWidget {
  const ProductTextFormField(
      {Key? key,
      required this.textController,
      required this.label,
      this.isObscure = false,
      this.isConfirmPassword = false,
      this.passwordController,
      this.prefixIcon,
      this.suffixIcon,
      this.hintText,
      this.enabled,
      required this.readOnly,
      this.hintStyle})
      : super(key: key);

  final TextEditingController textController;
  final String label;
  final bool isObscure;
  final bool isConfirmPassword;
  final TextEditingController? passwordController;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final TextStyle? hintStyle;
  final bool? enabled;
  final bool readOnly;

  @override
  State<ProductTextFormField> createState() => _ProductTextFormFieldState();
}

class _ProductTextFormFieldState extends State<ProductTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
          style: TextStyle(color: Colors.white),
          obscureText: widget.isObscure,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.grey),
              hintText: widget.hintText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: widget.label,
              labelStyle: TextStyle(color: Color.fromARGB(255, 239, 238, 242)),
              errorStyle: TextStyle(
                color: Colors.red,
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 229, 236, 222)))),
          controller: widget.textController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '${widget.label} is required';
            }

            return null;
          }),
    );
  }
}
