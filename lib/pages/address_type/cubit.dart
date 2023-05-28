import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqaa/pages/location/services.dart';

import 'states.dart';

enum AddressType { mosque, home }

class AddressTypeCubit extends Cubit<AddressTypeStates> {
  AddressTypeCubit() : super(AddressTypeInitialState());

  static AddressTypeCubit get(context) => BlocProvider.of(context);

  AddressType? type;
  String? mosque, home, lat, long;

  void mosqueType() {
    type = AddressType.mosque;
    emit(MosqueTypeState());
  }

  void homeType() {
    type = AddressType.home;
    emit(HomeTypeState());
  }

  void getLocation() async {
    final service = LocationService();
    final locationData = await service.getLocation();

    if (locationData != null) {
      lat = locationData.latitude!.toStringAsFixed(2);
      long = locationData.longitude!.toStringAsFixed(2);
      emit(LocationState());
    }
  }
}
