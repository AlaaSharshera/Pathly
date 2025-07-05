import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pathly/models/voice_services_model.dart';
import 'package:pathly/utils/textstyles.dart';

class VoiceServicesContainer extends StatelessWidget {
  const VoiceServicesContainer({super.key,required this.voiceServicesModel});
final VoiceServicesModel voiceServicesModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135,
      height: 30,
      margin: EdgeInsets.only(right:8 ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: voiceServicesModel.containerColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(voiceServicesModel.image),
          SizedBox(width: 5),
          Text(voiceServicesModel.serviceName, style: Styles.styleblack16),
        ],
      ),
    );
  }
}
