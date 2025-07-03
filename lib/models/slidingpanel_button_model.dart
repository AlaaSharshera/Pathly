import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SlidingPanelButtonModel {
  final double width;
  final Widget icon;
  final String buttonText;
  SlidingPanelButtonModel({
    required this.buttonText,
    required this.icon,
    required this.width,
  });
}

List<SlidingPanelButtonModel> buttons = [
  SlidingPanelButtonModel(
    buttonText: 'Start',
    icon: SvgPicture.asset(
      "assets/icons/start_trip.svg",
      color: Colors.white,
      height: 19,
      width: 16,
    ),
    width: 112,
  ),
  SlidingPanelButtonModel(
    buttonText: 'Add Stops',
    icon: Icon(Icons.add_location_alt, size: 22, color: Colors.white),
    width: 160,
  ),
  SlidingPanelButtonModel(
    buttonText: 'Share',
    icon: Icon(Icons.share, size: 22, color: Colors.white),
    width: 125,
  ),
  SlidingPanelButtonModel(
    buttonText: 'save',
    icon: Icon(Icons.bookmark, size: 22, color: Colors.white),
    width: 120,
  ),
];
