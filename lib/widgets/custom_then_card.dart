import 'package:flutter/material.dart';
import 'package:pathly/utils/textstyles.dart';

class CustomThenCard extends StatelessWidget {
  const CustomThenCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
            top: 159,
            left: 32,
            child: Container(
              height: 56,
              width: 131,
              decoration: BoxDecoration(
                color: Color(0xff019C4C),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
     Icon(Icons.turn_right, color: Colors.white,size: 34),
     SizedBox(width: 8),
     Text("Then", style: Styles.styleWhiteBold22),
                  ],
                ),
              ),
            ),
          );
  }
}