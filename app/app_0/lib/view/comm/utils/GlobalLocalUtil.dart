import 'package:geolocator/geolocator.dart';

/// -------------------------------
/// Des: 公共地理信息工具类
/// -------------------------------

class GlobalLocalUtil {
  static Geolocator _geolocator = Geolocator()..forceAndroidLocationManager;

  static Position _currentPosition;

  static Placemark _place;

  /// 国家代码
  static String isoCountryCode;

  /// 国家
  static String country;

  /// 省
  static String administrativeArea;

  /// 市
  static String locality;

  /// 区
  static String subLocality;

  ///街道
  static String thoroughfare;

  /// 经度
  static double longitude;

  /// 纬度
  static double latitude;

  /// 初始化
  static Future<void> init() async {
    _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      /// 初始化定位对象
      _currentPosition = position;
    });
    List<Placemark> p = await _geolocator.placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude);
    _place = p[0];

    /// 国家代码
    isoCountryCode = _place.isoCountryCode;

    /// 国家
    country = _place.country;

    /// 省
    administrativeArea = _place.administrativeArea;

    /// 市
    locality = _place.locality;

    /// 区
    subLocality = _place.subLocality;

    ///街道
    thoroughfare = _place.thoroughfare;

    /// 经度
    longitude = _place.position.longitude;

    /// 纬度
    latitude = _place.position.longitude;
  }
}
