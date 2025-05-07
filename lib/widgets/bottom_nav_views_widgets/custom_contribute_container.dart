import 'package:flutter/material.dart';
import 'package:pathly/utils/textstyles.dart';

class CustomContributeContainer extends StatelessWidget {
  const CustomContributeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 292,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 24),

      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff999999)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("assets/images/contribute.png"),
          Text("Keep Going!", style: Styles.styledarkgrey18bold),
          SizedBox(height: 8),
          Text(
            "There are many ways to contribute\non pathly. Try something new as\nyou go for the next level",
            style: Styles.styledarkgrey16,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Contribute now",
              style: Styles.stylePrimaryColorbold16,
            ),
          ),
        ],
      ),
    );
  }
}
