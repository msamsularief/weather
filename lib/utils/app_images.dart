class AppImages {
  static const String defaultImg = "assets/images/default.png";

  /// 0 - Cerah
  static const String clearSkies = "assets/images/0.png";

  /// 1 - Cerah Berawan
  static const String partlyCloudy = "assets/images/1.png";

  /// 2 - Cerah Berawan
  static const String partlyCloudy2 = "assets/images/2.png";

  /// 3 - Berawan
  static const String mostlyCloudy = "assets/images/3.png";

  /// 4 -  Berawan Tebal
  static const String overcast = "assets/images/4.png";

  /// 5 - Udara Kabur
  static const String haze = "assets/images/5.png";

  /// 10 - Asap
  static const String smoke = "assets/images/10.png";

  /// 45 - Kabut
  static const String fog = "assets/images/45.png";

  /// 60 - Hujan Ringan
  static const String lightRain = "assets/images/60.png";

  /// 61 - Hujan
  static const String rain = "assets/images/61.png";

  /// 63 - Hujan Lebat
  static const String heavyRain = "assets/images/63.png";

  /// 80 - Hujan Lokal
  static const String isolatedRain = "assets/images/80.png";

  /// 95 - Hujan Petir Siang
  static const String stormDay = "assets/images/95.png";

  /// 97 - Hujan Petir Malam
  static const String stormNight = "assets/images/97.png";

  /// **GET assets data by its ID**
  /// 
  /// 0 - Cerah,
  ///
  /// 1 - Cerah Berawan,
  ///
  /// 2 - Cerah Berawan,
  ///
  /// 3 - Berawan,
  ///
  /// 4 -  Berawan Tebal,
  ///
  /// 5 - Udara Kabur,
  ///
  /// 10 - Asap,
  ///
  /// 45 - Kabut,
  ///
  /// 60 - Hujan Ringan,
  ///
  /// 61 - Hujan,
  ///
  /// 63 - Hujan Lebat,
  ///
  /// 80 - Hujan Lokal,
  ///
  /// 95 - Hujan Petir Siang,
  ///
  /// 97 - Hujan Petir Malam
  ///
  static String getByID(String id) => "assets/images/$id.png";
}
