import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathly/cubits/stripe_payment_cubit/payment_states.dart';
import 'package:pathly/models/payment_intent_input_model.dart';
import 'package:pathly/services/stripe_service.dart';

class StripePaymentCubit extends Cubit<StripePaymentStates> {
  StripePaymentCubit() : super(PaymentLoadingState());

  Future makePayment({
    required PaymentIntentInputModel paymentInputModel,
  }) async {
    try {
      await StripeService().makePayment(paymentInputModel: paymentInputModel);
      emit(PaymentSuccessState());
    } catch (e) {
      emit(PaymentFailureState(e.toString()));
    }
  }
}
