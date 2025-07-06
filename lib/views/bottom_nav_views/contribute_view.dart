import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathly/models/custom_contribute_model.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_contribute_container.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_contribute_listview.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_contribute_search_textfield.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_contribute_service_coulmn.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_earnbadge_container.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/make_report_view.dart';
import 'package:pathly/widgets/dialog_card.dart';
import 'package:pathly/widgets/voice_bottomsheet_body.dart';
import 'package:pathly/widgets/voicewaves_bottom_sheet.dart';

class ContributeView extends StatefulWidget {
  const ContributeView({super.key});

  @override
  State<ContributeView> createState() => _ContributeViewState();
}

class _ContributeViewState extends State<ContributeView> {
  @override
  void initState() {
    super.initState();
  }

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
                    CustomContributeSearchTextField(
                      color: Color(0xffE2EBF2),
                      voiceOnTap: () {
                                   showModalBottomSheet(
                                  isScrollControlled: true,
                                  isDismissible: false,
                                  context: context,
                                  shape: Border(
                                    top: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.white,
                                    ),
                                  ),
                                  builder:
                                      (context) => VoiceBottomsheetBody(
                                        tryOnPressed: () {
                                          Navigator.pop(context);
                                           showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    context: context,
    isScrollControlled: true,
    builder: (_) => VoiceWavesBottomsheetBody(
      onResult: (recognizedText) {
        setState(() {
        //  controller.text = recognizedText;
        });
      },
    ),
  );
                                        },
                                      ),
                                );
                      },
                     
                      onTap: () {
                         
                        
                      },
                    ),
                    GestureDetector( onTap: () {
                          showDialog(
                            barrierColor: Colors.black.withOpacity(0.7),
                            context: context,
                            builder:
                                (context) => Center(child: AccountDialogCard()),
                          );
                        },
                      child: Image.asset("assets/images/profile.png", width: 38)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  contributesList.length,
                  (index) => CustomContributeServiceCoulmn(
                    onTap:
                        index == 3
                            ? () {
                              Get.to(() => MakeReportView());
                            }
                            : () {},
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
