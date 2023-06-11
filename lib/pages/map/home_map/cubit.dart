import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:naqaa/pages/map/address_model.dart';

import 'states.dart';

class HomeMapCubit extends Cubit<HomeMapStates> {
  HomeMapCubit() : super(HomeMapInitialState());

  static HomeMapCubit get(context) => BlocProvider.of(context);
  late LatLng currentLocation;
  Address? currentAddress;
  final Location location = Location();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  int markerIdCounter = 0;
  Completer<GoogleMapController> mapController = Completer();

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController.complete(controller);

    LocationData _locationData;
    _locationData = await location.getLocation();

    currentLocation = LatLng(_locationData.latitude!, _locationData.longitude!);
    updateMarker();

    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLocation, zoom: 18.0),
      ),
    );
    await getLocation();
  }

  String markerIdVal({bool increment = false}) {
    String val = 'marker_id_$markerIdCounter';
    if (increment) markerIdCounter++;
    return val;
  }

  MapType type = MapType.normal;

  void tapMap() {
    if (type == MapType.normal) {
      type = MapType.satellite;
    } else {
      type = MapType.normal;
    }
    emit(TapMapMarkerState());
  }

  Future<void> getLocation() async {
    String apiUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${currentLocation.latitude},${currentLocation.longitude}&key=AIzaSyDjjZzMmPfqAB8xbfhXhr2yiEaJ8n5EiDg';
    final response = await Dio().get(apiUrl);
    print("API : ${apiUrl}");
    print("StatusCode: ${response.statusCode}");
    emit(HomeMapLoadingState());
    if (response.statusCode == 200) {
      try {
        var data;
        if (response.data is Map<String, dynamic>) {
          data = response.data;
        } else if (response.data is String) {
          data = jsonDecode(response.data);
        }
        print(data);
        var address = data['results'][0]['formatted_address'];
        print("Address: $address");
        int id = 0;
        var rng = Random();
        for (var i = 0; i < 1000; i++) {
          id = rng.nextInt(100);
        }
        currentAddress = Address(
            addressName: address,
            short: '',
            type: "home",
            id: id,
            lat: "${data['results'][0]['geometry']['location']['lat']}",
            long: "${data['results'][0]['geometry']['location']['lng']}");
        print(
            "Current Address -> ${currentAddress?.lat} | ${currentAddress?.long}");
        emit(HomeMapSuccessState());
      } catch (e) {
        print("Error: ${e.toString()}");
        emit(HomeMapFailureState());
      }
    } else {
      emit(HomeMapFailureState());
    }
  }

  Future<void> updateMarker() async {
    GoogleMapController controller = await mapController.future;
    MarkerId markerId = MarkerId(markerIdVal());
    Marker marker = Marker(
      markerId: markerId,
      position: currentLocation,
      draggable: false,
    );
    markers[markerId] = marker;
    emit(HomeMapMarkerState());
  }
}
