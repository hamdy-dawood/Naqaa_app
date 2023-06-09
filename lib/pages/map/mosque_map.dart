import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/components/svg_icons.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/pages/add_all_basket_order/view.dart';

import 'address_model.dart';

class MosqueMap extends StatefulWidget {
  const MosqueMap({required this.addressType, Key? key}) : super(key: key);
  final String addressType;

  @override
  _MosqueMapState createState() => _MosqueMapState();
}

class _MosqueMapState extends State<MosqueMap> {
  GoogleMapController? mapController;
  LatLng? _center;
  Location location = Location();
  bool? _serviceEnabled;
  bool isShowLoader = false;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  final Set<Marker> _markers = {};
  Address? selectedAddress;
  var addressM;
  String? addressName;
  String? addressType;
  String? short;
  String? lat;
  String? long;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final _form = GlobalKey<FormState>();
  var addressController = TextEditingController();
  MapType type = MapType.normal;

  CameraPosition? position;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!(_serviceEnabled ?? true)) {
      _serviceEnabled = await location.requestService();
      if (!(_serviceEnabled ?? true)) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {
      _center =
          LatLng(_locationData?.latitude ?? 0, _locationData?.longitude ?? 0);
    });
    getNearbyMosques(
        LatLng(_locationData?.latitude ?? 0, _locationData?.longitude ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 22.sp,
            color: ColorManager.white,
          ),
        ),
        title: Text("Map"),
      ),
      body: _center == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                    mapType: type,
                    indoorViewEnabled: true,
                    myLocationEnabled: true,
                    mapToolbarEnabled: true,
                    trafficEnabled: true,
                    onTap: (location) async {
                      if (widget.addressType == "mosque") {
                        getLocation(location.latitude, location.longitude);
                        isShowLoader = true;
                      }
                    },
                    onCameraMove: (lat) {
                      position = lat;
                    },
                    onCameraIdle: () {
                      if (widget.addressType != "mosque" && position != null) {
                        getNearbyMosques(LatLng(position!.target.latitude,
                            position!.target.longitude));
                      }
                    },
                    onMapCreated: _onMapCreated,
                    initialCameraPosition:
                        CameraPosition(target: _center!, zoom: 14.0),
                    markers: _markers),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (type == MapType.normal) {
                        type = MapType.satellite;
                      } else {
                        type = MapType.normal;
                      }
                    });
                  },
                  child: Container(
                    height: 37,
                    width: 37,
                    margin: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(3)),
                    child: Icon(
                      Icons.satellite_alt,
                      size: 20,
                    ),
                  ),
                ),
                Center(
                  child:
                      isShowLoader ? CircularProgressIndicator() : Container(),
                )
              ],
            ),
    );
  }

  Future<void> showBottomSheet(Address address) async {
    Get.bottomSheet(Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            CustomText(
              text: "Confirm Your Address",
              color: ColorManager.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 10.h),
            Divider(
              height: 3.h,
              thickness: 1,
              color: ColorManager.border2Color,
            ),
            SizedBox(height: 10.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgIcon(
                      height: 22.h,
                      icon: AssetsStrings.locationIcon,
                      color: ColorManager.black,
                    ),
                    SizedBox(width: 10.h),
                    Expanded(
                      child: Text(
                        address.addressName ?? '',
                        style: GoogleFonts.redHatDisplay(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.h),
                CustomElevated(
                  text: "next".tr,
                  press: () async {
                    addressM = jsonEncode(address.toJson());
                    addressName = address.addressName;
                    addressType = address.type;
                    lat = address.lat;
                    long = address.long;
                    short = address.short;

                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AddAllBasketOrderView(
                            orderAddressType: "Mosque",
                            lat: "${lat}",
                            long: "${long}",
                            address: "${addressName}",
                            number: 5,
                          );
                        },
                      ),
                    );
                  },
                  btnColor: ColorManager.mainColor,
                  fontSize: 18.sp,
                  borderRadius: 8.r,
                  paddingVertical: 5.w,
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> showBottomSheetHome(Address address) {
    return Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        width: double.infinity,
        child: Form(
          key: _form,
          child: Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                CustomText(
                  text: "Confirm Your Address",
                  color: ColorManager.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 10.h),
                Divider(
                  height: 3.h,
                  thickness: 1,
                  color: ColorManager.border2Color,
                ),
                SizedBox(height: 10.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgIcon(
                          height: 22.h,
                          icon: AssetsStrings.locationIcon,
                          color: ColorManager.black,
                        ),
                        SizedBox(width: 10.h),
                        Expanded(
                          child: Text(
                            address.addressName ?? '',
                            style: GoogleFonts.redHatDisplay(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Marker>> getNearbyMosques(LatLng currentPosition) async {
    String apiUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
        'location=${currentPosition.latitude},${currentPosition.longitude}'
        '&rankby=distance&type=mosque&key=AIzaSyDjjZzMmPfqAB8xbfhXhr2yiEaJ8n5EiDg';

    final response = await Dio().get(apiUrl);

    if (response.statusCode == 200) {
      List<Marker> markers = [];
      var data;
      if (response.data is Map<String, dynamic>) {
        data = response.data;
      } else if (response.data is String) {
        data = jsonDecode(response.data);
      }

      data['results'].forEach((result) async {
        final latLng = LatLng(result['geometry']['location']['lat'],
            result['geometry']['location']['lng']);

        BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(50, 50)),
          "assets/images/mosqueImage.png",
        );

        final marker = Marker(
            markerId: MarkerId(result['place_id']),
            icon: markerbitmap,
            position: latLng,
            infoWindow: InfoWindow(title: result['name'] ?? "Mosque"),
            onTap: () async {
              int id = 0;
              var rng = Random();
              for (var i = 0; i < 1000; i++) {
                id = rng.nextInt(100);
              }

              var selectedAddress = Address(
                  addressName: result['name'] ?? '',
                  short: '',
                  type: widget.addressType == "mosque" ? 'mosque' : "home",
                  id: id,
                  lat: "${result['geometry']['location']['lat'] ?? ''}",
                  long: "${result['geometry']['location']['lng'] ?? ''}");

              if (widget.addressType == "mosque") {
                showBottomSheet(selectedAddress);
              } else {
                showBottomSheetHome(selectedAddress);
              }
            });

        _markers.add(marker);
      });

      setState(() {});
      return markers;
    } else {
      throw Exception('Failed to fetch mosque data');
    }
  }

  getLocation(double lat, double long) async {
    String apiUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyDjjZzMmPfqAB8xbfhXhr2yiEaJ8n5EiDg';
    final response = await Dio().get(apiUrl);
    setState(() {
      isShowLoader = true;
    });
    if (response.statusCode == 200) {
      try {
        var data;
        if (response.data is Map<String, dynamic>) {
          data = response.data;
        } else if (response.data is String) {
          data = jsonDecode(response.data);
        }
        var address = data['results'][0]['formatted_address'];

        int id = 0;
        var rng = Random();
        for (var i = 0; i < 1000; i++) {
          id = rng.nextInt(100);
        }
        var selectedAddress =
            Address(addressName: address, short: '', type: "home", id: id);
        setState(() {
          isShowLoader = false;
        });
        showBottomSheetHome(selectedAddress);
      } catch (e) {
        print("Error: ${e.toString()}");
      }
      setState(() {});
    } else {
      throw Exception('Failed to fetch restaurant data');
    }
  }
}
