import 'package:firebaseapp/screens/location/locationview_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreens extends StatefulWidget {
  const LocationScreens({Key? key}) : super(key: key);

  @override
  State<LocationScreens> createState() => _LocationScreensState();
}

class _LocationScreensState extends State<LocationScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
        LocationViewCubit(context: context)
          ..getCurrentLocation(),
        child: BlocBuilder<LocationViewCubit, LocationViewState>(
          builder: (context, state) {
            return Stack(
              children: [
                state.location != null
                    ? GoogleMap(
                  initialCameraPosition: state.cameraPosition!,
                  myLocationEnabled: true,
                  trafficEnabled: true,
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  myLocationButtonEnabled: true,
                  // mapType: MapType.hybrid,

                  onMapCreated: (controller) {
                    context.read<LocationViewCubit>().mapCreated(controller);
                  },
                  onTap: (position) {
                    const double zoomLevel = 15.0;
                    state.mapController!.animateCamera(CameraUpdate.newLatLng(position));
                    context.read<LocationViewCubit>().updateMarkerPosition(position, zoomLevel);
                  },
                  markers: state.markers ?? <Marker>{},
                )
                    : const Center(child: CircularProgressIndicator()),
                Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: InkWell(
                      onTap: () {
                        context.read<LocationViewCubit>().openAlertBox();
                      },
                      child: CircleAvatar(
                        radius: 25.0,
                        backgroundColor: Colors.blue,
                        child: Container(),
                      ),
                    )),
              ],
            );
          },
        ),
      ),
    );
  }


}
