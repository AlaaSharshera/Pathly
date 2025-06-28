import 'package:flutter/material.dart';

class SlidingPanelButtonModel{
  final VoidCallback? onPressed;
final double width;
final Widget icon;
final String buttonText;
SlidingPanelButtonModel({required this.buttonText,required this.icon, this.onPressed,required this.width});
}