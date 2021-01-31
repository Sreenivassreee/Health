import 'package:Health/models/PrefData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pref {

  static Future<prefMainModel> getMainPref() async {
    String _MainPId;
    String _MainEmail;
    String _MainName;
    String _MainPhotoUrl;
    String _MainMobile;
    String _MainAge;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(_MainPId = preferences.getString("id"));
    _MainEmail = preferences.getString("email");
    _MainName = preferences.getString("name");
    _MainPhotoUrl = preferences.getString("photoUrl");
    _MainMobile = preferences.getString("Mobile");
    _MainAge = preferences.getString("age");
    // print("mmain Pin i  $_MainPin");

    return prefMainModel(
      mainPId: _MainPId,
      mainEmail: _MainEmail,
      mainMobile: _MainMobile,
      mainName: _MainName,
      mainPhotoUrl: _MainPhotoUrl,
      mainAge: _MainAge,
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
      String age,
      String state,
      String quali}) async {
    String _mess;
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("name", name);
    _preferences.setString("Mobile", mobile);
    _preferences.setString("age", age);
    
    
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
    print("INSIDE Prif");
    print(user.name);
    print(user.uid);

    preferences.setString("name", user.name);
    preferences.setString("id", user.uid);
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
    String _MainMobile;
    String _MainAge;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    // _Mainid = preferences.getString("id");
    print(_MainPId = preferences.getString("id"));
    _MainEmail = preferences.getString("email");
    _MainName = preferences.getString("name");
    _MainPhotoUrl = preferences.getString("photoUrl");

    _MainMobile = preferences.getString("Mobile");

    _MainAge = preferences.getString("age");

    // print("mmain Pin i  $_MainPin");

    return prefMainModel(
      mainPId: _MainPId,
      mainEmail: _MainEmail,
      mainMobile: _MainMobile,
      mainName: _MainName,
      mainPhotoUrl: _MainPhotoUrl,
      mainAge: _MainAge,
    );
  }
}
