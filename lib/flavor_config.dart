import 'package:flutter/material.dart';


/*class FlavorConfig {
  String? appTitle;
  String? variable;



  FlavorConfig({this.variable});
}*/
enum Flavor { DEVELOPMENT, TESTING }

class FlavorConfig {
  static FlavorConfig? _instance;
  final Flavor flavor;
  final String variable;

  FlavorConfig._({required this.flavor, required this.variable});

  factory FlavorConfig.development() {
    return FlavorConfig._(
      flavor: Flavor.DEVELOPMENT,
      variable: "Development Flavor",
    );
  }

  factory FlavorConfig.testing() {
    return FlavorConfig._(
      flavor: Flavor.TESTING,
      variable: "Testing Flavor",
      //apiBaseUrl: "https://api.example.com/",
    );
  }

  static FlavorConfig getInstance() {
    if (_instance == null) {
      throw Exception("FlavorConfig must be initialized first");
    }
    return _instance!;
  }

  static void initialize(Flavor flavor) {
    switch (flavor) {
      case Flavor.DEVELOPMENT:
        _instance = FlavorConfig.development();
        break;
      case Flavor.TESTING:
        _instance = FlavorConfig.testing();
        break;
      default:
        throw Exception("Unknown flavor");
    }
  }
}
