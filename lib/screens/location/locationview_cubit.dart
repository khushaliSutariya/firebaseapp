import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:location/location.dart';

import '../../model/mapmodel.dart';

part 'locationview_state.dart';

class LocationViewCubit extends Cubit<LocationViewState> {
  BuildContext context;
  final Location location = Location();

  LocationViewCubit({required this.context})
      : super(LocationViewState(index: 0,mapStyle: "", image: [
    MapModel(image: "assets/map/standard.jpg", json: "assets/maptheme/standard.json", text: "standard"),
    MapModel(image: "assets/map/silver.jpg", json: "assets/maptheme/silver.json", text: "Silver"),
    MapModel(image: "assets/map/retro.png", json: "assets/maptheme/retro.json", text: "Retro"),
    MapModel(image: "assets/map/night.png", json: "assets/maptheme/night.json", text: "Night"),
    MapModel(image: "assets/map/dark.png", json: "assets/maptheme/dark.json", text: "Dark"),
    MapModel(image: "assets/map/aubergine.jpg", json: "assets/maptheme/aubergine.json", text: "Aubergine"),
  ]));

  Future<void> changeStyle(context, controller) async {
    await rootBundle.loadString(state.image[state.index].json.toString()).then((theme) {
      state.mapController?.setMapStyle(theme);
      print("rot${state.mapController}");
    }).catchError((error) {
      print("error");
      log(error.toString());
    });
  }

  void mapCreated(controller) {
    emit(state.copyWith(mapController: controller));
  }

  void changeIndex(int index) {
    emit(state.copyWith(index: index));
  }


  void onCloseDialog(int index){
    emit(state.copyWith(index: index));
    Navigator.pop(context);
  }



  Future<void> openAlertBox() async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return BlocProvider.value(
            value: this,
            child: BlocBuilder<LocationViewCubit, LocationViewState>(
              builder: (context, state) {
                return AlertDialog(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  contentPadding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  content: SizedBox(
                    width: double.minPositive,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Change Map Theme",
                                style: TextStyle(fontSize: 17.0),
                              ),
                              IconButton(
                                  onPressed: () {
                                   onCloseDialog(state.index);
                                  },
                                  icon: const Icon(Icons.close))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
                                itemCount: state.image.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            changeIndex(index);
                                          },
                                          child: Image.asset(state.image[index].image.toString())),
                                      Text(state.image[index].text.toString(),
                                          style: const TextStyle(color: Colors.white)),
                                      Positioned(
                                        top: 5.0,
                                        left: 5.0,
                                        child: state.index == index
                                            ? const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 15.0,
                                        )
                                            : const Icon(
                                          Icons.circle_outlined,
                                          color: Colors.blue,
                                          size: 15.0,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            changeStyle(context, state.mapController);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 40.0,
                            width: 100.0,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.blue),
                            child: const Center(
                                child: Text(
                                  "Save",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return;
      }
    }

    Position position = await geolocator.Geolocator.getCurrentPosition(
      desiredAccuracy: geolocator.LocationAccuracy.high,
    );
    final currentLocation = LatLng(position.latitude, position.longitude);
    final cameraPosition = CameraPosition(target: currentLocation, zoom: 15);
    final marker = getMarker(currentLocation);
    final markers = {marker};
    print('Location: $position');
    emit(state.copyWith(
        location: LatLng(position.latitude, position.longitude), markers: markers, cameraPosition: cameraPosition));
  }

  Marker getMarker(LatLng latLng) {
    final newCameraPosition = CameraPosition(
      target: latLng,
      zoom: 15,
    );
    return Marker(
      markerId: const MarkerId('current_location'),
      position: latLng,
      onDragEnd: (newPosition) {
        updateMarkerPosition(newPosition, newCameraPosition as double);
      },
      infoWindow: InfoWindow(
        title: latLng.toString(),
      ),
    );
  }

  void updateMarkerPosition(LatLng newPosition, double zoomLevel) {
    Set<Marker> markers = state.markers!;
    markers.add(getMarker(newPosition));
    final newCameraPosition = CameraPosition(
      target: newPosition,
      zoom: zoomLevel,
    );
    emit(state.copyWith(location: newPosition, markers: markers, cameraPosition: newCameraPosition));
  }
}
