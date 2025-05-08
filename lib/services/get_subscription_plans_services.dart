import 'package:pathly/models/subscribtion_plans_model.dart';
import 'package:pathly/utils/api.dart';

class GetSubscriptionPlansServices {
  Future<List<SubscriptionPlansModel>> getSubscriptionPlansService() async {
    dynamic response = await Api().get(
      url: "https://pathly.runasp.net/api/SubscriptionPlan",
    );
    List<dynamic> data = response["plans"];

    List<SubscriptionPlansModel> plans = [];
    for (int i = 0; i < data.length; i++) {
      plans.add(SubscriptionPlansModel.fromJson(data[i]));
    }

    return plans;
  }
}
