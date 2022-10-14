import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class AuthTextFormField extends StatefulWidget {
  const AuthTextFormField(
      {Key? key,
      required this.textController,
      required this.label,
      this.isObscure = false,
      this.isConfirmPassword = false,
      this.isEmail = false,
      this.passwordController,
      this.emailController,
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
  final TextEditingController? emailController;
  final bool isEmail;

  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
          style: const TextStyle(color: Colors.white),
          obscureText: widget.isObscure,
          decoration: InputDecoration(
              labelText: widget.label,
              labelStyle:
                  const TextStyle(color: Color.fromARGB(255, 239, 238, 242)),
              errorStyle: const TextStyle(
                color: Colors.red,
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              focusedBorder: const OutlineInputBorder(
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

            if (widget.isEmail &&
                value != widget.emailController &&
                EmailValidator.validate(value) == false) {
              return 'Invalid Email';
            }

            return null;
          }),
    );
  }
}
