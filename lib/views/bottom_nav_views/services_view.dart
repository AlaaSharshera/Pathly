import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_services_container.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});
  final List<String> imagesCoulmn1 = const [
    "assets/images/must_eat.png",
    "assets/images/car_services.png",
    "assets/images/cafe.png",
    "assets/images/shopping.png",
    "assets/images/beauty.png",
  ];

  final List<String> imagesCoulmn2 = const [
    "assets/images/best_hotel.png",
    "assets/images/historical_places.png",
    "assets/images/hospital.png",
    "assets/images/gym.png",
    "assets/images/pharmacy.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomServicesContainer(
                  placeName: "Home",
                  image: "assets/icons/home.svg",
                ),
                CustomServicesContainer(
                  placeName: "Work",
                  image: "assets/icons/work.svg",
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16,
              ),
              child: Image.asset("assets/images/map_background.png"),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: List.generate(
                              imagesCoulmn1.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Image.asset(
                                  imagesCoulmn1[index],
                                  width: 170,
                                ),
                              ),
                            ),
                          ),

                          Column(
                            children: [
                              Column(
                                children: List.generate(
                                  imagesCoulmn2.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Image.asset(
                                      imagesCoulmn2[index],
                                      width: 170,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 165,
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
