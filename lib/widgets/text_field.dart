import 'package:flutter/material.dart';

class TodoTextField extends StatelessWidget {
  const TodoTextField(
      {Key? key,
      this.decoration,
      this.controller,
      this.onChanged,
      this.obscureText})
      : super(key: key);

  final InputDecoration? decoration;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: decoration ??
          InputDecoration(
            border: OutlineInputBorder(),
          ),
    );
  }
}
