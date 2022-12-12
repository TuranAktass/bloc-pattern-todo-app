import 'package:flutter/material.dart';

extension EmptySpace on int {
  Widget get hSizedBox => SizedBox(height: this.toDouble());
  Widget get wSizedBox => SizedBox(width: this.toDouble());
}
