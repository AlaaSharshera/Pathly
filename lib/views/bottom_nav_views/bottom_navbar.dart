import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/cubits/botton_navbar_cubit/bottom_navbar_cubit.dart';
import 'package:pathly/cubits/map_details_cubit/map_details_cubit.dart';
import 'package:pathly/cubits/map_type_cubit/map_type_cubit.dart';
import 'package:pathly/views/bottom_nav_views/contribute_view.dart';
import 'package:pathly/views/bottom_nav_views/home_view.dart';
import 'package:pathly/views/bottom_nav_views/profile_view.dart';
import 'package:pathly/views/bottom_nav_views/services_view.dart';
import 'package:pathly/views/bottom_nav_views/settings_view.dart';


class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavbarCubit, int>(
      builder:
          (context, state) => Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              key: bottomNavigationKey,
              index: 2,
              height: 65.0,
              items: [
                CurvedNavigationBarItem(
                  label: state == 0 ? 'Services' : null,
                  child: SvgPicture.asset(
                    'assets/icons/services.svg',
                    height: 24,
                    color: state == 0 ? kPrimaryColor : Colors.white,
                  ),
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                CurvedNavigationBarItem(
                  label: state == 1 ? 'Contribute' : null,
                  child: SvgPicture.asset(
                    'assets/icons/contribute.svg',
                    height: 26,
                    color: state == 1 ? kPrimaryColor : Colors.white,
                  ),
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                CurvedNavigationBarItem(
                  label: state == 2 ? 'Home' : null,
                  child: SvgPicture.asset(
                    'assets/icons/home.svg',
                    height: 24,
                    color: state == 2 ? kPrimaryColor : Colors.white,
                  ),
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                CurvedNavigationBarItem(
                  label: state == 3 ? 'Profile' : null,
                  child: SvgPicture.asset(
                    'assets/icons/profile.svg',
                    height: 24,
                    color: state == 3 ? kPrimaryColor : Colors.white,
                  ),
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                CurvedNavigationBarItem(
                  label: state == 4 ? 'Settings' : null,
                  child: SvgPicture.asset(
                    'assets/icons/settings.svg',
                    height: 24,
                    color: state == 4 ? kPrimaryColor : Colors.white,
                  ),
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
              color: kPrimaryColor,
              buttonBackgroundColor: Colors.white,
              backgroundColor: const Color(0xffD1D1D6),
              animationCurve: Curves.easeInOutCirc,
              animationDuration: const Duration(milliseconds: 400),
              onTap: (index) {
                context.read<BottomNavbarCubit>().changePage(index);
              },
              letIndexChange: (index) => true,
            ),
            body: views[state],
          ),
    );
  }
}

final views = [
  ServicesView(),
  ContributeView(),
  MultiBlocProvider(
              providers: [
                BlocProvider<MapDetailsCubit>(
                  create: (context) => MapDetailsCubit(),
                ),
                BlocProvider<MapTypeCubit>(create: (context) => MapTypeCubit()),
              ],child: HomeView()),
  ProfileView(),
  SettingsView(),
];
