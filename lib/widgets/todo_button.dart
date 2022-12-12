import 'package:flutter/material.dart';
import 'package:todo_app/theme/themes.dart';

class TodoButton extends StatelessWidget {
  const TodoButton(
      {Key? key, this.enabled, this.onTap, this.color, required this.text})
      : super(key: key);
  final VoidCallback? onTap;
  final bool? enabled;
  final Color? color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: color ?? primaryColor),
              borderRadius: BorderRadius.circular(14)),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(text)))),
    );
  }
}
