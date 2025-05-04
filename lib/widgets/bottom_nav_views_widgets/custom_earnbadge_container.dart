import 'package:flutter/material.dart';
import 'package:pathly/utils/textstyles.dart';

class CustomEarnbadgeContainer extends StatelessWidget {
  const CustomEarnbadgeContainer({super.key});

  final List<String> tasksText = const [
    "Post 2 photos",
    "Write 2 reviews",
    "Answer 2 Questions",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 342,
      width: double.infinity,
      margin: EdgeInsets.only(top: 24, bottom: 24),

      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xff999999)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Earn Your New\nContributor badge",
                  style: Styles.styledarkgrey18bold,
                ),
                Image.asset("images/lock.png"),
              ],
            ),
          ),

          Column(
            children: List.generate(
              tasksText.length,
              (index) => TaskContainer(text: tasksText[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class TaskContainer extends StatelessWidget {
  const TaskContainer({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: double.infinity,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xff999999)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: Styles.styledarkgrey18),
          Text("0/2", style: Styles.styledarkgrey18),
        ],
      ),
    );
  }
}
