// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AuthTextFormField extends StatefulWidget {
  const AuthTextFormField(
      {Key? key,
      required this.textController,
      required this.label,
      this.isObscure = false,
      this.isConfirmPassword = false,
      this.passwordController,
      this.prefixIcon,
      this.suffixIcon})
      : super(key: key);

  final TextEditingController textController;
  final String label;
  final bool isObscure;
  final bool isConfirmPassword;
  final TextEditingController? passwordController;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
          style: TextStyle(color: Colors.white),
          obscureText: widget.isObscure,
          decoration: InputDecoration(
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
            if (widget.isConfirmPassword &&
                value != widget.passwordController?.text.toString()) {
              return 'Password does not match';
            }
            // to do email format validation
            return null;
          }),
    );
  }
}
