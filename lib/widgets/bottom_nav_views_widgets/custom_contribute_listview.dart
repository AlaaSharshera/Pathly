import 'package:flutter/material.dart';
import 'package:pathly/models/custom_contribute_model.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_answercontribute_container.dart';

class CustomContributeListview extends StatelessWidget {
  const CustomContributeListview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 156,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: containersList.length,
        itemBuilder:
            (context, index) => StartAnswerContributeContainer(
              contributeModel: containersList[index],
            ),
      ),
    );
  }
}
