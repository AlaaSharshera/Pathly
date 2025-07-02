import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pathly/utils/textstyles.dart';

class CustomLocationCard extends StatelessWidget {
  const CustomLocationCard({required this.distinationName, super.key});
  final String distinationName;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(32),
      padding: EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xff999999), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/icons/origin_to_distination.png'),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Your location", style: Styles.stylePrimaryColorbold16),
                Divider(color: Color(0xff999999), thickness: 1, height: 10),
                Text(
                  distinationName,
                  style: Styles.styledarkgrey16,
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SvgPicture.asset('assets/icons/arrow_back.svg', height: 35),
        ],
      ),
    );
  }
}
