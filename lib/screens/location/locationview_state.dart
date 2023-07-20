part of 'locationview_cubit.dart';

class LocationViewState extends Equatable {
  late String mapStyle;
  late final GoogleMapController? mapController;
  final CameraPosition? cameraPosition;
  final LatLng? location;
  final int index;
  final List<MapModel> image;
  final Set<Marker>? markers;
  LocationViewState(
      {required this.mapStyle,
      this.cameraPosition,
      this.mapController,
      this.location,
      required this.image,
      required this.index,
      this.markers});
  @override
  // TODO: implement props
  List<Object?> get props => [cameraPosition, location, markers, index, mapController, mapStyle];

  LocationViewState copyWith({
    String? mapStyle,
    GoogleMapController? mapController,
    CameraPosition? cameraPosition,
    LatLng? location,
    int? index,

    List<MapModel>? image,
    Set<Marker>? markers,
  }) {
    return LocationViewState(
      mapStyle: mapStyle ?? this.mapStyle,
      mapController: mapController ?? this.mapController,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      location: location ?? this.location,
      index: index ?? this.index,
      image: image ?? this.image,
      markers: markers ?? this.markers,
    );
  }
}
