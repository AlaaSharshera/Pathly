import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathly/cubits/get_subscription_plans_cubit/get_subscription_plans_cubit.dart';

class TryAgainText extends StatelessWidget {
  const TryAgainText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          context.read<GetSubscriptionPlansCubit>().getPlans();
        },
        child: Text(
          "Try again",
          style: TextStyle(color: kDefaultIconLightColor),
        ),
      ),
    );
  }
}
