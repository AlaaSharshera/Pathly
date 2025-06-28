import 'package:flutter/material.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/models/slidingpanel_button_model.dart';
import 'package:pathly/utils/textstyles.dart';

class SlidingPanelButton extends StatelessWidget {
  const SlidingPanelButton({required this.slidingPanelButtonModel,super.key});
final SlidingPanelButtonModel slidingPanelButtonModel;
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
                             style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                              disabledBackgroundColor: Color(0xff81A6B5),
                              fixedSize: Size(slidingPanelButtonModel.width, 48)
                              ),
    
                  onPressed: slidingPanelButtonModel.onPressed, child: Row(
                              children: [
                                  Padding(
                         padding: const EdgeInsets.only(right: 6.0),
                                    child: slidingPanelButtonModel.icon
                                  ),
                                Text(slidingPanelButtonModel.buttonText,style:Styles.styleWhite16),
                              ],
                            ));
  }
}