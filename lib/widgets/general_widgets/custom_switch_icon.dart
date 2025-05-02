import 'package:flutter/material.dart';

class CustomSwitchIcon extends StatefulWidget {
  const CustomSwitchIcon({super.key});

  @override
  State<CustomSwitchIcon> createState() => _CustomSwitchIconState();
}

class _CustomSwitchIconState extends State<CustomSwitchIcon> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isActive = !isActive;
        setState(() {});
      },
      child: Stack(
        children: [
          Container(
            width: 35,
            height: 17,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(42),
              color: Color(0xffE9EAEC),
            ),
          ),
          Positioned(
            right: isActive ? 0 : null,
            left: isActive ? null : 0,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: 21,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(42),
                color: isActive ? Colors.green : Color(0xff9A9999),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
