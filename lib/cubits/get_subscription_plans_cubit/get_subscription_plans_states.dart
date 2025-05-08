import 'package:pathly/models/subscribtion_plans_model.dart';

class GetSubscriptionPlansStates {}

class LoadingSubscriptionPlansState extends GetSubscriptionPlansStates {}

class SuccessSubscriptionPlansState extends GetSubscriptionPlansStates {
  final List<SubscriptionPlansModel> plans;

  SuccessSubscriptionPlansState(this.plans);
}

class FailureSubscriptionPlansState extends GetSubscriptionPlansStates {
  final String errMessage;

  FailureSubscriptionPlansState(this.errMessage);
}
