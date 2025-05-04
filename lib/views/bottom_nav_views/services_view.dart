import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_services_container.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});
  final List<String> imagesCoulmn1 = const [
    "images/must_eat.png",
    "images/car_services.png",
    "images/cafe.png",
    "images/shopping.png",
    "images/beauty.png",
  ];

  final List<String> imagesCoulmn2 = const [
    "images/best_hotel.png",
    "images/historical_places.png",
    "images/hospital.png",
    "images/gym.png",
    "images/pharmacy.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomServicesContainer(
                  placeName: "Home",
                  image: "images/home.svg",
                ),
                CustomServicesContainer(
                  placeName: "Work",
                  image: "images/work.svg",
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Image.asset("images/map_background.png"),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: List.generate(
                              imagesCoulmn1.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 24),
                                child: Image.asset(imagesCoulmn1[index]),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Column(
                                children: List.generate(
                                  imagesCoulmn2.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 24),
                                    child: Image.asset(imagesCoulmn2[index]),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 179,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  "More",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
