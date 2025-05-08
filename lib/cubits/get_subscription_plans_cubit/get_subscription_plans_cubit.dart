import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathly/cubits/get_subscription_plans_cubit/get_subscription_plans_states.dart';
import 'package:pathly/models/subscribtion_plans_model.dart';
import 'package:pathly/services/get_subscription_plans_services.dart';

class GetSubscriptionPlansCubit extends Cubit<GetSubscriptionPlansStates> {
  GetSubscriptionPlansCubit() : super(LoadingSubscriptionPlansState());
  Future getPlans() async {
    try {
      List<SubscriptionPlansModel> plans =
          await GetSubscriptionPlansServices().getSubscriptionPlansService();
      emit(SuccessSubscriptionPlansState(plans));
    } catch (e) {
      emit(FailureSubscriptionPlansState(e.toString()));
    }
  }
}
