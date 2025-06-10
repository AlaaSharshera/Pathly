import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/models/places_auto_complete_model/places_auto_complete.dart';
import 'package:pathly/models/places_details/places_details_model.dart';
import 'package:pathly/services/google_maps_places_service.dart';
import 'package:pathly/utils/textstyles.dart';
import 'package:uuid/uuid.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key, required this.onLocationSelected});
  final Function(PlacesDetailsModel) onLocationSelected;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late TextEditingController controller;
  late GoogleMapsPlacesService googleMapsPlacesService;
  List<PlacesAutoCompleteModel> placesList = [];
  late Uuid uuid;
  String? sessiontoken;
  bool _isLoading = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    googleMapsPlacesService = GoogleMapsPlacesService();
    uuid = const Uuid();
    controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final input = controller.text;
    sessiontoken ??= uuid.v4();

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () async {
      if (input.isEmpty) {
        if (mounted) {
          setState(() {
            placesList.clear();
          });
        }
        return;
      }

      final places = await googleMapsPlacesService.placesAutoComplteService(
        userInput: input,
        sessiontoken: sessiontoken!,
      );

      if (mounted && controller.text == input) {
        setState(() {
          placesList = places;
        });
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    Container(
                      width: 280,
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color(0xffF3F3F8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(
                        cursorColor: kPrimaryColor,
                        controller: controller,
                        textInputAction: TextInputAction.search,
                        onFieldSubmitted:
                            (_) => FocusScope.of(context).unfocus(),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8),
                          hintText: "Search here",
                          hintStyle: Styles.stylegrey16,
                          border: InputBorder.none,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                              "assets/icons/voice.svg",
                              color: const Color(0xff5C5454),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "assets/icons/mage_filter-fill.svg",
                        color: const Color(0xff5C5454),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 76,
                  child: Row(
                    children: [
                      const CustomContainer(
                        image: "assets/icons/home.svg",
                        location: "31.114541212",
                        placeName: "Home",
                      ),
                      const VerticalDivider(indent: 16, width: 1),
                      const CustomContainer(
                        image: "assets/icons/work.svg",
                        placeName: "Work",
                        location: "31.114541212",
                      ),
                      const VerticalDivider(indent: 16, width: 1),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              "assets/icons/menu-dots.svg",
                            ),
                          ),
                          Text("More", style: Styles.stylePrimaryColorbold16),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(thickness: 8, color: Color(0xffD1D1D6)),
              ],
            ),

            if (placesList.isNotEmpty)
              Positioned(
                top: 70,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        itemBuilder: (context, index) {
                          final place = placesList[index];
                          return ListTile(
                            trailing: SvgPicture.asset(
                              'assets/icons/arrow_go.svg',
                              height: 14,
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  place.structuredFormatting!.mainText!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Styles.stylePrimaryColorbold16,
                                ),
                                Text(
                                  place.description ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Styles.styleMediamgrey14,
                                ),
                              ],
                            ),
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            onTap: () async {
                              if (_isLoading) return;

                              setState(() {
                                _isLoading = true;
                                placesList.clear();
                                controller.text =
                                    place.structuredFormatting!.mainText!;
                              });

                              try {
                                FocusScope.of(context).unfocus();
                                final details = await googleMapsPlacesService
                                    .placeDetailsService(
                                      placeId: place.placeId!,
                                      sessiontoken: sessiontoken!,
                                    );
                                sessiontoken = null;
                                widget.onLocationSelected(details);
                                Get.back();
                              } catch (e) {
                                log("Error: $e");
                                Get.snackbar(
                                  "Error",
                                  "Failed to get location details",
                                );
                              } finally {
                                if (mounted) {
                                  setState(() => _isLoading = false);
                                }
                              }
                            },
                          );
                        },
                        separatorBuilder:
                            (_, __) => const Divider(
                              height: 2,
                              indent: 10,
                              endIndent: 20,
                              thickness: 1.5,
                            ),
                        itemCount: placesList.length,
                      ),
                    ),
                    const Divider(thickness: 8, color: Color(0xffD1D1D6)),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.location_on,
                              color: Color(0xff5C5454),
                            ),
                          ),
                          Text(
                            "choose on Map",
                            style: Styles.styledarkgrey16bold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              ),
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    required this.image,
    required this.placeName,
    required this.location,
    super.key,
  });

  final String image;
  final String placeName;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: 76,
      width: 130,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xffE2EBF2),
            child: SvgPicture.asset(image, width: 16),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(placeName, style: Styles.stylePrimaryColorbold16),
              Text(
                location,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xff1E1E1E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
