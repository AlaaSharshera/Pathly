import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';

class PaymentDoneDialog extends StatelessWidget {
  const PaymentDoneDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.grey[100],
      backgroundColor: Colors.white,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: kPrimaryColor,
                radius: 28,
                child: Icon(Icons.check, color: Colors.white, size: 40),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  textAlign: TextAlign.center,
                  "Payment Done Successfully!",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(kPrimaryColor),
                ),
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "Done",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
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
