abstract class StripePaymentStates {}

class PaymentLoadingState extends StripePaymentStates {}

class PaymentSuccessState extends StripePaymentStates {}

class PaymentFailureState extends StripePaymentStates {
  final String errMessage;
  PaymentFailureState(this.errMessage);
}
