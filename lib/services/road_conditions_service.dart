import 'dart:developer';

import 'package:pathly/models/road_condition/road_condition.dart';
import 'package:pathly/utils/api.dart';

class RoadConditionService {
  Future<List<RoadCondition>> roadConditionService({
    required String token,
    required double startLatitude,
    required double startLongitude,
    required double endLongitude,
    required double endLatitude,
  }) async {
    var response = await Api().post(
      url: "https://pathly.runasp.net/api/RoadPrediction/predict",
      token: token,
      body: {
        "startLatitude": startLatitude,
        "startLongitude": startLongitude,
        "endLatitude": endLatitude,
        "endLongitude": endLongitude,
      },
      contentType: 'application/json',
    );
    List<dynamic> data = response;
    List<RoadCondition> roadconditionList = [];
    for (int i = 0; i < data.length; i++) {
      roadconditionList.add(RoadCondition.fromJson(data[i]));
    }
    //log(roadconditionList[0].color.toString());
    return roadconditionList;
  }
}
