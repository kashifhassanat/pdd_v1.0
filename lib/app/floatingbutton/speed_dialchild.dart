import 'package:flutter/material.dart';

class SpeedDialChild {
  final String label;

  final TextStyle labelStyle;

  final Color labelBackgroundColor;

  final Widget labelWidget;

  final Widget child;
  final Color backgroundColor;
  final Color foregroundColor;
  final double elevation;
  final VoidCallback onTap;
  final ShapeBorder shape;

  SpeedDialChild({
    this.label,
    this.labelStyle,
    this.labelBackgroundColor,
    this.labelWidget,
    this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.onTap,
    this.shape,
  });
}
