import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_contribute_search_textfield.dart';

class GooglemapsView extends StatefulWidget {
  const GooglemapsView({super.key});

  @override
  State<GooglemapsView> createState() => _GooglemapsViewState();
}

class _GooglemapsViewState extends State<GooglemapsView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(target: LatLng(30, 45)),
        ),
        Positioned(
          top: 40,
          right: 0,
          left: 0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomContributeSearchTextField(color: Colors.white),
              Column(
                children: [
                  Image.asset("assets/images/profile.png", width: 50),
                  SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      showBottomSheet(
                        context: context,
                        builder:
                            (context) => Positioned(
                              bottom: 0,
                              child: BottomSheet(
                                onClosing: () {},
                                builder: (context) => Text("data"),
                              ),
                            ),
                      );
                    },
                    child: SvgPicture.asset("assets/icons/edit_map.svg"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
