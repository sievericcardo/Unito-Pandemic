import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:unito_pandemic_decentralized/DashBoardActivity.dart';
import 'package:unito_pandemic_decentralized/HealtCareActivity.dart';
import 'package:unito_pandemic_decentralized/SettingsActivity.dart';
import 'package:unito_pandemic_decentralized/TutorialActivity.dart';
import 'package:unito_pandemic_decentralized/contactTracing.dart';
import 'package:unito_pandemic_decentralized/lang/EnglishLocale.dart';
import 'package:unito_pandemic_decentralized/lang/ItalianLocale.dart';
import 'package:unito_pandemic_decentralized/lang/LanguageActivity.dart';
import 'package:unito_pandemic_decentralized/model/db/simheard.dart';
import 'package:unito_pandemic_decentralized/model/settings.dart';
import 'package:unito_pandemic_decentralized/model/simbeacon.dart';
import 'package:path_provider/path_provider.dart' as provider;
import 'package:unito_pandemic_decentralized/utils/ConfigManager.dart';
import 'package:unito_pandemic_decentralized/utils/database.dart';
import 'package:unito_pandemic_decentralized/utils/resources.dart';

/*
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see http://www.gnu.org/licenses/
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbDirecotry = await provider.getApplicationDocumentsDirectory();
  Hive.init(dbDirecotry.path);
  await Hive.openBox('curSim');
  await Hive.openBox('randomStrings');
  await Hive.openBox('settings');
  await Hive.openBox('myself');
  MainController.initialize();
  runApp(MyApp());
}

bool registered = false;

/// Main application content
class MyApp extends AppMVC {
  MyApp({Key key}) : super(key: key);

  @override
  void initApp() {
    Box u = Hive.box('myself');
    if (u.get("password") != null) {
      print(u.get("password"));
      registered = true;
      Box s = Hive.box("settings");
      bool auth = false;
      bool biometric = s.get("biometricAuthentication");
      print(biometric);
      if (u.get("adv") == null) {
        u.put("adv", false);
      }
      if (u.get("lang") == "ita") {
        ConfigManager().init(new ItalianLocale(), new Resources(), new Settings(auth, biometric));
      } else {
        ConfigManager().init(new EnglishLocale(), new Resources(), new Settings(auth, biometric));
      }
    }
    if (u.get("name") == null) {
      u.put("name", "Antonio");
    }
    Nearby().askLocationPermission();
    super.initApp();
  }

  /// This is 'the View' for this application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        "/intro": (BuildContext context) => new TutorialActivity(),
        "/home": (BuildContext context) => new DashBoardActivity(),
        "/contacts": (BuildContext context) => new ContactTracingActivity(),
        "/health": (BuildContext context) => new HealthCareActivity(),
        "/settings": (BuildContext context) => new SettingsActivity(),
        //add more routes here
      },
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primarySwatch: Colors.purple,
      ),
      home: registered ? DashBoardActivity() : LanguageActivity(),
    );
  }
}

/// Controller for the main application. We also instantiate a first simbeacon.
class MainController extends ControllerMVC {
  static Future<void> initialize() async {
    //let's create a sqlite3 db if not present
    UnitoPandemicDatabase db =
        await $FloorUnitoPandemicDatabase.databaseBuilder('unitoPandemic.db').build();
    SimBeacon sb1 =
        new SimHeard("sdfuhdsffssdfasdasdasdsadasddsadasdasdadasddsafghgfhgf", 1591369216, 1);
    db.simBeaconDao.insertSimHeard(sb1);
  }
}

/*
 * Codename: Scarlett
 */
