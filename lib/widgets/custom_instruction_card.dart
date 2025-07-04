import 'package:flutter/material.dart';
import 'package:pathly/utils/textstyles.dart';

class CustomInstructionCard extends StatelessWidget {
  const CustomInstructionCard({
    required this.instruction,
    required this.instructionImage,
    super.key,
  });
final String instructionImage;
final String instruction;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 70,
      left: 32,
      right: 32,
      child: Container(
        height: 90,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xff019C4C),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4), 
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: Image.asset( instructionImage,color: Colors.white,),
            )  ,          
            SizedBox(width: 12),
            Text(instruction, style: Styles.styleWhiteBold22),
          ],
        ),
      ),
    );
  }
}