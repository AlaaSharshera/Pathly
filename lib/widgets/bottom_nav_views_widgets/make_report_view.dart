import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/cubits/botton_navbar_cubit.dart/bottom_navbar_cubit.dart';
import 'package:pathly/services/report_service.dart';
import 'package:pathly/utils/textstyles.dart';
import 'package:pathly/views/bottom_nav_views/bottom_navbar.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_addphoto_container.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_dropdown_button.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_report_textfield.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_reportlocation_row.dart';
import 'package:pathly/widgets/payment_widgets/custom_payment_appbar.dart';
import 'package:pathly/widgets/payment_widgets/custom_payment_button.dart';
import 'package:pathly/widgets/payment_widgets/paymentdone_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class MakeReportView extends StatefulWidget {
  const MakeReportView({super.key});

  @override
  State<MakeReportView> createState() => _MakeReportViewState();
}

class _MakeReportViewState extends State<MakeReportView> {
  String? selectedValue;
  String? problemDescription;
  File? imageFile;
  bool isImageMissing = false;
  String? fileExtension;

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final ImagePicker _picker = ImagePicker();

  Future<bool> requestPhotoPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.photos.isGranted ||
          await Permission.storage.isGranted) {
        return true;
      }

      if (await Permission.photos.request().isGranted) {
        return true;
      }

      if (await Permission.storage.request().isGranted) {
        return true;
      }

      return false;
    }

    final status = await Permission.photos.request();
    return status.isGranted;
  }

  Future<void> pickImage() async {
    bool granted = await requestPhotoPermission();
    if (!granted) return;

    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) return;

    fileExtension = pickedFile.path.split('.').last.toLowerCase();
    final allowedExtensions = [
      'jpg',
      'jpeg',
      'png',
    ]; 

    if (!allowedExtensions.contains(fileExtension)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text(
            'JPG, JPEG, PNG  يُرجى اختيار صورة بصيغة ',
            style: Styles.styleWhite16,
            textAlign: TextAlign.center,
          ),
        ),
      );
      return;
    }

    setState(() {
      imageFile = File(pickedFile.path);
      isImageMissing = false;
    });
  }

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
            child: ListView(
              children: [
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Report an issue to improve the road\nconditions.",
                    style: Styles.styledarkblack16bold,
                  ),
                ),
                SizedBox(height: 20),
                CustomDropdownButton(
                  autovalidateMode: autovalidateMode,
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
                SizedBox(height: 10),
                CustomReportTextfield(
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).unfocus();
                  },
                  autovalidateMode: autovalidateMode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please write the problem';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    problemDescription = value;
                  },
                ),
                SizedBox(height: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        await pickImage();
                        if (imageFile != null) {
                          setState(() {
                            isImageMissing = false;
                          });
                        }
                      },
                      child:
                          imageFile == null
                              ? Center(child: CustomAddphotoContainer())
                              : Center(child: Image.file(imageFile!)),
                    ),
                    if (isImageMissing)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Please add a photo.",
                          style: TextStyle(
                            color: Color(0xffB3261E),
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),

                SizedBox(height: 12),
                CustomReportLocationRow(),
                SizedBox(
                  height:
                      imageFile == null
                          ? MediaQuery.of(context).size.height * 0.08
                          : MediaQuery.of(context).size.height * 0.1,
                ),
                CustomPaymentButton(
                  buttonText: "Submit Report",
                  onPressed: () async {
                    autovalidateMode = AutovalidateMode.onUserInteraction;
                    setState(() {
                      isImageMissing = imageFile == null;
                    });

                    if (formKey.currentState!.validate() && imageFile != null) {
                      formKey.currentState!.save();
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder:
                            (context) => Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            ),
                      );
                      log("validate");
                      log(selectedValue!);
                      log(problemDescription!);
                      log(imageFile.toString());
                      try {
                        final response = await ReportService().reportService(
                          reportType: selectedValue!,
                          description: problemDescription!,
                          latitude: 31.43496067,
                          longitude: 31.67756983,
                          imageType: fileExtension!,
                          imageFile: imageFile!,
                        );

                        Navigator.pop(context);

                        Get.dialog(
                          CustomDoneDialog(
                            text: " Report is sent successfully!",
                            onpressed: () {
                              Get.offAll(
                                () => BlocProvider<BottomNavbarCubit>(
                                  create: (context) => BottomNavbarCubit(),
                                  child: BottomNavbar(),
                                ),
                              );
                            },
                          ),
                          barrierColor: Colors.black.withOpacity(0.5),
                        );

                        log("Response: $response");
                      } catch (e) {
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'خطأ في إرسال التقرير: ${e.toString()}',
                            ),
                          ),
                        );

                        log("Error: $e");
                      }
                    } else {
                      log("not validate");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
