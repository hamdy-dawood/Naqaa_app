import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/pages/location/services.dart';

class LocationView extends StatefulWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  String? lat, long, country, adminArea;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("location"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: 1.sw,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Location Info :',
                style: getStyle(size: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Latitude: ${lat ?? 'Loading ...'}',
                style: getStyle(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Longitude: ${long ?? 'Loading ...'}',
                style: getStyle(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Country: ${country ?? 'Loading ...'}',
                style: getStyle(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Area: ${adminArea ?? 'Loading ...'}',
                style: getStyle(),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle getStyle({double size = 20}) =>
      TextStyle(fontSize: size, fontWeight: FontWeight.bold);

  void getLocation() async {
    final service = LocationService();
    final locationData = await service.getLocation();

    if (locationData != null) {
      final placeMark = await service.getPlaceMark(locationData: locationData);

      setState(() {
        lat = locationData.latitude!.toStringAsFixed(2);
        long = locationData.longitude!.toStringAsFixed(2);

        country = placeMark?.country ?? 'could not get country';
        adminArea = placeMark?.administrativeArea ?? 'could not get admin area';
      });
    }
  }
}
