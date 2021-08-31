import 'package:hive/hive.dart';

/// Setting class that allows user to change privacy policy and authentication
/// 
/// We do not force user to share their contact data with others, in both the
/// real contagion, as well as in the simulation; as such, we **allow user to**
/// **make their profile private**. Moreover, users can also use biometric
/// authentication if they want to.
class Settings {
  bool authenticated;
  bool biometricAuthentication;
  Box settings;

  Settings(bool authenticated, bool biometricAuthentication) {
    this.authenticated = authenticated;
    this.biometricAuthentication = biometricAuthentication;
    settings = Hive.box("settings");
  }

  set setAuthenticated(bool value) {
    this.authenticated = value;
    settings.put("authenticated", value);
  }

  set setBiometrics(bool value) {
    this.biometricAuthentication = value;
    settings.put("biometricAuthentication", value);
  }

  bool get getAuthenticated => this.authenticated;
  bool get getBiometrics => this.biometricAuthentication;
}
