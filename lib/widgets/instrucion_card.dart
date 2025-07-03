import 'package:flutter/material.dart';
import 'package:pathly/utils/textstyles.dart';

class InstrucionCard extends StatelessWidget {
  const InstrucionCard({required this.instruction,required this.instrucionDistance,required this.instructionImage,super.key});
  final String instruction;
  final String instructionImage;
  final String instrucionDistance;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom:20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [Padding(
          padding: const EdgeInsets.only(bottom: 20,right: 20,left: 20),
          child: Image.asset(instructionImage,height: 25,width: 16),
        ),
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(instruction,style: Styles.styleblack16),
             SizedBox(height: 20),
              Row(children: [
            Text(instrucionDistance,style: Styles.distanceFont),
          Container(margin: EdgeInsets.symmetric(horizontal: 8),
            color: Color(0xffE1E1E1),width: MediaQuery.of(context).size.width*0.65,height: 2,)
          ],)
           ],
         ),
       
        
        
        ],
      ),
    );
  }
}