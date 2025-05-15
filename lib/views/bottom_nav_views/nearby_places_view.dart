import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/cubits/get_nearby_places_cubit/get_nearby_places_cubit.dart';
import 'package:pathly/cubits/get_nearby_places_cubit/get_nearby_places_states.dart';
import 'package:pathly/utils/textstyles.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/nearby_places_container.dart';

class NearbyPlacesView extends StatefulWidget {
  final String serviceName;

  const NearbyPlacesView({required this.serviceName,super.key});

  @override
  State<NearbyPlacesView> createState() => _NearbyPlacesViewState();
}

class _NearbyPlacesViewState extends State<NearbyPlacesView> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Nearby ${widget.serviceName}s", style: Styles.stylePrimaryColorbold18),
      ),
      body: BlocBuilder<GetNearbyPlacesCubit,GetNearbyPlacesStates>(builder: (context,state){
        if (state is LoadingNearbyPlacesState){
 return Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                        padding: EdgeInsets.all(20),
                      ),
                    );
        }else if (state is LoadedNearbyPlacesState){
return ListView.separated(
        itemCount: state.nearbyPlaces.length,
          itemBuilder:
            (context, index) => InkWell(
              onTap: () async {
                selectedIndex = index;

                setState(() {});
              },
              child: NearbyPlacesContainer(isActive: selectedIndex == index,nearbyPlacesModel: state.nearbyPlaces[index]),
            ),
            separatorBuilder: (context, index) => Divider(
              color: kPrimaryColor,
              thickness: 0.5,
              height: 1,
              indent: 15,
              endIndent: 15,

            ),
      
      );
        }else if (state is FailureNearbyPlacesState){
          return Text(state.errMessage);
        }
        else{
          return SizedBox();
        }
      })
    );
  }
}
