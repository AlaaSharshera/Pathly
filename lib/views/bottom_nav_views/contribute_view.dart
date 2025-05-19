import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathly/models/custom_contribute_model.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_contribute_container.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_contribute_listview.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_contribute_search_textfield.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_contribute_service_coulmn.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_earnbadge_container.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/make_report_view.dart';

class ContributeView extends StatelessWidget {
  const ContributeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomContributeSearchTextField(color: Color(0xffE2EBF2)),
                    Image.asset("assets/images/profile.png", width: 38),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  contributesList.length,
                  (index) => CustomContributeServiceCoulmn(
                    onTap: index==3?(){
                      Get.to(()=>MakeReportView());
                    }:(){},
                    contributeModel: contributesList[index],
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomEarnbadgeContainer(),
                      CustomContributeListview(),
                      CustomContributeContainer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
