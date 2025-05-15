import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/cubits/get_nearby_places_cubit/get_nearby_places_cubit.dart';
import 'package:pathly/models/services_model.dart';
import 'package:pathly/views/bottom_nav_views/nearby_places_view.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_services_container.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

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
                              servicesCoulmn1.length,
                              (index) => InkWell(
                                onTap: () {
                                  Get.to(
                                    () => BlocProvider<GetNearbyPlacesCubit>(
                                      create:
                                          (context) =>
                                              GetNearbyPlacesCubit()
                                                ..getNearbyPlaces(
                                                  lat: 31.4355529,
                                                  lng: 31.6746909,
                                                  type:
                                                      servicesCoulmn1[index]
                                                          .serviceName,
                                                ),
                                      child: NearbyPlacesView(serviceName:servicesCoulmn1[index]
                                                          .serviceName ,),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Image.asset(
                                    servicesCoulmn1[index].image,
                                    width: 170,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Column(
                            children: [
                              Column(
                                children: List.generate(
                                  servicesCoulmn2.length,
                                  (index) => InkWell(
                                    onTap: () {
                                       Get.to(
                                    () => BlocProvider<GetNearbyPlacesCubit>(
                                      create:
                                          (context) =>
                                              GetNearbyPlacesCubit()
                                                ..getNearbyPlaces(
                                                  lat: 31.4355529,
                                                  lng: 31.6746909,
                                                  type:
                                                      servicesCoulmn2[index]
                                                          .serviceName,
                                                ),
                                      child: NearbyPlacesView(serviceName: servicesCoulmn2[index]
                                                          .serviceName,),
                                    ),
                                  );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 16,
                                      ),
                                      child: Image.asset(
                                        servicesCoulmn2[index].image,
                                        width: 170,
                                      ),
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
