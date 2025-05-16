import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pathly/utils/textstyles.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_addphoto_container.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_dropdown_button.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_report_textfield.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_reportlocation_row.dart';
import 'package:pathly/widgets/payment_widgets/custom_payment_appbar.dart';
import 'package:pathly/widgets/payment_widgets/custom_payment_button.dart';

class MakeReportView extends StatefulWidget {
  const MakeReportView({super.key});

  @override
  State<MakeReportView> createState() => _MakeReportViewState();
}

class _MakeReportViewState extends State<MakeReportView> {
  String? selectedValue;

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customPaymentAppBar(title: "Report an issue"),
      backgroundColor: Colors.white,

      body: SizedBox(
        width: double.infinity,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                 SizedBox(height: 12,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Report an issue to improve the road\nconditions.",
                    style: Styles.styledarkblack16bold,
                  ),
                ),
                SizedBox(height: 20,),
                CustomDropdownButton(
                  onSaved: (value) {
                    selectedValue = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select issue.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10,),
                CustomReportTextfield(),
                 SizedBox(height: 12,),
                InkWell(
                  onTap: (){},
                  child: CustomAddphotoContainer()),
                 SizedBox(height: 12,),
                CustomReportLocationRow(),
                Spacer(flex: 1,),
                CustomPaymentButton(
                  buttonText: "Submit Report",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      log(selectedValue!);
                    }
                  },
                ),
                 SizedBox(height: 32,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
