import 'package:flutter/material.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/utils/textstyles.dart';

class VoiceBottomsheetBody extends StatelessWidget {
  const VoiceBottomsheetBody({super.key,required this.tryOnPressed});
final VoidCallback tryOnPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                textAlign: TextAlign.start,
                "New! Faster Way to\nsearch",
                style: Styles.stylePrimaryColorbold24,
              ),
            ),
            SizedBox(height: 20),
            Text(
              textAlign: TextAlign.start,
              "To get directions and search for places with your voice , allow pathly to record audio.",
              style: Styles.stylePrimaryColor18,
            ),
            Image.asset(
              "assets/images/voice_search_image.png",
              height: 220,
              width: 220,
            ),
            ElevatedButton(
              onPressed:tryOnPressed,
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(kPrimaryColor),
                fixedSize: WidgetStatePropertyAll(Size(240, 40)),
              ),
              child: Text("Try", style: Styles.styleWhite16),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Not now", style: Styles.stylePrimaryColor18),
            ),
          ],
        ),
      ),
    );
  }
}
