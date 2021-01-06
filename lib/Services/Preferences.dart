import 'package:Health/models/PrefData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  // static Future<String> InitiallSavePref(
  //     String gmailid, String displayName, String email, String photoUrl) async {
  //   String _mess;

  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString("name", displayName);
  //   preferences.setString("email", email);
  //   preferences.setString("photoUrl", photoUrl);
  //   preferences.setString("gmailId", gmailid);
  //   preferences.setString("Mobile", " ");
  //   preferences.setInt("Completed_level", 1);
  //   preferences.setInt("Score", 100);
  //   preferences.commit();
  //   _mess = "Sucess";
  // }

  // static Future<String> FromServerSavePref(
  //     {String id,
  //     String displayName,
  //     String email,
  //     String photoUrl,
  //     String gmailId,
  //     String Mobile,
  //     int CompletedLevels,
  //     int Score,
  //     String State,
  //     String Qualification,
  //     String pin,
  //     String about}) async {
  //   print("pin is $pin");
  //   String _mess;

  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString("name", displayName);
  //   preferences.setString("gmailId", gmailId.toString());
  //   preferences.setString("State", State);
  //   preferences.setString("Qualification", Qualification);
  //   preferences.setString("email", email);
  //   preferences.setString("photoUrl", photoUrl);
  //   preferences.setString("id", id);
  //   preferences.setString("Mobile", Mobile.toString());
  //   preferences.setInt("Completed_level", CompletedLevels);
  //   preferences.setInt("Score", Score);
  //   preferences.setString("pin", pin.toString());
  //   preferences.setString("about", about);

  //   _mess = "Sucess";
  //   return _mess;
  // }

  // static Future<String> saveScoringPref(int upLevel, int upScore) async {
  //   String _mess;
  //   SharedPreferences _preferences = await SharedPreferences.getInstance();
  //   _preferences.setInt("Completed_level", upLevel);
  //   _preferences.setInt("Score", upScore);
  //   _mess = "Sucess";
  //   return _mess;
  // }

  // static Future<String> saveOnlyScorePref(int upScore) async {
  //   String _mess;
  //   SharedPreferences _preferences = await SharedPreferences.getInstance();

  //   _preferences.setInt("Score", upScore);
  //   _mess = "Sucess";
  //   return _mess;
  // }

  static Future<prefMainModel> getMainPref() async {
    String _MainPId;
    String _MainEmail;
    String _MainName;
    String _MainPhotoUrl;
    int _MainCurrentLevel;
    String _MainMobile;
    int _MainCurrentScore;
    String _MainPin;
    String _MainState;
    String _MainEmailId;
    String _MainQuali;
    String _MainAbout;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(_MainPId = preferences.getString("id"));
    _MainEmail = preferences.getString("email");
    _MainName = preferences.getString("name");
    _MainPhotoUrl = preferences.getString("photoUrl");
    _MainCurrentLevel = preferences.getInt("Completed_level");
    _MainMobile = preferences.getString("Mobile");
    _MainCurrentScore = preferences.getInt("Score");
    _MainEmailId = preferences.getString("gmailId");
    _MainState = preferences.getString("State");
    _MainPin = preferences.getString("pin");
    _MainQuali = preferences.getString("Qualification");
    _MainAbout = preferences.getString("about");
    // print("mmain Pin i  $_MainPin");

    return prefMainModel(
      MainPId: _MainPId,
      MainCurrentLevel: _MainCurrentLevel,
      MainCurrentScore: _MainCurrentScore,
      MainEmail: _MainEmail,
      MainMobile: _MainMobile,
      MainName: _MainName,
      MainPhotoUrl: _MainPhotoUrl,
      MainPin: _MainPin,
      MainState: _MainState,
      EmailId: _MainEmailId,
      quali: _MainQuali,
      about: _MainAbout,
    );
  }

  static saveLoginStatusPrif() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("ISLOGIN", "TRUE");
    
  }

  static Future<String> saveLoginStatusPrifFalse() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("ISLOGIN", "FALSE");
    return "Sucess";
  }

  static Future<String> updateProfilePref(
      {String name,
      String mobile,
      String pin,
      String state,
      String quali}) async {
    String _mess;
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("name", name);
    _preferences.setString("Mobile", mobile);
    _preferences.setString("pin", pin);
    _preferences.setString("State", state);
    _preferences.setString("Qualification", quali);
    _mess = "Sucess";
    return _mess;
  }

  static Future<String> saveAboutPref({
    String about,
  }) async {
    String _mess;
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("about", about);
    _mess = "Sucess";
    return _mess;
  }

  static Future<String> getUpdateProfilePref(
      {String name,
      String mobile,
      String pin,
      String state,
      String quali}) async {
    String _mess;
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("name", name);
    _preferences.setString("Mobile", mobile);
    _preferences.setString("pin", pin);
    _preferences.setString("State", state);
    _preferences.setString("Qualification", quali);
    _mess = "Sucess";
    return _mess;
  }

  static Future<String> signOutPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("name", null);
    preferences.setString("gmailId", null);
    preferences.setString("State", null);
    preferences.setString("Qualification", null);
    preferences.setString("email", null);
    preferences.setString("photoUrl", null);
    preferences.setString("id", null);
    preferences.setString("Mobile", null);
    preferences.setString("Completed_level", null);
    preferences.setString("Score", null);
    preferences.setString("pin", null);
    preferences.setString("about", null);
    preferences.commit();
    return "Sucess";
  }
}

class FirePref {
  static Future<String> initialFirebasePrefSave(user) async {
    print("pref User is ${user.name}");
    String _mess;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(user.name);
    print(user.uid);

    preferences.setString("name", user.name);
    preferences.setString("id", user.uid);
    preferences.setString("State", user.state);
    preferences.setString("Qualification", user.qualification);
    preferences.setString("email", user.email);
    preferences.setString("photoUrl", user.photoUrl);
    preferences.setString("Mobile", user.mobile.toString());

    _mess = "Sucess";
    return _mess;
  }

  static Future<prefMainModel> getFireMainPref() async {
    String _MainPId;
    String _MainEmail;
    String _MainName;
    String _MainPhotoUrl;
    int _MainCurrentLevel;
    String _MainMobile;
    int _MainCurrentScore;
    String _MainPin;
    String _MainState;
    String _MainEmailId;
    String _MainQuali;
    String _MainAbout;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    // _Mainid = preferences.getString("id");
    print(_MainPId = preferences.getString("id"));
    _MainEmail = preferences.getString("email");
    _MainName = preferences.getString("name");
    _MainPhotoUrl = preferences.getString("photoUrl");
    _MainCurrentLevel = preferences.getInt("Completed_level");
    _MainMobile = preferences.getString("Mobile");
    _MainCurrentScore = preferences.getInt("Score");
    _MainEmailId = preferences.getString("gmailId");
    _MainState = preferences.getString("State");
    _MainPin = preferences.getString("pin");
    _MainQuali = preferences.getString("Qualification");
    _MainAbout = preferences.getString("about");
    // print("mmain Pin i  $_MainPin");

    return prefMainModel(
      MainPId: _MainPId,
      MainCurrentLevel: _MainCurrentLevel,
      MainCurrentScore: _MainCurrentScore,
      MainEmail: _MainEmail,
      MainMobile: _MainMobile,
      MainName: _MainName,
      MainPhotoUrl: _MainPhotoUrl,
      MainPin: _MainPin,
      MainState: _MainState,
      EmailId: _MainEmailId,
      quali: _MainQuali,
      about: _MainAbout,
    );
  }
}
