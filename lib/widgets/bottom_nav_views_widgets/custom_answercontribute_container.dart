import 'package:flutter/material.dart';
import 'package:pathly/models/custom_contribute_model.dart';
import 'package:pathly/utils/textstyles.dart';

class StartAnswerContributeContainer extends StatelessWidget {
  const StartAnswerContributeContainer({
    required this.contributeModel,
    super.key,
  });
  final CustomContributeModel contributeModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 430,
      height: 156,
      padding: EdgeInsets.only(top: 20),
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xff999999)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(contributeModel.text, style: Styles.styledarkgrey18bold),
              TextButton(
                onPressed: () {},
                child: Text(
                  contributeModel.buttonText!,
                  style: Styles.stylePrimaryColorbold18,
                ),
              ),
            ],
          ),
          Image.asset(contributeModel.image, height: 141),
        ],
      ),
    );
  }
}
