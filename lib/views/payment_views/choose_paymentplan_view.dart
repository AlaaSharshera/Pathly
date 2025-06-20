import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/cubits/botton_navbar_cubit/bottom_navbar_cubit.dart';
import 'package:pathly/cubits/get_subscription_plans_cubit/get_subscription_plans_cubit.dart';
import 'package:pathly/cubits/get_subscription_plans_cubit/get_subscription_plans_states.dart';
import 'package:pathly/cubits/stripe_payment_cubit/payment_cubit.dart';
import 'package:pathly/cubits/stripe_payment_cubit/payment_states.dart';
import 'package:pathly/models/choose_container_model.dart';
import 'package:pathly/models/payment_intent_input_model.dart';
import 'package:pathly/services/create_payment_service.dart';
import 'package:pathly/utils/paypal_helper.dart';
import 'package:pathly/views/bottom_nav_views/bottom_navbar.dart';
import 'package:pathly/widgets/payment_widgets/custom_payment_appbar.dart';
import 'package:pathly/widgets/payment_widgets/custom_plan_container.dart';
import 'package:pathly/widgets/payment_widgets/paymentdone_dialog.dart';
import 'package:pathly/widgets/payment_widgets/readytocontinue_text.dart';
import 'package:pathly/widgets/payment_widgets/rectange_button.dart';
import 'package:pathly/widgets/payment_widgets/try_again.dart';

class ChoosePaymentPlanView extends StatefulWidget {
  const ChoosePaymentPlanView({super.key});

  @override
  State<ChoosePaymentPlanView> createState() => _ChoosePaymentPlanViewState();
}

ChooseContainerModel chooseContainerModel = ChooseContainerModel();

class _ChoosePaymentPlanViewState extends State<ChoosePaymentPlanView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StripePaymentCubit>(
      create: (context) => StripePaymentCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customPaymentAppBar(title: "Choose your plan"),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              BlocBuilder<
                GetSubscriptionPlansCubit,
                GetSubscriptionPlansStates
              >(
                builder: (context, state) {
                  if (state is LoadingSubscriptionPlansState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                        padding: EdgeInsets.all(20),
                      ),
                    );
                  } else if (state is SuccessSubscriptionPlansState) {
                    return Column(
                      children: [
                        SizedBox(height: 16),
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                chooseContainerModel.planId = 1;
                                chooseContainerModel.price = "50";

                                setState(() {});
                              },
                              child: CustomPlanContainer(
                                isSelected: chooseContainerModel.planId == 1,

                                subscriptionPlansModel: state.plans[0],
                                text: "per year",
                              ),
                            ),
                            Positioned(
                              top: 2,
                              left: 16,
                              child: Image.asset(
                                'assets/images/most_popular.png',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        GestureDetector(
                          onTap: () {
                            chooseContainerModel.price = "5";
                            chooseContainerModel.planId = 2;
                            setState(() {});
                          },
                          child: CustomPlanContainer(
                            isSelected: chooseContainerModel.planId == 2,
                            subscriptionPlansModel: state.plans[1],
                            text: "per month",
                          ),
                        ),

                        SizedBox(height: 100),
                        ReadytocontinueText(),
                        RectangleButton(
                          image: 'assets/images/paypal.png',
                          text: "paypal",

                          onPressed: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return PaymentWithPaypal(
                                    planId: chooseContainerModel.planId,
                                    totalPrice: chooseContainerModel.price,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        BlocListener<StripePaymentCubit, StripePaymentStates>(
                          listener: (context, state) async {
                            if (state is PaymentSuccessState) {
                              await CreatePaymentService().createPaymentService(
                                palnId: chooseContainerModel.planId,
                                token:
                                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxNyIsImp0aSI6IjBjYWU1NzgwLWVkZDUtNGY0OS04NDI1LWUyNmM1YWE1ZjBmOSIsImVtYWlsIjoidGVzdEBleGFtcGxlLmNvbSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiMTciLCJpc0FkbWluIjoiRmFsc2UiLCJleHAiOjE3NTIxNDU0ODgsImlzcyI6IlNlY3VyZUFwaSIsImF1ZCI6IlNlY3VyZUFwaVVzZXIifQ.b4lyjBAojwpBblYCrmc7Ipxql1lq-5C0aymLz4oJkwU",
                              );
                              Get.dialog(
                                CustomDoneDialog(
                                  text: "Payment Done Successfully!",
                                  onpressed: () {
                                    Get.offAll(
                                      () => BlocProvider<BottomNavbarCubit>(
                                        create:
                                            (context) => BottomNavbarCubit(),
                                        child: BottomNavbar(),
                                      ),
                                    );
                                  },
                                ),
                                barrierColor: Colors.black.withOpacity(0.5),
                              );
                            }
                          },
                          child: RectangleButton(
                            image: 'assets/images/small_card.png',
                            text: "card",

                            onPressed: () {
                              String stripePrice =
                                  (int.parse(chooseContainerModel.price) * 100)
                                      .toString();
                              PaymentIntentInputModel paymentIntentInputModel =
                                  PaymentIntentInputModel(
                                    amount: stripePrice,
                                    currency: "usd",
                                  );
                              context.read<StripePaymentCubit>().makePayment(
                                paymentInputModel: paymentIntentInputModel,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (state is FailureSubscriptionPlansState) {
                    return Center(child: Text("SomeThing Went Wrong"));
                  } else {
                    return TryAgainText();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
