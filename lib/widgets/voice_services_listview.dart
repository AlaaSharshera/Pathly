import 'package:flutter/material.dart';
import 'package:pathly/models/voice_services_model.dart';
import 'package:pathly/widgets/voice_services_container.dart';

class VoiceServicesListview extends StatelessWidget {
  const VoiceServicesListview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: voiceServices.length,
        itemBuilder:
            (context, index) => VoiceServicesContainer(
              voiceServicesModel: voiceServices[index],
            ),
      ),
    );
  }
}
