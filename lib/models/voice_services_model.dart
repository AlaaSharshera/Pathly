import 'package:flutter/material.dart';

class VoiceServicesModel {
  final Color containerColor;
  final String serviceName;
  final String image;
  VoiceServicesModel({required this.containerColor,required this.image,required this.serviceName});
}
List<VoiceServicesModel> voiceServices=[
  VoiceServicesModel(containerColor: Color(0xffF3AD61), image: "assets/icons/hotel.svg", serviceName: "Hotel"),
  VoiceServicesModel(containerColor: Color(0xff81A6B5), image: "assets/icons/hospital.svg", serviceName: "Hospital"),
  VoiceServicesModel(containerColor: Color(0xffF3AD61), image: "assets/icons/gas-station.svg", serviceName: "Gas"),
  VoiceServicesModel(containerColor: Color(0xffFDC8DD), image: "assets/icons/shopping.svg", serviceName: "Shopping"),
  VoiceServicesModel(containerColor: Color(0xffF3AD61), image: "assets/icons/caffee.svg", serviceName: "Cafe"),
  VoiceServicesModel(containerColor: Color(0xffCBDCFF), image: "assets/icons/pharmacy.svg", serviceName: "Pharmacy"),
  VoiceServicesModel(containerColor: Color(0xffFFF5CB), image: "assets/icons/restaurant.svg", serviceName: "Restaurants")
];