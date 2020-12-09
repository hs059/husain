
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';


class Location {

  Location._();
  static final  Location location =   Location._();
  Position currentPosition;
  String currentAddress;
  String name;
  String phoneNum;
  Geolocator geolocator ;

  Future<Geolocator> initGeolocator() async {
    if (geolocator == null) {
      geolocator = Geolocator()..forceAndroidLocationManager;
      return geolocator;
    } else {
      return geolocator;
    }
  }

  getCurrentLocation()async{
    geolocator =await initGeolocator();
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
        currentPosition = position;
      getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  getAddressFromLatLng() async {
    try {
      geolocator =await initGeolocator();
      List<Placemark> p =
      // 40.5237017,-105.0719352
      // await geolocator.placemarkFromCoordinates(40.5237017,-105.0719352);
      await geolocator.placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);
      Placemark place = p[0];
        currentAddress =
        "${place.locality}, ${place.administrativeArea}, ${place.subLocality}";
        print(' postalCode :${place.postalCode}');
      print(' country :${place.country}');
      print(' isoCountryCode :${place.isoCountryCode}');
      print(' name :${place.name}');
      print(' locality :${place.locality}');
      print(' administrativeArea : ${place.administrativeArea}');
      print(' subAdministrativeArea :${place.subAdministrativeArea}');
      print(' subLocality :${place.subLocality}');
      print(' thoroughfare : ${place.thoroughfare}');
      print(' subThoroughfare : ${place.subThoroughfare}');
        Logger().d(' address : ${place.subLocality}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}, ${place.country}');
        Logger().d(' address : ${place.thoroughfare}, ${place.subThoroughfare}, ${place.locality}, ${place.subLocality}');
        return currentAddress ;
    } catch (e) {
      print(e);
    }
  }


}