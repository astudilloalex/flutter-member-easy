import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    this.autovalidateMode,
    this.controller,
    this.decoration = const InputDecoration(),
    this.readOnly = false,
    this.enabled = true,
    this.validator,
  });

  final AutovalidateMode? autovalidateMode;
  final TextEditingController? controller;
  final InputDecoration decoration;
  final bool readOnly;
  final bool enabled;
  final FormFieldValidator<String?>? validator;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool visiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: widget.autovalidateMode,
      controller: widget.controller,
      decoration: widget.decoration.copyWith(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() => visiblePassword = !visiblePassword);
          },
          icon: Icon(
            visiblePassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        ),
      ),
      enabled: widget.enabled,
      keyboardType: TextInputType.visiblePassword,
      obscureText: !visiblePassword,
      readOnly: widget.readOnly,
      validator: widget.validator,
    );
  }
}
