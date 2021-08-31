import 'package:unito_pandemic_decentralized/lang/Locale.dart';
import 'package:unito_pandemic_decentralized/model/settings.dart';
import 'package:unito_pandemic_decentralized/utils/resources.dart';

/// Main configurator element of the application
/// 
/// This class allows us to instantiate a new object to define the Locale, the
/// resource, and the settings element
class ConfigManager {
  Locale loc;
  Resources res;
  Settings gear;
  static ConfigManager _instance;
  factory ConfigManager() => _instance ??= new ConfigManager._();

  void init(Locale loc, Resources res, Settings gear) {
    this.loc = loc;
    this.res = res;
    this.gear = gear;
  }

  set locale(Locale loc) {
    this.loc = loc;
  }

  ConfigManager._();
}
